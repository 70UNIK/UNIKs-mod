-- Pool used by autocannibalism
SMODS.ObjectType({
	key = "autocannibalism_food",
	default = "j_popcorn",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		-- insert base game food jokers
		self:inject_card(G.P_CENTERS.j_ice_cream)
		self:inject_card(G.P_CENTERS.j_turtle_bean)
		self:inject_card(G.P_CENTERS.j_popcorn)
		self:inject_card(G.P_CENTERS.j_ramen)
	end,
})
SMODS.Joker {
	key = 'unik_autocannibalism',
    atlas = 'placeholders',
    rarity = "cry_cursed",
	pos = { x = 3, y = 1 },
    cost = 1,
    config = { extra = { selfDestruct = false} },
	blueprint_compat = false,
    perishable_compat = false,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.j_ramen
        info_queue[#info_queue + 1] = G.P_CENTERS.j_popcorn
        info_queue[#info_queue + 1] = G.P_CENTERS.j_turtle_bean
        info_queue[#info_queue + 1] = G.P_CENTERS.j_ice_cream
        return { vars = { center.ability.extra.selfDestruct} }
	end,
	add_to_deck = function(self, card, from_debuff)
        --add 1 random Eternal Depleted food joker
        G.E_MANAGER:add_event(Event({
            func = function()
                card:juice_up(0.8, 0.8)
                local card2 = create_card("autocannibalism_food", G.jokers, nil, nil, nil, nil, nil, "autocannibal")
                card2:add_to_deck()
                G.jokers:emplace(card2)
                card2:start_materialize()
                return true
            end
        }))
        for _, v in pairs(G.jokers.cards) do
            --print("Joker in set:")
            --print(v.ability.name)
            if not v.ability.unik_depleted then
                if v.ability.name == "Turtle Bean" then
                    --cancel out hand size increase
                    G.hand:change_size(-v.ability.extra.h_size)
                    v.ability.unik_depleted = true
                    v.ability.eternal = true
                    v.ability.extra.h_size = 0
                elseif  v.ability.name == "Ramen" then
                    v.ability.unik_depleted = true
                    v.ability.eternal = true            
                    v.ability.x_mult = 1       
                elseif v.ability.name == "Ice Cream" then
                    v.ability.unik_depleted = true
                    v.ability.eternal = true    
                    v.ability.extra.chips = 0
                elseif v.ability.name == "Popcorn" then
                    v.ability.unik_depleted = true
                    v.ability.eternal = true    
                    v.ability.mult = 0
                end
            end
        end
	end,
    --destroy all depleted cards
    remove_from_deck = function(self,from_debuff)
        for _, v in pairs(G.jokers.cards) do
            --print("Joker in set:")
            --print(v.ability.name)
            if v.ability.unik_depleted then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        v.T.r = -0.2
                        v:juice_up(0.3, 0.4)
                        v.states.drag.is = true
                        v.children.center.pinch.x = true
                        -- This part destroys the card.
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.0,
                            blockable = false,
                            func = function()
                                card_eval_status_text(v, "extra", nil, nil, nil, {
                                    message = localize("k_eaten_ex"),
                                    colour = G.C.BLACK,
                                    card=v,
                                })
                                G.jokers:remove_card(v)
                                v:remove()
                                v = nil
                                return true;
                            end
                        }))
                        return true
                    end
                }))
            end
        end
    end
}