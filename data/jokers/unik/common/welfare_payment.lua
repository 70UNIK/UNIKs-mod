SMODS.Joker {
    key = 'unik_welfare_payment',
    atlas = 'unik_normal_jokers',
	pos = { x = 5, y = 6 },
    rarity = 1,
    cost = 4,
	config = {
		extra = {
			dollars = 1,
            dollar_mod = 2.5,
		},
	},
	attributes = { 'economy' },

	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.dollars),number_format(center.ability.extra.dollar_mod),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
            local amount = math.floor(math.max(G.GAME.interest_cap - G.GAME.dollars,0) / card.ability.extra.dollar_mod)
            return {
                
				dollars = amount,
				card = card
			}
        end
	end,
	calc_dollar_bonus = function(self, card)
		local amount = math.floor(math.max(G.GAME.interest_cap - G.GAME.dollars,0) / card.ability.extra.dollar_mod)
		if G.GAME.modifiers.no_interest then
			amount = 0
		end
        if to_big(amount) > to_big(0) then
			return amount
		end
	end,
	--do not spawn if no interest
	in_pool = function(self)
		if G.GAME.modifiers.no_interest then
			return false
		end
		return true
	end,
	check_for_unlock = function(self, args)
        if args.type == 'unik_redeeming_voucher' and args.card.config.center.key == 'v_seed_money' and G.GAME.modifiers.no_interest then
            return true
        end
    end,
    locked_loc_vars = function(self, info_queue, card)
        local other_name = localize('k_unknown')
        if G.P_CENTERS['v_seed_money'].unlocked then
            info_queue[#info_queue + 1] = G.P_CENTERS.v_seed_money
            
            other_name = localize { type = 'name_text', set = 'Voucher', key = 'v_seed_money' }
        end
        return {
        vars = {
            other_name
        }
        }
    end,
    unlocked = false,
  	discovered = false,
}