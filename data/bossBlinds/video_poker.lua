--video poker rules be like
--Known issues:
--Having the manacle in Video Poker will permanently reduce hand size by 1 after defeating video poker. Selling merry andy during this blind has the same effect
SMODS.Blind{
    key = 'unik_video_poker',
    config = {},
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 16},
    boss_colour= HEX("0000ff"),
    dollars = 8,
    mult = 0.4,
    pronouns = "he_him",
    death_message = "special_lose_unik_video_poker",
    set_blind = function(self, reset, silent)
        if not reset then
            if not next(SMODS.find_card('j_chicot')) then
                G.GAME.blind.discards_sub = G.GAME.current_round.discards_left
                ease_discard(-G.GAME.current_round.discards_left)
                ease_discard(1)
                G.GAME.unik_video_poker_rules = true

                G.GAME.unik_original_hand_size = G.hand.config.card_limit
                G.hand:change_size(-G.hand.config.card_limit + 5)
                local text = localize('k_unik_video_poker_start')
                attention_text({
                    scale = 0.8, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                })
                G.GAME.blind.triggered = true
                G.GAME.blind:wiggle()
            end

        end
	end,
    recalc_debuff = function(self, card, from_blind)
        if (card.area == G.jokers) and card.config.center.key == "j_cry_effarcire" then
            return true
        end
        return false
	end,
    --add 1 discard after a hand.
    unik_after_play = function(self)
        ease_discard(-G.GAME.current_round.discards_left)
        ease_discard(1)
    end,
    --if discards left, remove them
    unik_before_play = function(self)
        ease_discard(-G.GAME.current_round.discards_left)
    end,
    get_loc_debuff_text = function(self)
		return localize("k_unik_video_poker_warning")
	end,
    --debuff hand if a pair does not contain jacks or better. Note that splash will enable pairs to have only 1 jack, queen, king or ace
    debuff_hand = function(self, cards, hand, handname, check)
        local Splash = false
        for _, v in pairs(G.jokers.cards) do
            if v.config.center.key == "j_splash" then
                Splash = true
            end
        end
        --during initial selection
        if handname == 'Pair' and not G.GAME.blind.disabled and G.GAME.unik_video_poker_rules then
            local jacks = 0
            local queens = 0
            local kings = 0
            local aces = 0
            for k, v in ipairs(cards) do
                --if 2 jacks or better are visible, negate warning
                if v:get_id() == 11 then
                    jacks = jacks + 1
                elseif v:get_id() == 12 then
                    queens = queens + 1
                elseif v:get_id() == 13 then
                    kings = kings + 1
                elseif v:get_id() == 14 then
                    aces = aces + 1
                end
            end
            if jacks > 1 or queens > 1 or kings > 1 or aces > 1 then
                return false
            elseif Splash == true and (jacks > 0 or queens > 0 or kings > 0 or aces > 0) then
                return false
            else
                return true
            end
		elseif handname == "High Card" and not G.GAME.blind.disabled and G.GAME.unik_video_poker_rules then
            return true
        end
        return false
	end,
	disable = function(self)
        --avoid chicot permanently depleting hand size to 0 by only triggering if the killed by magnet flag is true
        if G.GAME.unik_video_poker_rules then
            G.GAME.unik_video_poker_rules = nil
            --Formula:
            --5 (BASE) + unexpected modifiers (selling merry andy,juggler, handcuff self destruct) = original hand size (around 8)
            G.hand:change_size(-G.hand.config.card_limit + G.GAME.unik_original_hand_size + (G.hand.config.card_limit - 5))
            ease_discard(-G.GAME.current_round.discards_left)
            ease_discard(G.GAME.blind.discards_sub)
            --redraw if you have effarcire
            if G.jokers then
                for _, v in pairs(G.jokers.cards) do
                    if v.config.center.key == "j_cry_effarcire" then
                        G.FUNCS.draw_from_deck_to_hand(#G.deck.cards)
                    end
                end
            end
        end
	end,
	defeat = function(self)
        if G.GAME.unik_video_poker_rules then
            G.GAME.unik_video_poker_rules = nil
            G.hand:change_size(-G.hand.config.card_limit + G.GAME.unik_original_hand_size + (G.hand.config.card_limit - 5))
        end
	end,
}

--Infinite card selection limit, but force play all cards in hand

local video_poker_play = G.FUNCS.can_play
G.FUNCS.can_play = function(e)
    if G.GAME.unik_video_poker_rules then
        if
			#G.hand.highlighted < #G.hand.cards
			or G.GAME.blind.block_play
		then
			e.config.colour = G.C.UI.BACKGROUND_INACTIVE
			e.config.button = nil
		else
			e.config.colour = G.C.BLUE
			e.config.button = "play_cards_from_highlighted"
		end
    else
        if not can_play_multilink() then
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
        else
            video_poker_play(e)
        end
    end
end