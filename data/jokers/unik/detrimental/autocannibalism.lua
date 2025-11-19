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
    atlas = 'unik_cursed',
    rarity = 'unik_detrimental',
    no_dbl = true,
	pos = { x = 0, y = 1 },
    cost = 1,
    config = { extra = { selfDestruct = false} },
	blueprint_compat = false,
    perishable_compat = false,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_decrementing_food_jokers" }
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_depleted" }
        return { vars = { center.ability.extra.selfDestruct} }
	end,
    immutable = true,
	add_to_deck = function(self, card, from_debuff)
        --add 1 random Eternal Depleted food joker
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            func = function()
                card:juice_up(0.8, 0.8)
                local card2 = create_card("autocannibalism_food", G.jokers, nil, nil, nil, nil, nil, "autocannibal")
                if card2.ability.name == "Turtle Bean" then
                    --prevent temporary hand size boost
                    card2.ability.extra.h_size = 0
                end
                card2:add_to_deck()
                G.jokers:emplace(card2)
                card2:start_materialize()
                return true
            end
        }))
        for _, v in pairs(G.jokers.cards) do
            --print("Joker in set:")
            --print(v.ability.name)
            if v.config.center.pools and v.config.center.pools.autocannibalism_food and not v.ability.unik_depleted then
                v.ability.eternal = true
                v.ability.unik_depleted = true
                if v.ability.name == "Turtle Bean" then
                    --cancel out hand size increase
                    G.hand:change_size(-v.ability.extra.h_size)
                    v.ability.extra.h_size = 0
                elseif  v.ability.name == "Ramen" then        
                    v.ability.extra.Xmult = 1       
                elseif v.ability.name == "Ice Cream" then
                    v.ability.extra.chips = 0
                elseif v.config.center.key == "j_cry_clicked_cookie" then 
                    v.ability.extra.chips = 0
                elseif v.config.center.key == 'j_unik_multesers' then
                    v.ability.extra.mult = 0
                elseif v.ability.name == "Popcorn" then
                    v.ability.extra.mult = 0
                elseif v.config.center.key == "j_mf_lollipop" then
                    v.ability.x_mult = 1
                elseif v.config.center.key == "j_paperback_nachos" then 
                    v.ability.extra.X_chips = 1
                elseif v.config.center.key == "j_cry_starfruit" then
                    v.ability.emult = 1
                elseif v.config.center.key == 'j_unik_brownie' then
                    v.ability.extra.x_mult = 1
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
                selfDestruction(v,'k_eaten_ex',G.C.BLACK)
            end
        end
    end,
    calculate = function(self, card, context)
        if context.unik_emplace and context.added and context.cardarea == G.jokers then
            if context.added.config.center.pools and context.added.config.center.pools.autocannibalism_food and not context.added.ability.unik_depleted then
                local v = context.added
                v.ability.eternal = true
                v.ability.unik_depleted = true
                if v.ability.name == "Turtle Bean" then
                    --cancel out hand size increase
                    G.hand:change_size(-v.ability.extra.h_size)
                    v.ability.extra.h_size = 0
                elseif  v.ability.name == "Ramen" then        
                    v.ability.extra.Xmult = 1       
                elseif v.ability.name == "Ice Cream" then
                    v.ability.extra.chips = 0
                elseif v.config.center.key == "j_cry_clicked_cookie" then 
                    v.ability.extra.chips = 0
                elseif v.config.center.key == 'j_unik_multesers' then
                    v.ability.extra.mult = 0
                elseif v.ability.name == "Popcorn" then
                    v.ability.extra.mult = 0
                elseif v.config.center.key == "j_mf_lollipop" then
                    v.ability.x_mult = 1
                elseif v.config.center.key == "j_paperback_nachos" then 
                    v.ability.extra.X_chips = 1
                elseif v.config.center.key == "j_cry_starfruit" then
                    v.ability.emult = 1
                elseif v.config.center.key == 'j_unik_brownie' then
                    v.ability.extra.x_mult = 1
                end
            end
        end
        if context.unik_remove_from_deck and context.removed then
            local exists = false
            for _, v in pairs(G.jokers.cards) do
                if v.config.center.pools and v.config.center.pools.autocannibalism_food and v ~= context.removed then
                    exists = true
                end
            end
            if not exists then
                selfDestruction(card,"k_eaten_ex",G.C.BLACK)
            end
        end
    end,
}