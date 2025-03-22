SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_dawn',
    atlas = 'placeholders',
    rarity = 1,
	pos = { x = 0, y = 0 },
    config = { extra = { x_mult = 1.75,shaking = false} },
    cost = 4,
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.x_mult} }
	end,
	gameset_config = {
		modest = {extra = {x_mult = 1.6,shaking = false} },
	},
    add_to_deck = function(self, card, context)
		--only shake if a blind has started
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.GAME.blind.in_blind then
					--Do not spam the shake
                    card.ability.extra.shaking = true
					local eval = function(card)
						return G.GAME.current_round.hands_played == 0 and card.ability.extra.shaking == true
					end
					juice_card_until(card, eval, true)
				end
				return true
			end
		}))
	end,
	load = function(self, card, card_table, other_card)
		--Do not spam the shake
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.GAME.blind.in_blind then
                    card.ability.extra.shaking = true
					--Do not spam the shake
					local eval = function(card)
						return G.GAME.current_round.hands_played == 0 and card.ability.extra.shaking == true
					end
					juice_card_until(card, eval, true)
				end
				return true
			end
		}))
	end,
    calculate = function(self, card, context)
		if context.joker_main and G.GAME.current_round.hands_played == 0 then
            card.ability.extra.shaking = false
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
				Xmult_mod = card.ability.extra.x_mult,
			}
		end
        if context.end_of_round and context.cardarea == G.jokers then
			card.ability.extra.shaking = false
		end
		if context.setting_blind then
            --Do not spam the shake
            card.ability.extra.shaking = true
            local eval = function(card)
                return G.GAME.current_round.hands_played == 0 and card.ability.extra.shaking == true
            end
            juice_card_until(card, eval, true)
		end
	end
}