--HAS A RANDOM EFFECT!!!
--before scoring:

--creates a dental tag
--creates a random tag
--enhances a random blind,

--creates a symmetry tag
--creates a circles tag
--creates a peak tag
--editions a random blind,
--levels up hand

--nothing

--debuffs 2 other random blinds (itself excluded)
--creates a voodoo tag
--creats a soul tag
--creates an awe tag
--debuffs self


--on scoring
--X3 Mult,
--+25 Mult,
--+120 Chips,
--+$10,
--creates a random tag
---1 Mult to Joker,
--X0.75 Mult to joker,

---$3,
--X1.5 mult to joker,
--+1 Mult to Joker,
--+X0.25 base chips to joker,
--^1.05 Mult to Joker,
--X0.5 Mult,
---10 Mult,
---50 chips,
--flips all blinds in hand

--nothing

--triggers
--rescores a random blind 0-3 times
--retriggers self 0-3 times
--nothing

--Destruction chances
--Burns
--Self destructs,
--nothing
--
--burns all played blinds

--after
--creates a debuff tag for played hand
--

--upgrades a random played or held blind
--creates the cage and self destructs

--nothing

--upgrading increases chances of positive effects and reduces effect of negative effects

BLINDSIDE.Blind({
    key = 'unik_blindside_onion',
    atlas = 'unik_blindside_blinds',
    pos = {x = 7, y = 4},
    config = {
        extra = {
            value = 100,
            x_mult = 2,
            mult = 20,
            chips = 100,
            money = 10,
            bad_x_mult = 0.5,
            bad_mult = -18,
            bad_chips = -90,
            bad_money = -7,
            jokermult1 = 2,
            jokermult2 = -1,
            jokerxmult = 2,
            jokerxmult2 = 0.75,
            jokerpluschipssize = 0.5,
            destruction_randomizer = 0,
        }},
    hues = {"Faded"},
    rare = true,
    always_scores = true,
    calculate = function(self, card, context)
        if context.press_play then
            for i,v in pairs(G.play.cards) do
                card.onioned = nil
            end
        end
        --after_effects
        --destruction/burn chances
        if card.ability.extra.destruction_randomizer then
            if (card.ability.extra.destruction_randomizer < 0.4 and not card.ability.extra.upgraded) or (card.ability.extra.destruction_randomizer < 0.2 and not card.ability.extra.upgraded) and card.facing ~= 'back' then
                --burns self
                local upgrade_multiplier = not card.ability.extra.upgraded and 1 or 0.5 
                if card.ability.extra.destruction_randomizer < 0.2*upgrade_multiplier then
                    if context.burn_card and context.cardarea == G.play and context.burn_card == card then
                        return { remove = true }
                    end
                elseif card.ability.extra.destruction_randomizer < 0.35*upgrade_multiplier then
                    if context.burn_card and context.cardarea == G.play and card.area == G.play then
                        return { remove = true }
                    end
                elseif card.ability.extra.destruction_randomizer < 0.37*upgrade_multiplier then
                    if context.destroy_card and context.destroy_card == card and context.cardarea == G.play and card.area == G.play then
                        return { remove = true }
                    end
                else
                    if context.destroy_card and context.cardarea == G.play and context.destroy_card.onioned and card.area == G.play then
                        return { remove = true }
                    end
                end
            end
        end
        

        --after effects
        if context.cardarea == G.play and context.after and card.facing ~= 'back' then
            for i,v in pairs(context.scoring_hand) do
                card.onioned = nil
            end
            local random1 = pseudorandom('onion_after')
            if (random1 < 0.2 and not card.ability.extra.upgraded) or (random1 < 0.35 and card.ability.extra.upgraded) then
                local random2 = pseudorandom('onion_after_good')
                if random2 < 0.6 then
                    return {
                        focus = card,
                        message = localize('k_tagged_ex'),
                        func = function()
                            local pool = {"tag_bld_magic","tag_bld_memory","tag_bld_magic","tag_bld_magic"}
                            local tag_key = choose_stuff(pool, 1, "oniontagtrinket")[1]
                            add_tag(Tag(tag_key))   
                        end,
                        card = card
                    }
                elseif random2 < 0.995 then
                    local cards = {}
                    for i,v in pairs(context.scoring_hand) do
                        cards[#cards+1] = v 
                    end
                    for i,v in pairs(G.hand.cards) do
                        cards[#cards+1] = v 
                    end

                    G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 0.5,
                            func = function()
                                local card = pseudorandom_element(cards,'onion_upgrade')
                                upgrade_blinds({card})
                                return {
                                    message = localize('k_upgrade_ex'),
                                    colour = G.C.GREEN,
                                
                                }
                        end
                    }))
                elseif not card.ability.extra.to_be_destroyed then
                    card.ability.extra.to_be_destroyed  = true
                    local planet = create_card('bld_obj_ritual',G.consumeables, nil, nil, nil, nil, 'c_bld_blindsoul')
                    planet:add_to_deck()
                    G.consumeables:emplace(planet)
                    local cards = {}
                    cards[#cards+1] = card
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.destroy_cards(cards)
                                 print("DESTROY")
                            return true
                        end
                    }))
                end
            elseif (random1 > 0.85 and not card.ability.extra.upgraded) or (random1 > 0.95 and card.ability.extra.upgraded) and context.after and context.scoring_name and not card.ability.extra.upgraded and context.main_eval and tableContains(card, context.scoring_hand) then
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        G.bolt_played_hand = context.scoring_name
                        add_tag(Tag('tag_bld_debuff'))
                        return true
                    end
                }))
                return {
                    message = localize('k_unik_too_bad'),
                    card =  context.blueprint_card or card,
                    colour = G.C.BLACK,
                }

            else
            end
        end

        if context.unik_kite_experiment and context.scoring_hand and card.area == G.play then
            local random = math.min(3,math.floor(pseudorandom('onion_rescoring_amount') * 4))
            local validCards = {}
            for i = 1, random do
                local strct = {}
                local rescored_card = pseudorandom_element(context.scoring_hand, 'rescore_select')
                strct[#strct+1] = rescored_card
                strct.unik_scoring_segment = true
                validCards[#validCards+1] = strct
            end
            
            if #validCards > 0 then
                return {
                    target_cards = validCards,
                    card =  context.blueprint_card or card,
                    message = '+1',
                }
            end   
        end
        if context.repetition and card.facing ~= 'back' and context.other_card and context.other_card == card and context.other_card.ability.extra.rescore ~= 1 then

            return {
                repetitions = math.min(2,math.floor(pseudorandom('onion_rescoring_amount') * 3))
            }
        end
        --BEFORE SCORING
        if context.cardarea == G.play and context.before and card.facing ~= 'back' then
            if not context.blueprint then
                card.ability.extra.destruction_randomizer = pseudorandom('onion_destroy')
            end
            
            local random1 = pseudorandom('onion_before')
            --selecting card to destroy
            local validcards = {}
            for i,v in pairs(context.scoring_hand) do
                if (#context.scoring_hand == 1 and v == card) or v ~= card then
                    validcards[#validcards+1] = v
                end
            end
            local onioned = pseudorandom_element(validcards, pseudoseed("unik_destroy_other"))
            onioned.onioned = true
            --good
            if (random1 < 0.65 and not card.ability.extra.upgraded) or (random1 < 0.8 and card.ability.extra.upgraded) then
                card:flip()
                card:flip()
                local random2 = pseudorandom('onion_before_good')
                 local _cards = {}
                for k, v in ipairs(context.scoring_hand) do
                    if not v.edition and v ~= card then
                        _cards[#_cards+1] = v
                    end
                end
                if random2 < 0.2 then
                    add_tag(Tag(get_next_tag_key()))
                    return {
                        message = localize('k_tagged_ex'),
                        card =  context.blueprint_card or card,
                    }
                elseif random2 < 0.4 then
                    add_tag(Tag('tag_bld_dental'))
                    return {
                        message = localize('k_tagged_ex'),
                        card =  context.blueprint_card or card,
                    }
                elseif random2 < 0.6 then
                    local enhancement = pseudorandom_element(SMODS.ObjectTypes.bld_obj_enhancements.enhancements, 'booster')
                    local _cards = {}
                    for k, v in ipairs(context.scoring_hand) do
                        if not v.seal and v ~= card then
                            _cards[#_cards+1] = v
                        end
                    end
                    local selected_card, card_key = pseudorandom_element(_cards, pseudoseed('staff'))
                    selected_card:set_seal(enhancement, nil, true)
                elseif random2 < 0.7 and #_cards > 0 then
                    local edition = poll_edition(pseudoseed('shine_unik'), nil, true, true, BLINDSIDE.get_blindside_editions('none'))
                    local selected_card, card_key = pseudorandom_element(_cards, pseudoseed('onionedition'))
                    selected_card:set_edition(edition, true)
                elseif random2 < 0.8 then
                    add_tag(Tag('tag_bld_symmetry'))
                    return {
                        message = localize('k_tagged_ex'),
                        card =  context.blueprint_card or card,
                    }
                elseif random2 < 0.9 then
                    add_tag(Tag('tag_unik_blindside_peak'))
                    return {
                        message = localize('k_tagged_ex'),
                        card =  context.blueprint_card or card,
                    }
                else 
                    return {
                        card =  context.blueprint_card or card,
                        level_up = true,
                        message = localize('k_level_up_ex')
                    }
                end
                
            --bad
            elseif (random1 > 0.85 and not card.ability.extra.upgraded) or (random1 > 0.95 and card.ability.extra.upgraded) then
                local random2 = pseudorandom('onion_before_bad')
                
                if random2 < 0.2 then
                    if card.facing ~= 'back' then 
                        card:flip()
                    end
                    card_eval_status_text(card, "debuff", nil, nil, nil, nil)
                    return {
                    }
                elseif random2 < 0.4 then
                    
                    for j = 1, 2 do
                        local valid_cards = {}
                        for i,v in pairs(context.scoring_hand) do
                            if v ~= card and not v.debuffed_by_onion and v:bld_can_debuff_card_externally() then
                                valid_cards[#valid_cards+1] = v
                            end
                        end
                        local debuffcard = pseudorandom_element(valid_cards, pseudoseed('oniondebuff'))
                        debuffcard.config.center.blind_debuff(debuffcard, true)
                        debuffcard.debuffed_by_onion = true
                    end
                    card:flip()
                    card:flip()
                elseif random2 < 0.6 then
                    add_tag(Tag('tag_bld_voodoo'))
                    card:flip()
                    card:flip()
                    return {
                        message = localize('k_unik_too_bad'),
                        card =  context.blueprint_card or card,
                        colour = G.C.BLACK,
                    }
                    
                elseif random2 < 0.8 then
                    add_tag(Tag('tag_unik_blindside_soul'))
                    card:flip()
                    card:flip()
                    return {
                        message = localize('k_unik_too_bad'),
                        card =  context.blueprint_card or card,
                        colour = G.C.BLACK,
                    }
                    
                else
                    add_tag(Tag('tag_bld_awe'))
                    card:flip()
                    card:flip()
                    return {
                        message = localize('k_unik_too_bad'),
                        card =  context.blueprint_card or card,
                        colour = G.C.BLACK,
                    }
                    
                end
            --nothing
            else
                card:flip()
                card:flip()
                return {
                    message = localize('k_nope_ex'),
                }
            end
        end
        if context.cardarea == G.play and context.main_scoring and card.facing == 'back' then
            card_eval_status_text(card, "debuff", nil, nil, nil, nil)
            return {
            }
        elseif context.cardarea == G.play and context.main_scoring and card.facing ~= 'back' then
            local random1 = pseudorandom('onion_during')
            if (random1 < 0.6 and not card.ability.extra.upgraded) or (random1 < 0.8 and card.ability.extra.upgraded) then
                local random2 = pseudorandom('onion_during_good')
                if random2 < 0.25 then
                    return {
                        x_mult = card.ability.extra.x_mult
                    }
                elseif random2 < 0.5 then
                    return {
                        mult = card.ability.extra.mult
                    }
                elseif random2 < 0.75 then
                    return {
                        chips = card.ability.extra.chips
                    }
                elseif random2 < 0.82 then
                    return {
                        p_dollars = card.ability.extra.money
                    }
                elseif random2 < 0.9 then
                    
                    BLINDSIDE.chipsmodify(card.ability.extra.jokermult2, 0, 0)
                    return {
                        message = card.ability.extra.jokermult2 .. localize('k_unik_jmult'),
                        colour = G.C.BLACK,
                        card =  context.blueprint_card or card,
                    }
                elseif random2 < 0.96 then
                    UNIK.blindside_chips_modifyV2({x_mult = card.ability.extra.jokerxmult2}) 
                    return {
                        message = "X" .. card.ability.extra.jokerxmult2 .. localize('k_unik_jmult'),
                        colour = G.C.BLACK,
                        card =  context.blueprint_card or card,
                    }
                else
                    add_tag(Tag(get_next_tag_key()))
                    return {
                        message = localize('k_tagged_ex'),
                        card =  context.blueprint_card or card,
                    }
                end
            elseif (random1 > 0.78 and not card.ability.extra.upgraded) or (random1 > 0.95 and card.ability.extra.upgraded) then
                local random2 = pseudorandom('onion_during_bad')
                if random2 < 0.1 then
                    return {
                        x_mult = card.ability.extra.bad_x_mult
                    }
                elseif random2 < 0.2 then
                    return {
                        p_dollars = card.ability.extra.bad_money
                    }
                elseif random2 < 0.3 then
                    return {
                        chips = card.ability.extra.bad_chips
                    }
                elseif random2 < 0.4 then
                    return {
                        mult = card.ability.extra.bad_mult
                    }
                elseif random2 < 0.55 then
                    BLINDSIDE.chipsmodify(card.ability.extra.jokermult1, 0, 0)
                    return {
                        message = "+" .. card.ability.extra.jokermult1 .. localize('k_unik_jmult'),
                        colour = G.C.BLACK,
                        card =  context.blueprint_card or card,
                    }
                elseif random2 < 0.70 then
                    UNIK.blindside_chips_modifyV2({x_mult = card.ability.extra.jokerxmult}) 
                    return {
                        message = "X" .. card.ability.extra.jokerxmult .. localize('k_unik_jmult'),
                        colour = G.C.BLACK,
                        card =  context.blueprint_card or card,
                    }
                elseif random2 < 0.85 then
                    UNIK.blindside_chips_modifyV2({chips_base = card.ability.extra.jokerpluschipssize}) 
                    return {
                        message = "+X" .. card.ability.extra.jokerpluschipssize .. " " .. localize('k_unik_jchips_base'),
                        colour = G.C.BLACK,
                        card =  context.blueprint_card or card,
                    }
                else
                    local step = 0
                    for i, held_card in pairs(G.hand.cards) do
                        local stored_step = step
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.4,
                            func = function()
                                
                                held_card:juice_up()
                                held_card:flip()
                                if not held_card.ability.extra then
                                    held_card.ability.extra = {temp_flipped = true}
                                else
                                    if held_card.ability.extra.temp_flipped then
                                        held_card.ability.extra.temp_flipped = false
                                    else
                                        held_card.ability.extra.temp_flipped = true
                                    end
                                end
                                play_sound('chips1', 0.8 + (stored_step * 0.02))
                                card:juice_up()
                                G.ROOM.jiggle = G.ROOM.jiggle + 0.7    
                                return true
                            end
                        }))
                        step = step + 5
                    end
                end
            else
                return {
                    message = localize('k_nope_ex'),
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_onion_upgraded' or 'm_unik_blindside_onion'
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.upgraded = true
        end
    end
})