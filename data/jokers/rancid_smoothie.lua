
SMODS.Joker {
	dependencies = {
		items = {
			"set_cry_cursed",
		},
	},
	-- How the code refers to the joker.
	key = 'unik_rancid_smoothie',
    atlas = 'placeholders',
    rarity = "cry_cursed",
	pos = { x = 3, y = 1 },
    cost = 1,
	blueprint_compat = false,
    perishable_compat = false,
	eternal_compat = false,
    config = { extra = {Emult = 0.9, divisor = 1.25} },
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.Emult,center.ability.extra.divisor} }
	end,
    immutable = true,
    calculate = function(self, card, context)
		if context.final_scoring_step and (to_big(card.ability.extra.Emult) < to_big(1)) then
            return {
                message = localize({
                    type = "variable",
                    key = "a_powmult",
                    vars = {
                        number_format(card.ability.extra.Emult),
                    },
                }),
                Emult_mod = card.ability.extra.Emult,
				colour = G.C.DARK_EDITION,
            }
		end
        --Force value to become 0.9 if it exceeds 1 to keep it detrimental.
        if to_big(card.ability.extra.Emult) > to_big(1) then
            card.ability.extra.Emult = 0.9
        end
        if context.selling_self then
			local check = false
			for i, v in pairs(G.jokers.cards) do
				if v ~= card then
					if not Card.no(v, "immutable", true) then
						Cryptid.with_deck_effects(v, function(cards)
							Cryptid.misprintize(
								cards,
								{ min = 1/card.ability.extra.divisor, max = 1/card.ability.extra.divisor },
								nil,
								true
							)
						end)
						check = true
					end
				end
			end
			if check then
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_unik_arm_downgrade"), colour = G.C.BLACK }
				)
			end
		end
    end,
}