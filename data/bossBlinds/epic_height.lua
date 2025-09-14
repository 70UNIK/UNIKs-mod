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
    mult = 2,
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
        end
        return false
    end,
}
