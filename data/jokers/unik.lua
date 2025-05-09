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
	gods = {
		'k_unik_unik_godsmarble1',
		'k_unik_unik_godsmarble2',
		'k_unik_unik_godsmarble3',
		'k_unik_unik_godsmarble4',
		'k_unik_unik_godsmarble5',
		'k_unik_unik_godsmarble6',
		'k_unik_unik_godsmarble7',
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
	demicoloncompat = true,
	fusable = true,
    config = { extra = {Echips_mod = 0.03, Echips = 1.0} }, --normally he should not be cappted in mainline+
	gameset_config = {
		modest = { extra = {Echips_mod = 0.02, Echips = 1.0} },
	},
	loc_vars = function(self, info_queue, center)
		local quoteset = 'normal'
		if (SMODS.Mods["jen"] or {}).can_load then
			quoteset = Jen.gods() and 'gods' or Jen.dramatic and 'drama'  or 'normal'
		end
		return {
		key = Cryptid.gameset_loc(self, {modest = "modest" }), 
		vars = {center.ability.extra.Echips_mod,center.ability.extra.Echips
	,localize(unik_quotes[quoteset][math.random(#unik_quotes[quoteset])] .. "")
	} }
	end,
    pools = {["unik_seven"] = true },
    calculate = function(self, card, context)
		local check = false
		if context.forcetrigger then
			card.ability.extra.Echips = card.ability.extra.Echips + card.ability.extra.Echips_mod
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
		if (context.joker_main) and (to_big(card.ability.extra.Echips) > to_big(1)) then
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
        if (context.individual and context.cardarea == G.play) and Card.get_gameset(card) ~= "modest" then
			if context.other_card:get_id() == 7 and not context.blueprint  then
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
		if (context.before and context.cardarea == G.jokers and not context.blueprint and Card.get_gameset(card) == "modest") then

            --print("turn them happy")
			for k, v in ipairs(context.full_hand) do
				if
					v:get_id() == 7
				then
					check = true
				end
			end
			if check == true then
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
--Simple EChips display
if JokerDisplay then
	JokerDisplay.Definitions["j_unik_unik"] = {
		text = {
			{
				border_nodes = {
					{ text = "^" },
					{
						ref_table = "card.ability.extra",
						ref_value = "Echips",
						retrigger_type = "exp"
					},
				},
				border_colour = G.C.DARK_EDITION,
			},
		},
	}
end