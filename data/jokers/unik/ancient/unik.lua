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
	drama = {
		'k_unik_unik_scared1',
		'k_unik_unik_scared2',
		'k_unik_unik_scared3',
	},
}

SMODS.Joker {
	key = 'unik_unik',
    atlas = 'unik_unik',
    rarity = "unik_ancient",
	
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	drama = { x = 2, y = 0 }, 
    cost = 50,
	blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = true,
	demicoloncompat = true,
	--Contra logos from ascensio has ^0.01 chips per 7 or 4 contained in scoring hand (doesnt have to score), but unless you have joker retriggers, it cannot retrigger 7s.
	--This has ^0.01 chips per scoring 7 (can be retriggered). You can retrgger scoring 7s, which makes this potentally stronger than contra logos even if harder to use. Also pink cards.
	--This is why I nerfed it to ^0.01
    config = { extra = {Echips_mod = 0.01, Echips = 0.0}, immutable = {base_echips = 1.0,limit = 2.0}}, --normally he should not be cappted in mainline+
	loc_vars = function(self, info_queue, center)
		local quoteset = 'normal'
		local key = 'j_unik_unik'
		if (SMODS.Mods["jen"] or {}).can_load then
			quoteset = Jen.dramatic and 'drama'  or 'normal'
		end
		if center.ability.extra.Echips + center.ability.immutable.base_echips >= center.ability.immutable.limit then
			key = 'j_unik_unik_capped'
		end
		return { key = key,
		vars = {tostring(center.ability.extra.Echips_mod),center.ability.extra.Echips + center.ability.immutable.base_echips
	,localize(unik_quotes[quoteset][math.random(#unik_quotes[quoteset])] .. ""),center.ability.immutable.limit
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
		if context.before and not context.blueprint and card.ability.extra.Echips + card.ability.immutable.base_echips < card.ability.immutable.limit then
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
				SMODS.scale_card(card, {
					ref_table =card.ability.extra,
					ref_value = "Echips",
					scalar_value = "Echips_mod",
					base = 1,
					message_key = "a_powchips",
					message_colour = G.C.DARK_EDITION,
					force_full_val = true,
					operation = function(ref_table, ref_value, initial, scaling)
						ref_table[ref_value] = math.min(initial + scaling * increase,card.ability.immutable.limit - card.ability.immutable.base_echips)
					end,
				})
                				return {

				}
            end
		end	

    end,
}

