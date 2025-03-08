--Transferrable function designed to be used for all suit based jokers
SMODS.Joker {
	key = 'unik_headless_joker',
    atlas = 'unik_cursed',
    rarity = "cry_cursed",
	pos = { x = 2, y = 0 },
    cost = 1,
    config = { extra = {minCards = 7, cards = 13, selfDestruct = false,suit = "Hearts"} },
    pools = { ["unik_boss_blind_joker"] = true},
	blueprint_compat = false,
    perishable_compat = false,
    loc_vars = function(self, info_queue, center)
        --Nerf to requiring half of cards destroyed (rounded to whole num), so its more in line with Blacklist's requirements
        return { vars = { center.ability.extra.minCards,center.ability.extra.cards} }
	end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_unik_blind_start_head'), G.C.UNIK_THE_HEAD, G.C.WHITE, 1.0 )
    end,
    add_to_deck = function(self, card, from_debuff)
        local Cards = 0
        if G.deck and card.added_to_deck then 
            for i, w in pairs(G.deck.cards) do
                --bypass debuff to ensure it doesnt self destruct
                if w:is_suit(card.ability.extra.suit,true) then
                    Cards = Cards + 1
                    SMODS.debuff_card(w,true,"unik_head")
                end
            end
        end
        if G.hand and card.added_to_deck then 
            for i, w in pairs(G.hand.cards) do
                if w:is_suit(card.ability.extra.suit,true) then
                    Cards = Cards + 1     
                    SMODS.debuff_card(w,true,"unik_head")           
                end
            end
        end
        if G.play and card.added_to_deck then 
            for i, w in pairs(G.play.cards) do
                if w:is_suit(card.ability.extra.suit,true) then
                    Cards = Cards + 1  
                    SMODS.debuff_card(w,true,"unik_head")
                end
            end
        end
        if G.discard and card.added_to_deck then 
            for i, w in pairs(G.discard.cards) do
                if w:is_suit(card.ability.extra.suit,true) then
                    Cards = Cards + 1     
                    SMODS.debuff_card(w,true,"unik_head")
                end
            end
        end 
        --set the min cards needed
        card.ability.extra.minCards = math.ceil(Cards/2.0)
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.deck then 
            for i, w in pairs(G.deck.cards) do
                --bypass debuff to ensure it doesnt self destruct
                if w:is_suit(card.ability.extra.suit,true) then
                    SMODS.debuff_card(w,false,"unik_head")
                end
            end
        end
        if G.hand then 
            for i, w in pairs(G.hand.cards) do
                if w:is_suit(card.ability.extra.suit,true) then
                    SMODS.debuff_card(w,false,"unik_head")          
                end
            end
        end
        if G.play then 
            for i, w in pairs(G.play.cards) do
                if w:is_suit(card.ability.extra.suit,true) then
                    SMODS.debuff_card(w,false,"unik_head")                  
                end
            end
        end
        if G.discard then 
            for i, w in pairs(G.discard.cards) do
                if w:is_suit(card.ability.extra.suit,true) then
                    SMODS.debuff_card(w,false,"unik_head")                      
                end
            end
        end 
	end,
    calculate = function(self, card, context)
        if context.cards_destroyed or context.playing_card_added or context.remove_playing_cards then
            local Cards = 0
            if G.deck and card.added_to_deck then 
                for i, w in pairs(G.deck.cards) do
                    --bypass debuff to ensure it doesnt self destruct
                    if w:is_suit(card.ability.extra.suit,true) then
                        Cards = Cards + 1
                        SMODS.debuff_card(w,true,"unik_head")
                    end
                end
            end
            if G.hand and card.added_to_deck then 
                for i, w in pairs(G.hand.cards) do
                    if w:is_suit(card.ability.extra.suit,true) then
                        Cards = Cards + 1     
                        SMODS.debuff_card(w,true,"unik_head")           
                    end
                end
            end
            if G.play and card.added_to_deck then 
                for i, w in pairs(G.play.cards) do
                    if w:is_suit(card.ability.extra.suit,true) then
                        Cards = Cards + 1  
                        SMODS.debuff_card(w,true,"unik_head")
                    end
                end
            end
            if G.discard and card.added_to_deck then 
                for i, w in pairs(G.discard.cards) do
                    if w:is_suit(card.ability.extra.suit,true) then
                        Cards = Cards + 1     
                        SMODS.debuff_card(w,true,"unik_head")
                    end
                end
            end 
            if card.added_to_deck then
                card.ability.extra.cards = Cards
                if (Cards < card.ability.extra.minCards or Cards <= 0) and card.ability.extra.selfDestruct == false and G.jokers then
                    selfDestruction(card,"k_unik_headless_rotted",HEX("ac9db4"))
                    card.ability.extra.selfDestruct = true
                end
            end
            return
        end
        if context.setting_blind and (G.GAME.blind and (G.GAME.blind.config.blind.name == "The Head")) and not (G.GAME.blind.disabled) then
            selfDestruction(card,"k_unik_blind_start_head",HEX("ac9db4"))
            card.ability.extra.selfDestruct = true
        end
    end
}
