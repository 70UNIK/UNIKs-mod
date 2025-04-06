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
	},
	drama = {
		'k_unik_unik_scared1',
		'k_unik_unik_scared2',
	},
	gods = {
		'k_unik_unik_godsmarble1',
		'k_unik_unik_godsmarble2',
		'k_unik_unik_godsmarble3',
		'k_unik_unik_godsmarble4',
	}
}

SMODS.Joker {
	dependencies = {
		items = {
			"set_cry_exotic",
		},
    },
	key = 'unik_unik',
    atlas = 'unik_unik',
    rarity = "cry_exotic",
	
	pos = { x = 0, y = 0 },
	-- soul_pos sets the soul sprite, used for legendary jokers and basically all of Jen's Jokers
	soul_pos = { x = 1, y = 0 },
	drama = { x = 2, y = 0 }, 
	godsmarbling = {x = 1, y = 1 }, 
	godsmarbling_back = { x = 0, y = 1 }, --used to change the backplate
    cost = 50,
	blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = true,
	fusable = true,
    config = { extra = {Echips_mod = 0.03, Echips = 1.0,cap = 999999} }, --normally he should not be cappted in mainline+
	gameset_config = {
		modest = { extra = {Echips_mod = 0.01, Echips = 1.0,cap = 5.0} },
	},
	loc_vars = function(self, info_queue, center)
		local quoteset = 'normal'
		if (SMODS.Mods["jen"] or {}).can_load then
			quoteset = Jen.dramatic and 'drama' or Jen.gods() and 'gods' or 'normal'
		end
		return {
		key = Cryptid.gameset_loc(self, {modest = "modest" }), 
		vars = {center.ability.extra.Echips_mod,center.ability.extra.Echips,center.ability.extra.cap
	,localize(unik_quotes[quoteset][math.random(#unik_quotes[quoteset])] .. "")
	} }
	end,
    pools = {["unik_seven"] = true },
    calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.Echips) > to_big(1)) then
			return {
                message = localize({
					type = "variable",
					key = "a_powchips",
                    vars = {
                        number_format(card.ability.extra.Echips),
                    },
				}),
				Echip_mod = card.ability.extra.Echips,
                colour = G.C.DARK_EDITION,
			}
		end
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 7 and not context.blueprint then
			if (Card.get_gameset(card) == "modest" and card.ability.extra.Echips <= center.ability.extra.cap) or Card.get_gameset(card) ~= "modest" then
				card.ability.extra.Echips = card.ability.extra.Echips + card.ability.extra.Echips_mod
				return {
					message = localize({
						type = "variable",
						key = "a_powchips",
						vars = {
							number_format(to_big(card.ability.extra.Echips)),
						},
					}),
					colour = G.C.DARK_EDITION,
					card = card
				}
			end
		end
    end,
}