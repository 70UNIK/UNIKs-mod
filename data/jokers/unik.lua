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
	-- drama = {
	-- 	'k_unik_unik_scared1',
	-- 	'k_unik_unik_scared2',
	-- 	'k_unik_unik_scared3',
	-- },
	-- gods = {
	-- 	'k_unik_unik_godsmarble1',
	-- 	'k_unik_unik_godsmarble2',
	-- 	'k_unik_unik_godsmarble3',
	-- 	'k_unik_unik_godsmarble4',
	-- 	'k_unik_unik_godsmarble5',
	-- 	'k_unik_unik_godsmarble6',
	-- 	'k_unik_unik_godsmarble7',
	-- }
}

--rework: instead of 7s, has to be pink cards to require more effort. As a result, there will be no enhancement gate.


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
	soul_pos = { x = 1, y = 0 },
    cost = 50,
	blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = true,
	demicoloncompat = true,
	fusable = true,
	--Contra logos from ascensio has ^0.01 chips per 7 or 4 contained in scoring hand (doesnt have to score), but unless you have joker retriggers, it cannot retrigger 7s.
	--This has ^0.01 chips per scoring 7 (can be retriggered). You can retrgger scoring 7s, which makes this potentally stronger than contra logos even if harder to use. Also pink cards.
	--This is why I nerfed it to ^0.01
    config = { extra = {Echips_mod = 0.01, Echips = 1.0,Xchips_mod = 0.2, Xchips = 1.0} }, --normally he should not be cappted in mainline+
	loc_vars = function(self, info_queue, center)
		local quoteset = 'normal'
		return {
		key = Cryptid.gameset_loc(self, {modest = "modest" }), 
		vars = {center.ability.extra.Echips_mod,center.ability.extra.Echips,center.ability.extra.Xchips_mod,center.ability.extra.Xchips
	,localize(unik_quotes[quoteset][math.random(#unik_quotes[quoteset])] .. "")
	} }
	end,
    pools = {["unik_seven"] = true },
    calculate = function(self, card, context)
		local check = false
		if context.forcetrigger and Card.get_gameset(card) == "modest" then
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
		if (context.joker_main)  then
			if Card.get_gameset(card) == "modest" and (to_big(card.ability.extra.Xchips) > to_big(1)) then
				return {
					message = localize({
						type = "variable",
						key = "a_xchips",
						vars = {
							number_format(card.ability.extra.Xchips),
						},
					}),
					Echip_mod = card.ability.extra.Xchips,
					colour = G.C.DARK_EDITION,
				}
			elseif (to_big(card.ability.extra.Echips) > to_big(1)) then
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
			
		end
        if (context.individual and context.cardarea == G.play)then
			if context.other_card:get_id() == 7 and not context.blueprint  then
				if Card.get_gameset(card) == "modest" then
					card.ability.extra.Xchips = card.ability.extra.Xchips + card.ability.extra.Xchips_mod
					return {
						message = localize({
							type = "variable",
							key = "a_xchips",
							vars = {
								number_format(card.ability.extra.Xchips),
							},
						}),
						colour = G.C.DARK_EDITION,
						card = card
					}
				else
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
		end		

    end,
}
--Simple EChips display
if JokerDisplay then
	JokerDisplay.Definitions["j_unik_unik"] = {
		text = {
			{
				border_nodes = {
					{ ref_table = "card.joker_display_values", ref_value = "Echips", retrigger_type = "exp" },
				},
				border_colour = G.C.DARK_EDITION,
			},
            {
				border_nodes = {
					{ ref_table = "card.joker_display_values", ref_value = "Xchips", retrigger_type = "exp" },
				},
				border_colour = G.C.CHIPS,
			},
		},
        calc_function = function(card)
            local Echips = ""
            local Xchips = ""
            if Card.get_gameset(card) ~= "modest" then
                Echips = "^" .. card.ability.extra.Echips
            else
                Xchips = "X" .. card.ability.extra.Xchips
            end
            card.joker_display_values.Echips = Echips
            card.joker_display_values.Xchips = Xchips
        end
	}
end
