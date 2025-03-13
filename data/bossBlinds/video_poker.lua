--+2 Hand Size Convert 3 in 5 unenhanced cards in deck to steel cards, hand must not hold any steel cards
SMODS.Blind{
    key = 'unik_video_poker',
    config = {},
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 16},
    boss_colour= HEX("0000ff"),
    dollars = 8,
    mult = 1,
	loc_vars = function(self)
		return { vars = { "" .. ((Cryptid.safe_get(G.GAME, "probabilities", "normal") or 1) * 2), 3 } }
	end,
	collection_loc_vars = function(self)
		return { vars = { "" .. ((Cryptid.safe_get(G.GAME, "probabilities", "normal") or 1) * 2), 3 } }
	end,
    set_blind = function(self, reset, silent)
        if not reset then
            if not next(SMODS.find_card('j_chicot')) then
                ease_discard(-G.GAME.current_round.discards_left)
                ease_discard(1)
                G.GAME.unik_killed_by_video_poker = true
                G.GAME.unik_video_poker_rules = true
    
                self.handsize_mod = G.hand.config.card_limit - 5
                G.hand:change_size(-self.handsize_mod)
            end

        end
	end,
    --add 1 discard after a hand.
    cry_after_play = function(self)
        ease_discard(-G.GAME.current_round.discards_left)
        ease_discard(1)
    end,
    --if discards left, remove them
    cry_before_play = function(self)
        ease_discard(-G.GAME.current_round.discards_left)
    end,
    get_loc_debuff_text = function(self)
		return localize("k_unik_video_poker_warning")
	end,
    --debuff hand if a high card does not contain jacks or better
    debuff_hand = function(self, cards, hand, handname, check)
        --during initial selection
        if handname == 'High Card' and not G.GAME.blind.disabled then
            for k, v in ipairs(cards) do
                --if a jack or better is inside, negate the warning
                if v:get_id() == 11 or v:get_id() == 12 or v:get_id() == 13 or v:get_id() == 14 then
                    return false
                end
            end
            return true
		end
        return false
	end,
	disable = function(self)
        --avoid chicot permanently depleting hand size to 0 by only triggering if the killed by magnet flag is true
		if not G.GAME.blind.disabled then
            G.GAME.unik_killed_by_video_poker = nil
            G.GAME.unik_video_poker_rules = nil
            ease_discard(0)
            ease_discard(self.discards_sub)
            G.hand:change_size(self.handsize_mod)
        end
	end,
	defeat = function(self)
		if not G.GAME.blind.disabled then
            G.GAME.unik_killed_by_video_poker = nil
            G.GAME.unik_video_poker_rules = nil
            G.hand:change_size(self.handsize_mod)
        end
	end,
}