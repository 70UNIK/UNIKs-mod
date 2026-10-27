UNIK.detriment{
    key = "unik_incinerator",
    atlas = "unik_detriments",
	pos = { x = 3, y = 6 },
    config = { extra = { jokers_sold = 0,jokers_to_sell = 12} },
    severity = 3,
    immutable = true,
    dongtong_compat = false,
    blueprint_compat = true,
    attributes = { 'detrimental','destroy_card','jokers','detriment'},
     loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.jokers_to_sell,center.ability.extra.jokers_sold } }
	end,
    calculate = function(self, card, context)
        if context.setting_blind then
            G.E_MANAGER:add_event(Event({
                    func = function()
                        local cardr = nil
                        for i = #G.jokers.cards,1,-1 do
                            if not SMODS.is_eternal(G.jokers.cards[i],self) then
                                cardr = G.jokers.cards[i]
                                break
                            end
                        end
                        if cardr then
                            cardr.getting_sliced = true
                            selfDestruction(cardr,'k_unik_incinerator',G.C.BLACK,true)
                            card:juice_up()
                        end
                        
                        return true
                    end
                }))
            
        end
        if context.selling_card and not context.blueprint and context.card then
            if context.card.config.center.set == 'Joker' then
                card.ability.extra.jokers_sold = card.ability.extra.jokers_sold + 1
                if card.ability.extra.jokers_sold >= card.ability.extra.jokers_to_sell then
                    selfDestruction(card,'k_unik_weapon_destroyed',G.C.BLACK)
                else
                    return{
                        message = card.ability.extra.jokers_sold .. "/" .. card.ability.extra.jokers_to_sell,
                        colour = G.C.BLACK,
                    }
                end
            end
        end
    end
}