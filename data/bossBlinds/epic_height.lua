--all scoring is added to the blind size instead of score until the last hand
SMODS.Blind{
     key = 'unik_epic_height',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = HEX("185d7f"),
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 23},
    vars = {},
    dollars = 13,
    mult = 0.5,
    in_pool = function(self)
        return  CanSpawnEpic()
	end,
    pronouns = "any_all",
    debuff = {
        akyrs_blind_difficulty = "unik_epic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
    loc_vars = function(self)
        --.. localize('k_unik_reed_part2') .. ' ' .. G.GAME.unik_reed_ranks[3].rank .. 's'
		return { vars = {localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands')} }
	end,
	collection_loc_vars = function(self)
		return { vars = { localize('k_unik_height_placeholder')} }
	end,
    get_loc_debuff_text = function(self)
        if G.GAME.current_round.hands_left > 1 then
            return localize("k_unik_height_1")
        else
            return localize("k_unik_height_2") .. localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands')
        end
		
	end,
    set_blind = function(self, reset, silent)
        G.GAME.unik_dynamic_text_realtime = true
	end,
    disable = function(self)
		G.GAME.unik_dynamic_text_realtime = nil
	end,
	defeat = function(self)
		G.GAME.unik_dynamic_text_realtime = nil
	end,
    unik_debuff_after_hand = function(self,poker_hands, scoring_hand,cards, check,sum)
        if G.GAME.current_round.hands_left > 0 and not next(find_joker("j_cry_panopticon")) and not next(find_joker("cry-panopticon")) and not next(find_joker("j_paperback_the_world")) then
            G.GAME.unik_blind_extra_excess = sum
            if lenient_bignum(sum) <= lenient_bignum(0) and ((G.deck.cards and #G.deck.cards > 0) or (G.hand.cards and #G.hand.cards > 0)) then
                 ease_hands_played(1)
            end
            return {
                debuff = true,
                add_to_blind = sum,
            }
        end
        
        return {
            debuff = false,
        }
    end,
    debuff_hand = function(self, cards, hand, handname, check)
        if G.GAME.current_round.hands_left > 1 and not next(find_joker("j_cry_panopticon")) and not next(find_joker("cry-panopticon")) and not next(find_joker("j_paperback_the_world")) and check then
            G.GAME.blind.triggered = true
            return true
        elseif G.GAME.current_round.hands_left <= 1 and handname ~= G.GAME.current_round.most_played_poker_hand then
             G.GAME.blind.triggered = true
            return true
        end
        return false
    end,
}
