SMODS.Blind{
    key = 'unik_epic_cookie',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true},
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 9},
    boss_colour= HEX("633b11"), 
    dollars = 13,
    jen_dollars = 25, --dollar change with almanac
    mult = 1,
    exponent = {1,1},
    jen_blind_exponent_resize = {1,1.3},
    loc_vars = function(self, info_queue, card)
        local string = ""
        if (SMODS.Mods["jen"] or {}).can_load then
            string = "" .. 1.01
        else
            string = "" .. 1.0025
        end
		return { vars = { string } }
	end,
	collection_loc_vars = function(self)
        local string = ""
        if (SMODS.Mods["jen"] or {}).can_load then
            string = "" .. 1.01
        else
            string = "" .. 1.0025
        end
		return { vars = { string } }
	end,
    
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
        --maybe its funnier to have it spawn even without stone hands in deck in almanac
        if G.GAME.modifiers.unik_legendary_at_any_time then
            return true
        end
        if (SMODS.Mods["jen"] or {}).can_load then
            return G.GAME.round > Jen.config.ante_threshold * 2
        else

            local hasExotic = false
            if not G.jokers or not G.jokers.cards then
                return false
            end
            
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.rarity == "cry_exotic" then
                    hasExotic = true
                end
            end
            return (G.GAME.round > 50 and hasExotic and Cryptid.gameset() ~= "modest") --only appear after round 50 in mainline cryptid, and you have an exotic at hand
        end
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
        if (SMODS.Mods["jen"] or {}).can_load then
            G.P_BLINDS.bl_unik_epic_cookie.exponent[2] = 1.3
        else
            G.P_BLINDS.bl_unik_epic_cookie.exponent[2] = 1
        end
        G.GAME.epic_cookie_click_interval = -1
        G.hand:change_size(G.GAME.decrementer_hand)
        G.GAME.decrementer_hand = 0
    end,
    unik_clicky_click_mod = function(self,prevent_rep)
        if G.SETTINGS.paused then
			return {1,1}
		else
            --only wiggle on click if inside the cookie or has this function, otherwise produce a sound indicating that the cookie is active.
            if G.GAME.blind.in_blind and (G.GAME.blind.name == 'bl_unik_cookie' or G.GAME.blind.name == 'bl_unik_epic_cookie' or G.GAME.blind.name == 'bl_cry_obsidian_orb') and G.GAME.blind.unik_clicky_click_mod then
                if not prevent_rep or prevent_rep == false then
                    if G.GAME.epic_cookie_click_interval >= 0 then
                        G.GAME.epic_cookie_click_interval = G.GAME.epic_cookie_click_interval + 1
                    end
                    G.GAME.blind.triggered = true
                    G.GAME.blind:wiggle()
                    G.ROOM.jiggle = G.ROOM.jiggle + 0.5
                    --destroy a random card in hand. Make sure it's not eternal
                    local validCards = {}
                    local selectedDest1 = nil
                    if G.hand then
                        for i,v in pairs(G.hand.cards) do
                            if (not v.ability.eternal) and (not v.ability.set_for_destruction) then
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
                    if G.GAME.epic_cookie_click_interval % 8 == 0 then
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
            --Syntax operators:
            -- -1 = +Reqs
            -- 0 = xReq
            -- 1 = ^Req
            -- 2 = ^^req, etc...
            --{Amount,operator}
            --For multiplication and exponentiation, ideally have it above 1.
            if (SMODS.Mods["jen"] or {}).can_load then
                return {1.01,1}
            else--cryptid is a bit more lenient
                return {1.001,1}
            end
			
		end
    end,
}

function selfDestruction_noMessage(card,dissolve)
    -- This part plays the animation.
    G.E_MANAGER:add_event(Event({
        func = function()
            --Dissolving
            if (dissolve) then
                card:start_dissolve()
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