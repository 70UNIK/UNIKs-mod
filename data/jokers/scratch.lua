--scratch: Code cards held in consumables give +15 Mult
--Seems hefty at first for a common, until you need to hold code cards (which dont spawn too often), clogs up your consumables 
--and finally has shit scaling, cause it triggers after jokers meaning if you have Xmult already, it cannot take advantage of it.
--just like scratch (easy to get into, but hard to do complex stuff)
--The only viable reason to use this is if you have Observatory and/or moonlight... and they are much harder to get, use planets
--and its best to just focus on planets if using perkeo
SMODS.Joker {
	dependencies = {
		items = {
			"set_cry_code",
		},
    },
	key = 'unik_scratch',
    atlas = 'unik_common',
    rarity = 1,
	pos = { x = 4, y = 0 },
    cost = 4,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
	demicoloncompat = true,
    config = { extra = { mult = 20} },
	gameset_config = {
		modest = { extra = { mult = 15} },
	},
	loc_vars = function(self, info_queue, center)
		return { 
			vars = {center.ability.extra.mult} 
		}
	end,
    pools = {["unik_copyrighted"] = true },
    calculate = function(self, card, context)
		--Known issue: does not work with retriggers.
		if context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_mult",
					vars = {
						number_format(card.ability.extra.mult),
					},
				}),
				mult_mod = card.ability.extra.mult,
				colour = G.C.MULT,

			}
		end
        if context.other_consumeable and context.other_consumeable.ability.set == 'Code'
		then

			if not Talisman.config_file.disable_anims and valid == true then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.other_consumeable:juice_up(0.5, 0.5)
						return true
					end,
				}))
			end
			if context.other_consumeable.debuff and valid == true then
				card_eval_status_text(card, "debuff", nil, nil, nil, nil)
				--return true
			else
				if (SMODS.Mods["incantation"] or {}).can_load then
						return {
							message = localize({
								type = "variable",
								key = "a_mult",
								vars = {
									number_format(card.ability.extra.mult),
								},
							}),
							mult_mod = card.ability.extra.mult*(context.other_consumeable.ability.qty or 1),
							colour = G.C.MULT,

						}
				-- end
				else
					return {
						message = localize({
							type = "variable",
							key = "a_mult",
							vars = {
								number_format(card.ability.extra.mult),
							},
						}),
						mult_mod = card.ability.extra.mult,
						colour = G.C.MULT,

					}
				end

			end
        end
    end,

}
if JokerDisplay then
	JokerDisplay.Definitions["j_unik_scratch"] = {
		text = {
			{ text = "+", colour = G.C.MULT},
			{ ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" , colour = G.C.MULT},
			{ ref_table = "card.joker_display_values", ref_value = "localized_text", colour = HEX("14b341")}
		},
		calc_function = function(card)
			local mult = 0
			for i,v in pairs(G.consumeables.cards) do
				if v.ability.set == "Code" and not v.debuff then
					if (SMODS.Mods["incantation"] or {}).can_load then
						if v.ability.qty and v.ability.qty > 1 then
							mult = mult + card.ability.extra.mult*v.ability.qty
						else
							mult = mult + card.ability.extra.mult
						end				
					else
						mult = mult + card.ability.extra.mult
					end
				end			
			end
			card.joker_display_values.mult = mult
			card.joker_display_values.localized_text = " (" .. localize("k_code") .. ")"
		end,
	}
end