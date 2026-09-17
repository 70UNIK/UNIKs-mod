-- local groupHook = has_group_of
-- function has_group_of(num, hands)
--     if not hands then return false end

--     return groupHook(num,hands)
-- end
--scaling blinds will use scale_card instead so its easier to block from being copied
--The Snow (/)
--The Line (/)
--The Trench (/)
--Monolith (/)

 --exclude cursed tags
 SMODS.Joker:take_ownership("j_bld_matryoshka",{
    calculate = function(self, card, context)
            if context.setting_blind and card.ability.extra.last_tag then
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        add_tag(Tag(card.ability.extra.last_tag))
                        card:juice_up(0.65, 0.65)
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end
                }))
                delay(0.4)
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        add_tag(Tag(card.ability.extra.last_tag))
                        card:juice_up(0.65, 0.65)
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end
                }))
                return {

                }
            end
            if context.tag_triggered and not (context.tag_triggered.config and context.tag_triggered.config.extra and (context.tag_triggered.config.extra.hex or context.tag_triggered.config.extra.cannot_copy)) then
                print(inspect(context.tag_triggered))
                card.ability.extra.last_tag = context.tag_triggered.key
            end
        end,
        loc_vars = function (self, info_queue, card)
            info_queue[#info_queue+1] = card.ability.extra.last_tag and {key = card.ability.extra.last_tag, set = 'Tag'} or nil
            info_queue[#info_queue+1] = {key = 'tag_unik_blindside_cursed', set = 'Tag'}
            info_queue[#info_queue+1] = {key = 'tag_unik_blindside_wrench', set = 'Tag'}
            return {
                vars = {
                    card.ability.extra.last_tag and localize({key = card.ability.extra.last_tag, type = 'name_text', set = 'Tag'}) or localize("matryoshka_none")
                }
            }
        end
 },true)

--exquisite blinds:
--epic rarity equivalent
--stronger than premiums, weaker than legendaries
--examples include Pit Blinds and Hyperblinds

SMODS.Consumable:take_ownership('c_bld_assimilate',{
    use = function(self, card, area)
        local hues = {}
        for key, value in pairs(G.hand.highlighted[1].ability.extra.hues) do
            if not tableContains(value, hues) then
                table.insert(hues, value)
            end
        end
        for key, value in pairs(G.hand.highlighted[2].ability.extra.hues) do
            if not tableContains(value, hues) then
                table.insert(hues, value)
            end
        end

        local enhancements = BLINDSIDE.get_enhancements_with_exact_colors(hues)
        if #enhancements == 0 then
            error("UH OH, NO VALID HUE COMBO DETECTED! ")
        end
        local enhancement = pseudorandom_element(enhancements, pseudoseed("blindside_assimilate_" .. hues[1] .. hues[2]))
        local rand = pseudorandom(pseudoseed('blindside_assimilate2_'  .. hues[1] .. hues[2]))

        local card
        --merge trims and editions together. Upgrade if either one is upgraded
        local upgraded = G.hand.highlighted[1].ability.extra.upgraded or G.hand.highlighted[2].ability.extra.upgraded or false
        local trim = (not G.hand.highlighted[2].seal and G.hand.highlighted[1].seal) or (not G.hand.highlighted[1].seal and G.hand.highlighted[2].seal) or false
        local edition = (not G.hand.highlighted[2].edition and G.hand.highlighted[1].edition  and G.hand.highlighted[1].edition.key) or 
        (not G.hand.highlighted[1].edition and G.hand.highlighted[2].edition and G.hand.highlighted[2].edition.key) or false
        if rand > 0.5 then
            card = copy_card(G.hand.highlighted[1], nil, nil, G.playing_card)
            card:remove_sticker('bld_upgrade')
            G.GAME.bypass_reroll_block = true
            card:set_ability(G.P_CENTERS[enhancement])
            G.GAME.bypass_reroll_block = nil
            if G.hand.highlighted[1].ability.extra.upgraded or upgraded then
                upgrade_blinds({card}, nil, true)
            end
            if trim then
                card:set_seal(trim, nil, true)
            end
            if edition then
                card:set_edition(edition,true)
            end
        else
            card = copy_card(G.hand.highlighted[2], nil, nil, G.playing_card)
            card:remove_sticker('bld_upgrade')
            card:set_ability(enhancement)
            if G.hand.highlighted[2].ability.extra.upgraded or upgraded then
                upgrade_blinds({card}, nil, true)
            end
            if trim then
                card:set_seal(trim, nil, true)
            end
            if edition then
                card:set_edition(edition,true)
            end
        end
        
        G.hand:emplace(card)
        table.insert(G.playing_cards, card)
        destroy_blinds_and_calc(G.hand.highlighted, card)
        card:start_materialize()

        delay(0.5)
    end,
},true)

--ghostbuster to bypass taw

    BLINDSIDE.Blind:take_ownership('m_bld_lock',{
    calculate = function(self, card, context)
            if context.repetition and context.cardarea == G.play and context.other_card and card.facing ~= 'back' and card.ability.extra.upgraded and context.other_card.ability.extra.rescore ~= 1 then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
            if context.after and context.cardarea == G.play and card.facing ~= 'back' then
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local key = nil
                for i=1, #G.play.cards do
                    if G.play.cards[i].config.center_key == 'm_bld_key' and not G.play.cards[i].getting_sliced then
                        -- play lockpicking cutscene
                        card.ability.extra.pick_count = card.ability.extra.pick_count + 1
                        key = G.play.cards[i]
                        break
                    end
                end
                if key then
                    if card.ability.extra.pick_count == 1 then
                        local juiceit = true
                        G.E_MANAGER:add_event(Event({trigger = 'before', delay = 2 * G.SETTINGS.GAMESPEED, func = function()
                            key:juice_up()
                            card_eval_status_text(
                                key,
                                'extra',
                                nil, nil, nil,
                                {message = "Lockpicking...", colour = G.C.DARK_EDITION, instant = true}
                            )
                            juice_card_until(key, function ()
                                return juiceit
                            end)
                            return true
                        end}))
                        G.E_MANAGER:add_event(Event({trigger = 'before', delay = 1, func = function()
                            juiceit = false
                            card_eval_status_text(
                                card,
                                'extra',
                                nil, nil, nil,
                                {message = "Almost!", colour = G.C.DARK_EDITION, instant = true}
                            )
                            return true
                        end}))
                    elseif card.ability.extra.pick_count == 2 then
                        local juiceit = true
                        G.E_MANAGER:add_event(Event({trigger = 'before', delay = 2 * G.SETTINGS.GAMESPEED, func = function()
                            key:juice_up()
                            card_eval_status_text(
                                key,
                                'extra',
                                nil, nil, nil,
                                {message = "Lockpicking...", colour = G.C.DARK_EDITION, instant = true}
                            )
                            juice_card_until(key, function ()
                                return juiceit
                            end)
                            return true
                        end}))
                        G.E_MANAGER:add_event(Event({trigger = 'before', delay = 1, func = function()
                            juiceit = false
                            card_eval_status_text(
                                card,
                                'extra',
                                nil, nil, nil,
                                {message = "One More!", colour = G.C.DARK_EDITION, instant = true}
                            )
                            return true
                        end}))
                    elseif card.ability.extra.pick_count >= 3 then
                        key.getting_sliced = true
                        card.getting_sliced = true

                        local juiceit = true
                        G.E_MANAGER:add_event(Event({trigger = 'before', delay = 2 * G.SETTINGS.GAMESPEED, func = function()
                            key:juice_up()
                            card_eval_status_text(
                                key,
                                'extra',
                                nil, nil, nil,
                                {message = "Lockpicking...", colour = G.C.DARK_EDITION, instant = true}
                            )
                            juice_card_until(key, function ()
                                return juiceit
                            end)
                            return true
                        end}))
                        G.E_MANAGER:add_event(Event({trigger = 'before', delay = 1, func = function()
                            juiceit = false
                            card_eval_status_text(
                                card,
                                'extra',
                                nil, nil, nil,
                                {message = "Unlocked!", colour = G.C.DARK_EDITION, instant = true}
                            )
                            key:start_dissolve()
                            return true
                        end}))
                        G.E_MANAGER:add_event(Event({trigger = 'before', delay = 1, func = function()
                            card:start_dissolve()
                            return true
                        end}))
                        SMODS.calculate_context({remove_playing_cards = true, removed = {card, key}, scoring_hand = context.scoring_hand})

                        local copy_card = SMODS.create_card({ set = 'Base', enhancement = 'm_bld_door' })
                        copy_card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, copy_card)
                        G.hand:emplace(copy_card)
                        copy_card.states.visible = nil
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                copy_card:start_materialize()
                                return true
                            end
                        }))

                        -- ghostbuster
                        G.E_MANAGER:add_event(Event({
                            func = function ()
                                G.E_MANAGER:add_event(Event({
                                    func = function ()
                                        G.E_MANAGER:add_event(Event({
                                            func = function ()
                                                for key, value in pairs({card, key}) do
                                                    value.unik_bypass_taw = true
                                                    value:remove()
                                                end
                                                return true
                                            end
                                        }))
                                        return true
                                    end
                                }))
                                return true
                            end
                        }))
                        return {
                            func = function()
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        SMODS.calculate_context({ playing_card_added = true, cards = { copy_card } })
                                        return true
                                    end
                                }))
                            end
                        }
                    end
                end
            end
        end,
},true)

--quip override to only say cursed ones
for i=1,8 do
    SMODS.JimboQuip:take_ownership("bld_blindside_flippy_lose"..tostring(i),{
        filter = function(quip, type) 
            if type == "bld_loss" and not G.GAME.blind.config.blind.cursed then return true, {override_base_checks = true} end
        end
    },true)
end