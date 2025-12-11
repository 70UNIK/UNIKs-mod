--40826D
-- -3 hands, -3 discards, all 3s are debuffed, must not play 3 cards, hand must not contain a 3 of a kind

SMODS.Blind{
    key = 'unik_gabe_cant_count',
    config = {},
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 42},
    boss_colour= HEX("40826D"),
    dollars = 8,
    mult = 3,
    death_message = "special_lose_gaben",
    -- unik_exponent = {1,1.03},
    recalc_debuff = function(self, card, from_blind)
        if (card.area ~= G.jokers) and not G.GAME.blind.disabled and card:get_id() == 3 then
            return true
        end
        return false
	end,
    debuff_hand = function(self, cards, hand, handname, check)
		if next(hand["Three of a Kind"]) or #cards == 3 then	
            G.GAME.blind.triggered = true
			return true
		end
        
		return false
	end,
    set_blind = function(self, reset, silent)
        if not reset then
            G.hand:change_size(-1)
            ease_discard(-1)
            ease_hands_played(-1)
            G.GAME.blind.triggered = true
            G.GAME.blind:wiggle()

        end
	end,
    disable = function(self)
        ease_hands_played(1)
        ease_discard(1)
         G.hand:change_size(1)
	end,
	defeat = function(self)
        if not G.GAME.blind.disabled then
            G.hand:change_size(1)
        end
	end,
}