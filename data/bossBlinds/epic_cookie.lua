SMODS.Blind{
    key = 'unik_epic_cookie',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 9},
    boss_colour= HEX("633b11"), 
    dollars = 13,
    mult = 1,
    unik_exponent = {1,1},
    pronouns = "he_him",
    loc_vars = function(self, info_queue, card)
        local string = ""
        string = "" .. 1.005
		return { vars = { string } }
	end,
	collection_loc_vars = function(self)
        local string = ""
        string = "" .. 1.005
		return { vars = { string } }
	end,
    debuff = {
        akyrs_blind_difficulty = "unik_epic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
        unik_all_unskippable_blinds = true,
    },
    death_message = "special_lose_unik_epic_cookie",
    set_blind = function(self, reset, silent)
        if not reset then
            local text = localize('k_unik_epic_cookie_start')
            attention_text({
                scale = 0.9, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = HEX("633b11")
            })
            G.GAME.decrementer_hand = 0
            G.GAME.epic_cookie_click_interval = 0
        end
    end,
	in_pool = function(self)
        return  CanSpawnEpic()
	end,
    disable = function(self)
        G.GAME.epic_cookie_click_interval = -1
        G.hand:change_size(G.GAME.decrementer_hand)
        G.GAME.decrementer_hand = 0
    end,
    defeat = function(self)
        G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        G.P_BLINDS.bl_unik_epic_cookie.mult = 0
        G.P_BLINDS.bl_unik_epic_cookie.unik_exponent[2] = 1
        G.GAME.epic_cookie_click_interval = -1
        G.hand:change_size(G.GAME.decrementer_hand)
        G.GAME.decrementer_hand = 0
    end,
    unik_clicky_click_mod = function(self,prevent_rep)
        if G.SETTINGS.paused then
			return {1,1}
		else
            --only wiggle on click if inside the cookie or has this function, otherwise produce a sound indicating that the cookie is active.
            if G.GAME.blind.in_blind and (G.GAME.blind.name == 'bl_unik_cookie' or G.GAME.blind.name == 'bl_unik_epic_cookie' or G.GAME.blind.name == 'cry-Obsidian Orb') and G.GAME.blind.unik_clicky_click_mod then
                if not prevent_rep or prevent_rep == false then
                    if G.GAME.epic_cookie_click_interval >= 0 then
                        G.GAME.epic_cookie_click_interval = G.GAME.epic_cookie_click_interval + 1
                    end
                    G.GAME.blind.triggered = true
                    G.GAME.blind:wiggle()
                    G.hand_text_area.blind_chips:juice_up()
                    play_sound('chips2')
                    G.ROOM.jiggle = G.ROOM.jiggle + 0.5
                    --destroy a random card in hand. Make sure it's not eternal
                    local validCards = {}
                    local selectedDest1 = nil
                    if G.hand then
                        for i,v in pairs(G.hand.cards) do
                            if (not SMODS.is_eternal(v, self)) and (not v.ability.set_for_destruction) then
                                validCards[#validCards + 1] = v
                            end
                        end
                    end
                    if G.hand and #validCards > 0 then 
                        selectedDest1 = pseudorandom_element(validCards, pseudoseed("unik_epic_cookie_destroy1"))
                        selectedDest1.ability.set_for_destruction = true
                    end

                    --destroy listed cards
                    if selectedDest1 ~= nil then
                        --this repeats for some reason...
                        selfDestruction_noMessage(selectedDest1,true)
                        --print("boom")
                    end


                    --decrease hand size by 1 
                    if G.GAME.epic_cookie_click_interval % 8 == 0 and G.hand.config.card_limit > 0 then
                        G.GAME.decrementer_hand = G.GAME.decrementer_hand + 1
                        G.hand:change_size(-1)
                    end
                end
            else
                if not prevent_rep or prevent_rep == false then
                    play_sound('cancel', 0.8, 1)
                    G.ROOM.jiggle = G.ROOM.jiggle + 0.5
                end
            end
            return {1.005,1}
		end
    end,
}

--Add context for Just before cards are played
local pcfh = G.FUNCS.play_cards_from_highlighted
function G.FUNCS.play_cards_from_highlighted(e)
	G.GAME.before_play_buffer2 = true

    if G.GAME.blind_edition and G.GAME.blind_edition[G.GAME.blind_on_deck] and not reset and (G.GAME.blind and G.GAME.blind.name and G.GAME.blind.name ~= '') then
        local edi = G.P_BLIND_EDITIONS[G.GAME.blind_edition[G.GAME.blind_on_deck]]
        if edi.unik_before_play and (type(edi.unik_before_play) == "function") then
            edi:unik_before_play()
        end
    end
    --Steel blind edition, each held card

    --Epic cookie: Deselect cards pending destruction
    for i=1, #G.hand.highlighted do
        if G.hand.highlighted[i] and G.hand.highlighted[i].ability and G.hand.highlighted[i].ability.set_for_destruction then
            G.hand:remove_from_highlighted(G.hand.highlighted[i])
        end
    end
    --Only play if highlight cards are > 0
    if Cryptid then
        if #G.hand.highlighted == 0 and (Cryptid.enabled("set_cry_poker_hand_stuff") == true) and G.PROFILES[G.SETTINGS.profile].cry_none then
            G.PROFILES[G.SETTINGS.profile].cry_none = true
        end
    end

    --Now that none hand is enabled, no need to disable playing hopefully it unlocks none hand by then
    if (not Cryptid or (Cryptid.enabled("set_cry_poker_hand_stuff") ~= true)) and #G.hand.highlighted == 0 then
        
    else
        G.GAME.blind:unik_before_play()
        SMODS.calculate_context({on_select_play = true})

        --Polymino autoselect all cards in selected group
        local id = {}

        if G.hand and G.hand.highlighted then
            for i = 1, #G.hand.highlighted do
                if G.hand.highlighted[i] and G.hand.highlighted[i].ability and G.hand.highlighted[i].ability.group then
                    id[G.hand.highlighted[i].ability.group.id] = true
                end
            end
        end
        if id and #id > 0 then
            for i,v in pairs(G.hand.cards) do
                for j,x in pairs(id) do
                    if v and v.ability and v.ability.group and v.ability.group.id == j and not v.highlighted then
                        G.hand:brute_force_highlight(v)
                    end
                end
            end
        end
        --end

        pcfh(e)
    end
	G.GAME.before_play_buffer2 = nil
end

--As playing a hand is one_click, it means if lets say a card being played just happened to be disabled, then

function selfDestruction_noMessage(card,dissolve)
    -- This part plays the animation.
    G.E_MANAGER:add_event(Event({
        func = function()
            --Dissolving
            if (dissolve) then
                if SMODS.shatters(card) then
                    card:shatter()
                else
                    card:start_dissolve()
                end
            --extinct animation
            else
                play_sound('tarot1')
                card.T.r = -0.2
                card:juice_up(0.3, 0.4)
                card.states.drag.is = true
                card.children.center.pinch.x = true
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    blockable = false,
                    func = function()
                        G.jokers:remove_card(card)
                        card:remove()
                        card = nil
                        return true;
                    end
                }))
            end
            
            return true
        end
    }))
end