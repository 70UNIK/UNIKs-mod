UNIK.detriment{
    key = "unik_perishable_in_a_bottle",
    atlas = "unik_detriments",
	pos = { x = 2, y = 3},
    -- config = { extra = { jokers_sold = 0,jokers_to_sell = 12} },
    severity = 3,
    immutable = true,
    dongtong_compat = false,
    blueprint_compat = true,
    attributes = { 'detrimental','destroy_card','joker','detriment'},
     loc_vars = function(self, info_queue, center)
        if not center.ability.perishable then
            info_queue[#info_queue + 1] = {key = 'perishable', set = 'Other', vars = {G.GAME.perishable_rounds or 1, G.GAME.perishable_rounds or G.GAME.perishable_rounds}}
        end
       -- return { vars = { center.ability.extra.jokers_to_sell,center.ability.extra.jokers_sold } }
	end,
    calculate = function(self, card, context)
        --standard perishable
        if context.end_of_round and context.cardarea == G.unik_detriment_area then
            for i,v in pairs(G.jokers.cards) do
                if v and v.ability and v.ability.perishable and v.ability.perish_tally and v.ability.perish_tally <= 0 then
                    selfDestruction(card,'k_unik_perished',G.C.PERISHABLE)
                    return true
                end
            end
           for i = 1, #G.jokers.cards do
                        if not G.jokers.cards[i].ability.perishable and not G.jokers.cards[i].ability.unik_decaying then
                            if G.jokers.cards[i].config.center.perishable_compat then
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        G.jokers.cards[i].ability.perishable = true
                                        G.jokers.cards[i].ability.perish_tally = G.GAME.perishable_rounds
                                        G.jokers.cards[i]:juice_up()
                                        return true
                                    end,
                                }))
                                    
                                    return {
                                        message = localize('k_unik_perishing') --[[index]], 
                                        colour = G.C.PERISHABLE
                                    }
                            end
                        end 

                    end
            
            return {
                
            }
        end
        if context.unik_perishing_joker and context.card.config.center.set == 'Joker' then
            selfDestruction(card,'k_unik_perished',G.C.PERISHABLE)
        end
        
    end
}