SMODS.Blind{
    key = 'unik_legendary_sword',
    config = {},
    boss = {min = 1,legendary = true,showdown = true}, 
    atlas = "unik_legendary_blinds",
    pos = {x=0, y=3},
    boss_colour= HEX("600000"), --all legendary blinds will be blood red and black.
    dollars = 13,
    mult = 66.6,
    gameset_config = {
		modest = { disabled = true},
	},
    ignore_showdown_check = true,
    set_blind = function(self, reset, silent)
        G.GAME.unik_killed_by_sword_legendary = true
        --set blind size to ^2.666x
        G.GAME.blind.discards_sub = G.GAME.current_round.discards_left
        ease_discard(-G.GAME.current_round.discards_left)
        G.GAME.blind.hands_sub = G.GAME.round_resets.hands - 1
        ease_hands_played(-G.GAME.blind.hands_sub)
        G.GAME.unik_original_hand_size = G.hand.config.card_limit
        G.hand:change_size(-G.hand.config.card_limit + 1)
	end,
    in_pool = function()
        local hasExotic = false
        if not G.jokers or not G.jokers.cards then
			return false
		end
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].config.center.rarity == "cry_exotic" then
                hasExotic = true
            end
        end
        if Cryptid.gameset() ~= "modest" and ((G.GAME.round >= 100 and hasExotic) or G.GAME.modifiers.unik_legendary_at_any_time) then
            return true
        end
        return false
    end,
    recalc_debuff = function(self, card, from_blind)
        if (card.area == G.jokers) and (card.config.center.key == "j_burglar" or card.config.center.key == "j_cry_effarcire") then
            return true
        end
        return false
	end,
    --somehow if that happens, set the base to be 
    disable = function(self)
        G.GAME.unik_killed_by_sword_legendary = nil
        ease_discard(G.GAME.blind.discards_sub)
        ease_hands_played(G.GAME.blind.hands_sub)
        G.hand:change_size(-G.hand.config.card_limit + G.GAME.unik_original_hand_size + (G.hand.config.card_limit - 1))
        if G.jokers then
            for _, v in pairs(G.jokers.cards) do
                if v.config.center.key == "j_cry_effarcire" then
                    G.FUNCS.draw_from_deck_to_hand(#G.deck.cards)
                end
            end
        end
	end,
	defeat = function(self)
        G.GAME.unik_killed_by_sword_legendary = nil
        G.hand:change_size(-G.hand.config.card_limit + G.GAME.unik_original_hand_size + (G.hand.config.card_limit - 1))
	end,
}