--If hand does not contain a flush, die.
--
SMODS.Blind	{
    key = 'unik_epic_sink',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = HEX("2f2f45"),
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 25},
    vars = {},
    dollars = 13,
    mult = 1,
	--must be localized
	
    debuff = {
        akyrs_blind_difficulty = "unik_epic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
    calculate = function(self, blind, context)
		if context.discard and not G.GAME.blind.disabled and G.GAME.unik_sink_killswitch > 0 and not G.GAME.unik_discard_buffer then
			local hands = evaluate_poker_hand(G.hand.highlighted)
            if next(hands["Flush"]) then
                G.GAME.unik_sink_killswitch = G.GAME.unik_sink_killswitch - 1
                G.GAME.blind.triggered = true
                G.GAME.blind:wiggle()
                G.GAME.unik_discard_buffer = true

            end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    G.GAME.unik_discard_buffer = nil
                    return true
                end
            }))
		end
	end,
    set_blind = function(self)
        G.GAME.unik_dynamic_text_realtime = true
        G.GAME.unik_sink_killswitch = 2
	end,
    loc_vars = function(self)
        local var = 2
        local char = ""
        if G.GAME.unik_sink_killswitch then
            var = G.GAME.unik_sink_killswitch
        end
        if var ~= 1 then
            char = "s"
        end
        return {vars = { var,char} }
	end,
	collection_loc_vars = function(self)
        return {vars = { 2,"s"} }
		
	end,
    debuff_hand = function(self, cards, hand, handname, check)
         if G.GAME.unik_sink_killswitch > 0 and check then
            return true
         end
         return false
    end,
    unik_debuff_after_hand = function(self,poker_hands, scoring_hand,cards, check,sum)
        if G.GAME.unik_sink_killswitch > 0 then
            local sum2 = math.ceil(sum)
            local digits = math.ceil(#tostring(sum2) / 2)
            print(sum2)
            ease_ante(to_number(digits))
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.blind.chips = ((get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling)*1)
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    G.HUD_blind:recalculate(true)
                    G.GAME.blind:set_text()
                    G.hand_text_area.blind_chips:juice_up()
                    play_sound('chips2')
                    return true
                end
            }))
            return {
                debuff = true,
            }
        end
        return {
            debuff = false,
        }
    end,
	defeat = function(self)
         G.GAME.unik_sink_killswitch = 2
         G.GAME.unik_dynamic_text_realtime = nil
	end,
    in_pool = function(self)
        if G.GAME.round_resets.discards < 3 then
            return false
        end
        return CanSpawnEpic()
	end,
}
