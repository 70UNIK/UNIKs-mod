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
    config = { extra = { selfDestruct = false,faceCards = true} },
    pools = { ["unik_boss_blind_joker"] = true, ["unik_copyrighted"] = true },
	blueprint_compat = false,
    perishable_compat = false,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.bl_plant
	end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_unik_blind_start_plant'), G.C.UNIK_THE_PLANT, G.C.WHITE, 1.0 )
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.deck then 
            for i, w in pairs(G.deck.cards) do
                if w:is_face(true) then
                    w:set_debuff(false)
                end
            end
        end
        if G.hand then 
            for i, w in pairs(G.hand.cards) do
                if w:is_face(true) then
                    w:set_debuff(false)
                end
            end
        end
        if G.play then 
            for i, w in pairs(G.play.cards) do
                if w:is_face(true) then
                    w:set_debuff(false)
                end
            end
        end
        if G.discard then 
            for i, w in pairs(G.discard.cards) do
                if w:is_face(true) then
                    w:set_debuff(false)
                end
            end
        end 
	end,
	update = function(self, card, dt)
        local hasFace = false
        if G.deck and card.added_to_deck then 
            for i, w in pairs(G.deck.cards) do
                if w:is_face(true) then
                    w:set_debuff(true)
                    hasFace = true
                end
            end
        end
        if G.hand and card.added_to_deck then 
            for i, w in pairs(G.hand.cards) do
                if w:is_face(true) then
                    w:set_debuff(true)
                    hasFace = true
                end
            end
        end
        if G.play and card.added_to_deck then 
            for i, w in pairs(G.play.cards) do
                if w:is_face(true) then
                    w:set_debuff(true)
                    hasFace = true
                end
            end
        end
        if G.discard and card.added_to_deck then 
            for i, w in pairs(G.discard.cards) do
                if w:is_face(true) then
                    w:set_debuff(true)
                    hasFace = true
                end
            end
        end 
        if card.added_to_deck then
            if hasFace == false and card.ability.extra.selfDestruct == false and G.jokers then
                selfDestruction(card,"k_unik_plant_no_face",HEX("709284"))
                card.ability.extra.selfDestruct = true
            end
        end
	end,
    calculate = function(self, card, context)
        if context.setting_blind and (G.GAME.blind and (G.GAME.blind.config.blind.name == "The Plant")) and not (G.GAME.blind.disabled) then
            selfDestruction(card,"k_unik_blind_start_plant",HEX("709284"))
            card.ability.extra.selfDestruct = true
        end
    end
}
