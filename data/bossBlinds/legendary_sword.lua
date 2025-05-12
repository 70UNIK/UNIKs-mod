SMODS.Atlas({ 
    key = "unik_legendary_sword", 
    atlas_table = "ANIMATION_ATLAS", 
    path = "unik_legendary_sword.png", 
    px = 34, 
    py = 34, 
frames = 21 })

SMODS.Blind{
    key = 'unik_legendary_sword',
    config = {},
    boss = {min = 1,legendary = true,showdown = true,no_orb = true}, 
    atlas = "unik_legendary_sword",
    pos = {x=0, y=0},
    boss_colour= HEX("9bafcf"), --all legendary blinds will be blood red and black.
    dollars = 13,
    gameset_config = {
		modest = { disabled = true},
	},
    mult = 1,
    glitchy_anim = true,
    exponent = {1,1.4666},
    jen_blind_exponent_resize = {2,2.1666},
    ignore_showdown_check = true,
    set_blind = function(self, reset, silent)
        G.GAME.unik_killed_by_sword_legendary = true
        --set blind size to ^2.666x
        G.GAME.blind.discards_sub = G.GAME.current_round.discards_left
        ease_discard(-G.GAME.current_round.discards_left - 666)
        G.GAME.blind.hands_sub = G.GAME.round_resets.hands - 1
        ease_hands_played(-G.GAME.blind.hands_sub)
        G.GAME.unik_original_hand_size = G.hand.config.card_limit
        G.hand:change_size(-G.hand.config.card_limit + 1)
	end,
    in_pool = function()
        return CanSpawnLegendary()
    end,
    --no fucking around this time
    cry_after_play = function(self)
        ease_hands_played(-G.GAME.current_round.hands_left)
        ease_hands_played(-666)
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
        ease_discard(G.GAME.blind.discards_sub + 666)
        ease_hands_played(G.GAME.blind.hands_sub)
        G.hand:change_size(-G.hand.config.card_limit + G.GAME.unik_original_hand_size + (G.hand.config.card_limit - 1))
        if G.jokers then
            for _, v in pairs(G.jokers.cards) do
                if v.config.center.key == "j_cry_effarcire" then
                    G.FUNCS.draw_from_deck_to_hand(#G.deck.cards)
                end
            end
        end
        if(SMODS.Mods["jen"] or {}).can_load then
            G.GAME.blind.chips = G.GAME.blind.chips/(G.GAME.blind.chips^2.1666)
        else
            G.GAME.blind.chips = G.GAME.blind.chips/(G.GAME.blind.chips^1.4666)
        end
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        G.HUD_blind:recalculate(true)
	end,
	defeat = function(self)
        G.GAME.unik_killed_by_sword_legendary = nil
        G.hand:change_size(-G.hand.config.card_limit + G.GAME.unik_original_hand_size + (G.hand.config.card_limit - 1))
	end,
}