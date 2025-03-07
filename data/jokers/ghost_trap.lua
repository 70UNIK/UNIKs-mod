--If a cursed Joker is spawned, destroy it. It runs constantly if there are at least 1 cursed joker(s)
--For each destroyed cursed Joker, gain 1.5x Mult.
--If exceeding 8 cursed jokers, it will self destruct and RELEASE ALL CURSED JOKERS contained inside.
--Selling or its destruction will also release all cursed jokers.
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_ghost_trap',
    atlas = 'placeholders',
    rarity = 3,
	pos = { x = 2, y = 0 },
    cost = 7,
	blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = true,
    config = { extra = {x_mult = 1.0, x_mult_mod = 1.25,cursed_jokers = 0, cursed_joker_limit = 8, cursed_joker_list = {}} },
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.x_mult,center.ability.extra.x_mult_mod,center.ability.extra.cursed_jokers,center.ability.extra.cursed_joker_limit} }
	end,
	-- on self destruction, release all cursed jokers
	remove_from_deck = function(self, card, from_debuff)
		for _, v in pairs(card.ability.extra.cursed_joker_list) do

            G.E_MANAGER:add_event(Event({
                func = function()
                    local card2 = create_card("Joker", G.jokers, nil, nil, nil, nil,v.config.center.key)
                    card2:add_to_deck()
                    G.jokers:emplace(card2)
                    card2:start_materialize()
                    return true
                end
            }))
		end
	end,

    calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.x_mult) > to_big(1)) then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
				Xmult_mod = card.ability.extra.x_mult,
			}
		end
    end,
}