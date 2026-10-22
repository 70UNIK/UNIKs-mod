UNIK.detriment{
    key = "unik_inflation",
    atlas = "unik_detriments",
	pos = { x = 2, y = 2 },
    config = { extra = { price_hike = 2,blinds_skipped = 0,skips = 3} },
    severity = 1,
    immutable = true,
    dongtong_compat = false,
    attributes = { 'detrimental','lose_economy','detriment'},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.price_hike,card.ability.extra.skips,card.ability.extra.blinds_skipped} }
	end,
    calculate = function(self, card, context)
		if context.skip_blind then
            card.ability.extra.blinds_skipped = card.ability.extra.blinds_skipped + 1
            if card.ability.extra.blinds_skipped > card.ability.extra.skips then
                selfDestruction(card,"k_unik_deflated",G.C.BLACK)
            else
                return{
                    message = card.ability.extra.blinds_skipped .. "/" .. card.ability.extra.skips,
                    colour = G.C.BLACK,
                }
            end
        end
    end,
    add_to_deck = function (self, card, from_debuff)
        G.GAME.inflation = G.GAME.inflation  or 0
        G.GAME.inflation  = G.GAME.inflation  + card.ability.extra.price_hike
        G.E_MANAGER:add_event(Event({func = function()
            for k, v in pairs(G.I.CARD) do
                if v and v.config and v.config.center and v.config.center.set == 'Detriment' or v and v.ability and v.ability.set and v.ability.set == 'Detriment' then
                elseif v.set_cost then 
                    v:set_cost() 

                end 
            end
        return true end }))
    end,

    remove_from_deck = function (self, card, from_debuff)
        G.GAME.inflation = G.GAME.inflation  or 0
        G.GAME.inflation  = G.GAME.inflation  - card.ability.extra.price_hike
        G.E_MANAGER:add_event(Event({func = function()
            for k, v in pairs(G.I.CARD) do
                if v and v.config and v.config.center and v.config.center.set == 'Detriment' or v and v.ability and v.ability.set and v.ability.set == 'Detriment' then
                elseif v.set_cost then 
                    v:set_cost() 

                end 
                
            end
        return true end }))
    end
}

-- local set_cost_ref = Card.set_cost
-- function Card.set_cost(self)
--     local cards = SMODS.find_card('detr_unik_inflation', false)

--     local hike = 0

--     for k, v in ipairs(cards) do
--         hike = hike + v.ability.extra.price_hike
--     end
    
--     local ret = set_cost_ref(self)
--     self.cost = math.max(1, math.floor(((self.base_cost + self.extra_cost + 0.5)*(100-G.GAME.discount_percent)/100)+hike))
--     self.sell_cost = math.max(1, math.floor(self.cost)) + (self.ability.extra_value or 0)
    
    
--     return ret
-- end