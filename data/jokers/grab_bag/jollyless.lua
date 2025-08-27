SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_jollyless',
    atlas = 'unik_grab_bag_jokers',
    pos = { x = 3, y = 0 },
    rarity = "gb_boss",
	-- Modest
    config = { extra = { Xmult = 1, Xmult_mod = 1.5}},
    cost = 7,
    blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
	demicoloncompat = true,
    discovered = true,
    unlocked = true,
    pools = { ["M"] = true },
    loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_jolly
		return { vars = {center.ability.extra.Xmult_mod,center.ability.extra.Xmult} }
	end,
    calculate = function(self, card, context)
		if context.joker_main and to_big(card.ability.extra.Xmult) > to_big(1) then
			return {
                x_mult = card.ability.extra.Xmult,
                colour = G.C.MULT,
            }
		end
        if
			(context.setting_blind and not (context.blueprint or context.retrigger_joker) and not card.getting_sliced)
			or context.forcetrigger
		then
            local multiplier = 0
            
			G.E_MANAGER:add_event(Event({
				func = function()
					local triggered = false
					local destroyed_jokers = {}
					for _, v in pairs(G.jokers.cards) do
						if
							v.config.center.key ~= "j_unik_jollyless"
							and v ~= card
                            and not (
								SMODS.is_eternal(v)
								or v.getting_sliced
							)
							and (v:is_jolly()
							or v.config.center.key == "j_cry_mprime"
							or Cryptid.safe_get(v.config.center, "pools", "M"))
						then
							destroyed_jokers[#destroyed_jokers + 1] = v
						end
					end
                    
					for _, v in pairs(destroyed_jokers) do
						multiplier = multiplier + 1
						if v.config.center.rarity == "cry_exotic" then
							check_for_unlock({ type = "what_have_you_done" })
						end
						triggered = true
						v.getting_sliced = true
						v:start_dissolve({ HEX("57ecab") }, nil, 1.6)
					end
					if triggered then
						card:juice_up(0.8, 0.8)
						play_sound("slice1", 0.96 + math.random() * 0.08)
                        if multiplier > 0 then
                            --card.ability.extra.Xmult = card.ability.extra.Xmult + multiplier * card.ability.extra.Xmult_mod
							SMODS.scale_card(card, {
								ref_table =card.ability.extra,
								ref_value = "Xmult",
								scalar_value = "custom_scaler",
								scalar_table = {
									custom_scaler = multiplier * card.ability.extra.Xmult_mod,
								},
								message = localize({
									type = "variable",
									key = "a_xmult",
									vars = { card.ability.extra.Xmult },
								}),
								message_colour = G.C.MULT,
							})
                        end
					end
					return true
				end,
			}))
			if context.forcetrigger then
				return {
					x_mult = card.ability.extra.Xmult,
					colour = G.C.MULT,
				}
			end
		end
	end,
    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_unik_jollyless")
    end,
    set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("GrabBag")[1] }, badges)
    end,
}