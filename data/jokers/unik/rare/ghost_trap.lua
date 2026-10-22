--If a cursed Joker is spawned, destroy it. It runs constantly if there are at least 1 cursed joker(s)
--For each destroyed cursed Joker, gain 1.5x Mult.
--If exceeding 8 cursed jokers, it will self destruct and RELEASE ALL CURSED JOKERS contained inside.
--Selling or its destruction will also release all cursed jokers.
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_ghost_trap',
    atlas = 'unik_normal_jokers',
    rarity = 3,
	pos = { x = 10, y = 0 },
    cost = 8,
	blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = true,
	experimental = true,
	demicoloncompat = true,
	attributes = { 'destroy_card','xmult','scaling','detriment','activated'},
    config = { extra = {x_mult = 1.0, x_mult_mod = 0.75,round_cooldown = 2,rounds_left = 0} },
	loc_vars = function(self, info_queue, center)
		return { key = center.ability.extra.rounds_left == 0 and 'j_unik_ghost_trap' or 'j_unik_ghost_trap_inactive', vars = {center.ability.extra.x_mult_mod,center.ability.extra.x_mult,center.ability.extra.round_cooldown ,center.ability.extra.rounds_left,
		colours = { 
			G.C.SECONDARY_SET.Enhanced
		}
	} }
	end,
	-- on self destruction, release all cursed jokers

    calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
			return {
				x_mult = card.ability.extra.x_mult
			}
		end
		if context.end_of_round and context.cardarea == G.jokers and card.ability.extra.rounds_left > 0 and not context.blueprint then
			card.ability.extra.rounds_left = card.ability.extra.rounds_left - 1
			if card.ability.extra.rounds_left > 0 then
				return {
					message = localize{type='variable',key='a_remaining',vars={card.ability.extra.rounds_left}},
					colour = G.C.MULT
				}	
			else
				return {
					message = localize('k_active_ex'),
					colour = G.C.MULT
				}	
			end
			
		end
    end,
	all_in_jest = {
        ability_cost = function(self, card)
             return 0
        end,
        can_use_ability = function(self, card, context)
			return G.unik_detriment_area and #G.unik_detriment_area.cards > 0 and card.ability.extra.rounds_left == 0
        end,

        use_ability = function(self, card, args)
			args = args or {}
            SMODS.calculate_context({all_in_jest = {joker_ability_used = true, card = card, retriggered = args.retriggered, args = args}})
			G.E_MANAGER:add_event(Event({
				func = function()
					if #G.unik_detriment_area.cards > 0 then
						local card_destroyed = pseudorandom_element(G.unik_detriment_area.cards,pseudoseed('unik_ghost_trap'))
						selfDestruction(card_destroyed,"k_unik_pentagram_purified",G.C.MULT)
						SMODS.scale_card(card, {
							ref_table =card.ability.extra,
							ref_value = "x_mult",
							scalar_value = "x_mult_mod",
							message_key = "a_xmult",
							message_colour = G.C.MULT,
							operation = '+',
							force_full_val = true,
						})	
						card.ability.extra.rounds_left = card.ability.extra.round_cooldown
					end
					
					return true
				end
			}))
		end,
    },
}

--ghost trap: if purchased/obtained, then ignore detrimentals/curseds
local alerter = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
	local totalJokers = #G.jokers.cards
	for i,v in pairs(G.jokers.cards) do
		if v.config.center.rarity == 'unik_detrimental' or v.config.center.rarity == 'cry_cursed'then
			totalJokers = totalJokers - 1
		end
	end
	if (card.ability.set == 'Joker' and card.config.center.key == 'j_unik_ghost_trap' and totalJokers < G.jokers.config.card_limit + card.ability.card_limit - card.ability.extra_slots_used) then
		return true
	end
	local res = alerter(card)
	return res
end