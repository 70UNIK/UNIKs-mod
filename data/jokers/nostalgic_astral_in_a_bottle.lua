--Literally old astral in the bottle. ^0.9 Mult, Apply astral and perishable to a random joker when sold.
SMODS.Joker {
	dependencies = {
		items = {
			"set_cry_cursed",
		},
	},
	-- How the code refers to the joker.
	key = 'unik_astral_bottle',
    atlas = 'placeholders',
    rarity = "cry_cursed",
	no_dbl = true,
	pos = { x = 3, y = 1 },
    cost = 0,
	blueprint_compat = false,
    perishable_compat = false,
	eternal_compat = false,
    config = { extra = {Emult = 0.9} },
	loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.cry_astral) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_cry_astral
		end
		return { vars = {center.ability.extra.Emult} }
	end,
	gameset_config = {
		modest = {extra = {Emult = 0.96} },
	},
    immutable = true,
    calculate = function(self, card, context)
		if context.final_scoring_step and (to_big(card.ability.extra.Emult) < to_big(1)) then
            return {
                e_mult = card.ability.extra.Emult,
				colour = G.C.DARK_EDITION,
            }
		end
        --Force value to become 0.9 if it exceeds 1 to keep it detrimental.
        if to_big(card.ability.extra.Emult) > to_big(1) then
            card.ability.extra.Emult = 0.9
        end
        if (context.selling_self and not context.retrigger_joker and not context.blueprint) or context.forcetrigger then
			local jokers = {}
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] ~= card and not G.jokers.cards[i].debuff and not G.jokers.cards[i].edition then
					jokers[#jokers + 1] = G.jokers.cards[i]
				end
			end
			if #jokers >= 1 then
				local chosen_joker = pseudorandom_element(jokers, pseudoseed("shitty_astral_bottle"))
				chosen_joker:set_edition({ cry_astral = true })
				chosen_joker.ability.perishable = true;
				chosen_joker.ability.perish_tally = G.GAME.perishable_rounds
				return nil, true
			else
				card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_no_other_jokers") })
			end
		end
    end,
}