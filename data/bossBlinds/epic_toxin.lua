--first hand multiplies the blind size instead
SMODS.Blind	{
    key = 'unik_epic_toxin',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = HEX("2b1d41"),
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 31},
    vars = {},
    dollars = 13,
    mult = 0.5,
    unik_exponent = {1,0.7},
    debuff = {
        akyrs_blind_difficulty = "unik_epic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
    debuff_hand = function(self, cards, hand, handname, check)
        if check and G.GAME.current_round.hands_played == 0 then
            return true
        elseif G.GAME.current_round.hands_played > 0 and handname ~= G.GAME.unik_toxin_hand  then
             G.GAME.blind.triggered = true
            return true
        end
        return false
    end,
    get_loc_debuff_text = function(self)
        if G.GAME.current_round.hands_played == 0 then
            return localize("k_unik_toxin_1")
        else
            return localize("k_unik_toxin_2") .. localize(G.GAME.unik_toxin_hand, 'poker_hands')
        end
		
	end,
    set_blind = function(self, reset, silent)
        G.GAME.unik_toxin_hand = nil
	end,
    disable = function(self)
		G.GAME.unik_toxin_hand = nil
	end,
	defeat = function(self)
		G.GAME.unik_toxin_hand = nil
	end,
    unik_debuff_after_hand = function(self,poker_hands, scoring_hand,cards, check,sum)
		if G.GAME.current_round.hands_played == 0 then
            print(G.GAME.current_round.current_hand.handname)
            G.GAME.unik_toxin_hand = G.GAME.current_round.current_hand.handname
            local current = G.GAME.blind.chips
            print(sum)
            print((current * sum) - current)
            print((current * sum))
            print(current)
			return {
                debuff = true,
                add_to_blind = (current * sum) - current,
            }
		else
			return {
            debuff = false,
        }
		end
    end,
}