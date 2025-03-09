SMODS.Atlas {
	key = "unik_the_plant",
	path = "unik_the_plant.png",
	px = 71,
	py = 95
}
SMODS.Joker {
	key = 'unik_the_plant',
    atlas = 'unik_the_plant',
    rarity = "cry_cursed",
	pos = { x = 0, y = 0 },
	-- soul_pos sets the soul sprite, used for legendary jokers and basically all of Jen's Jokers
	soul_pos = { x = 2, y = 0,extra = { x = 1, y = 0 } },
    cost = 1,
    config = { extra = {minFaceCards = 7, faceCards = 12, selfDestruct = false,debuff_name = "unik_plant"} },
    pools = { ["unik_boss_blind_joker"] = true, ["unik_copyrighted"] = true },
	blueprint_compat = false,
    perishable_compat = false,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.bl_plant
        --Nerf to requiring half of face cards destroyed (rounded to whole num), so its more in line with Blacklist's requirements
        return { vars = { center.ability.extra.minFaceCards,center.ability.extra.faceCards} }
	end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_unik_blind_start_plant'), G.C.UNIK_THE_PLANT, G.C.WHITE, 1.0 )
    end,
    add_to_deck = function(self, card, from_debuff)
        local faceCards = 0
        if G.deck then 
            for i, w in pairs(G.deck.cards) do
                if w:is_face(true) then
                    faceCards = faceCards + 1
                    SMODS.debuff_card(w,true,"unik_plant")
                end
            end
        end
        if G.hand then 
            for i, w in pairs(G.hand.cards) do
                if w:is_face(true) then
                    faceCards = faceCards + 1  
                    SMODS.debuff_card(w,true,"unik_plant")
                end
            end
        end
        if G.play then 
            for i, w in pairs(G.play.cards) do
                if w:is_face(true) then
                    faceCards = faceCards + 1  
                    SMODS.debuff_card(w,true,"unik_plant")                
                end
            end
        end
        if G.discard then 
            for i, w in pairs(G.discard.cards) do
                if w:is_face(true) then
                    faceCards = faceCards + 1     
                    SMODS.debuff_card(w,true,"unik_plant")             
                end
            end
        end 
        --set the min face cards needed
        card.ability.extra.minFaceCards = math.ceil(faceCards/2.0)
        card.ability.extra.cards = faceCards
        if faceCards == 0 and card.ability.extra.selfDestruct == false and G.jokers then
            selfDestruction(card,"k_unik_plant_no_face",HEX("709284"))
            card.ability.extra.selfDestruct = true
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.deck then 
            for i, w in pairs(G.deck.cards) do
                if w:is_face(true) then
                    SMODS.debuff_card(w,false,"unik_plant")
                end
            end
        end
        if G.hand then 
            for i, w in pairs(G.hand.cards) do
                if w:is_face(true) then
                    SMODS.debuff_card(w,false,"unik_plant")
                end
            end
        end
        if G.play then 
            for i, w in pairs(G.play.cards) do
                if w:is_face(true) then
                    SMODS.debuff_card(w,false,"unik_plant")
                end
            end
        end
        if G.discard then 
            for i, w in pairs(G.discard.cards) do
                if w:is_face(true) then
                    SMODS.debuff_card(w,false,"unik_plant")
                end
            end
        end 
	end,
    calculate = function(self, card, context)
        --Check if cards are destroyed, added or removed
        if context.playing_card_added or context.remove_playing_cards or context.cards_destroyed then
            local faceCards = 0
            --additional check to see if cards are removed via glass shattering or via tarots
            if context.cards_destroyed then
                for k, val in ipairs(context.glass_shattered) do
                    if val:is_face(true) then
                        faceCards = faceCards - 1
                    end
                end
            end
            if context.remove_playing_cards then
                for k, val in ipairs(context.removed) do
                    if val:is_face(true) then
                        faceCards = faceCards - 1
                    end
                end
            end
            if G.deck and card.added_to_deck then 
                for i, w in pairs(G.deck.cards) do
                    if w:is_face(true) then
                        SMODS.debuff_card(w,true,"unik_plant")
                        faceCards = faceCards + 1  
                    end
                end
            end
            if G.hand and card.added_to_deck then 
                for i, w in pairs(G.hand.cards) do
                    if w:is_face(true) then
                        SMODS.debuff_card(w,true,"unik_plant")
                        faceCards = faceCards + 1  
                    end
                end
            end
            if G.play and card.added_to_deck then 
                for i, w in pairs(G.play.cards) do
                    if w:is_face(true) then
                        SMODS.debuff_card(w,true,"unik_plant")
                        faceCards = faceCards + 1  
                    end
                end
            end
            if G.discard and card.added_to_deck then 
                for i, w in pairs(G.discard.cards) do
                    if w:is_face(true) then
                        SMODS.debuff_card(w,true,"unik_plant")
                        faceCards = faceCards + 1  
                    end
                end
            end 
            
            if card.added_to_deck then
                card.ability.extra.faceCards = faceCards
                if (faceCards < card.ability.extra.minFaceCards or faceCards <= 0) and card.ability.extra.selfDestruct == false and G.jokers then
                    selfDestruction(card,"k_unik_plant_no_face",HEX("709284"))
                    card.ability.extra.selfDestruct = true
                end
            end   
            return
        end
        if context.setting_blind and (G.GAME.blind and (G.GAME.blind.config.blind.name == "The Plant")) and not (G.GAME.blind.disabled) then
            selfDestruction(card,"k_unik_blind_start_plant",HEX("709284"))
            card.ability.extra.selfDestruct = true
        end
    end
}


