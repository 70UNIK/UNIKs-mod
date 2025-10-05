SMODS.Atlas {
	key = "unik_unik",
	path = "unik_unik.png",
	px = 71,
	py = 95
}
local unik_quotes = {
	normal = {
		'k_unik_unik_normal1',
		'k_unik_unik_normal2',
		'k_unik_unik_normal3',
		'k_unik_unik_normal4',
		'k_unik_unik_normal5',
		'k_unik_unik_normal6',
	},
}

SMODS.Joker {
	key = 'unik_unik',
    atlas = 'unik_unik',
    rarity = "unik_ancient",
	
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
    cost = 50,
	blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = true,
	demicoloncompat = true,
	--Contra logos from ascensio has ^0.01 chips per 7 or 4 contained in scoring hand (doesnt have to score), but unless you have joker retriggers, it cannot retrigger 7s.
	--This has ^0.01 chips per scoring 7 (can be retriggered). You can retrgger scoring 7s, which makes this potentally stronger than contra logos even if harder to use. Also pink cards.
	--This is why I nerfed it to ^0.01
    config = { extra = {Echips_mod = 0.01, Echips = 0.0}, immutable = {base_echips = 1.0,hyperbolic_scale_limit = 1.6,hyperbolic_factor = 2.5}}, --normally he should not be cappted in mainline+
	loc_vars = function(self, info_queue, center)
		local quoteset = 'normal'
		return {
		vars = {tostring(center.ability.extra.Echips_mod),center.ability.extra.Echips + center.ability.immutable.base_echips
	,localize(unik_quotes[quoteset][math.random(#unik_quotes[quoteset])] .. ""),center.ability.immutable.hyperbolic_factor,center.ability.immutable.hyperbolic_scale_limit
	} }
	end,
	pronouns = "he_him",
    pools = {["unik_seven"] = true },
    calculate = function(self, card, context)
		local check = false
		if context.forcetrigger then
			return {
				e_chips = card.ability.extra.Echips + card.ability.immutable.base_echips,
				colour = G.C.DARK_EDITION,
			}
		end
		if (context.joker_main)  then
			if (to_big(card.ability.extra.Echips + card.ability.immutable.base_echips) > to_big(1)) then
				return {
					e_chips = card.ability.extra.Echips + card.ability.immutable.base_echips,
					colour = G.C.DARK_EDITION,
				}
			end
		end
		if context.before and not context.blueprint then
			local triggered = false
            local increase = 0
            for k, v in ipairs(context.scoring_hand) do
                if v:get_id() == 7 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end,
                    }))
                     increase  =  increase  + 1
                    triggered = true
                end       
            end
            if triggered then
				for i = 1, increase do
					print("1")
					if i < increase then
						SMODS.scale_card(card, {
							ref_table =card.ability.extra,
							ref_value = "Echips",
							scalar_value = "Echips_mod",
							base = 1,
							message_key = "a_powchips",
							message_colour = G.C.DARK_EDITION,
							force_full_val = true,
							no_message = true,
						})
					else
						SMODS.scale_card(card, {
							ref_table =card.ability.extra,
							ref_value = "Echips",
							scalar_value = "Echips_mod",
							base = 1,
							message_key = "a_powchips",
							message_colour = G.C.DARK_EDITION,
							force_full_val = true,
						})
					end
					
					if (to_big(card.ability.extra.Echips + card.ability.immutable.base_echips) > to_big(card.ability.immutable.hyperbolic_scale_limit)) then
						SMODS.scale_card(card, {
							ref_table =card.ability.extra,
							ref_value = "Echips_mod",
							scalar_value = "custom_scaler",
							operation = "-",
							scalar_table = {
								custom_scaler = card.ability.extra.Echips_mod - card.ability.extra.Echips_mod *(100 - card.ability.immutable.hyperbolic_factor)/100,
							},
							no_message = true,
						})
					end
					
				end
                				return {

				}
            end
		end	

    end,
}

