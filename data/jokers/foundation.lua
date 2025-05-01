-- after playing 150 hands, sell to get an exotic joker. EPIC
-- After feedback, 114 hands is too op (flesh panopicon exists), legendary is too niche, so I'll try to add a (114 consecutive hands with only cards with an edition and enhancement)
--Saint dramatically reduces this to 2 hands.
SMODS.Joker {
	dependencies = {
		items = {
			"set_cry_exotic",
			"set_cry_epic",
		},
    },
    key = 'unik_foundation',
    atlas = 'unik_epic',
    rarity = 'cry_epic',
	pos = { x = 0, y = 0 },
    cost = 10,
    config = {extra = {hands = 0,juiced_up = false,threshold = 150}},
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.hands,center.ability.extra.threshold} }
    end,
    immutable = true,
	no_doe = true, --only because it becomes garbage in that mode
    blueprint_compat = false,
	perishable_compat = false,
	eternal_compat = false,
	add_to_deck = function(self, card, from_debuff)
		if #SMODS.find_card("j_jen_saint_attuned") > 0 then
			card.ability.extra.threshold = 0
			local eval = function(card)
				return not card.REMOVED and card.ability.extra.hands >= card.ability.extra.threshold
			end
			juice_card_until(card, eval, true)
			card_eval_status_text(card, "extra", nil, nil, nil, {
				message = localize("k_unik_active"),
				colour = G.C.CRY_EXOTIC,
			})
			card.ability.extra.juiced_up = true
		elseif #SMODS.find_card("j_jen_saint") > 0 then
			card.ability.extra.threshold = 2
			
		end
	end,
	update = function(self,card,dt)
		if #SMODS.find_card("j_jen_saint_attuned") > 0 then
			card.ability.extra.threshold = 0
			if card.ability.extra.juiced_up == false then
				local eval = function(card)
					return not card.REMOVED and card.ability.extra.hands >= card.ability.extra.threshold
				end
				juice_card_until(card, eval, true)
				card.ability.extra.juiced_up = true
			end
		elseif #SMODS.find_card("j_jen_saint") > 0 then
			card.ability.extra.threshold = 2
			if card.ability.extra.juiced_up == false then
				local eval = function(card)
					return not card.REMOVED and card.ability.extra.hands >= card.ability.extra.threshold
				end
				juice_card_until(card, eval, true)
				card.ability.extra.juiced_up = true
			end
		else
			card.ability.extra.threshold = 150
		end
		if card.ability.extra.hands < card.ability.extra.threshold then
			card.ability.extra.juiced_up = false
		end
	end,
	load = function(self, card, card_table, other_card)
		--Do not spam the shake
		if card.ability.extra then
			card.ability.extra.juiced_up = false
			if card.ability.extra.hands >= card.ability.extra.threshold and card.ability.extra.juiced_up == false then
				local eval = function(card)
					return not card.REMOVED and card.ability.extra.hands >= card.ability.extra.threshold
				end
				juice_card_until(card, eval, true)
				card.ability.extra.juiced_up = true
			end
		end
	end,
    calculate = function(self, card, context)
        if
			context.cardarea == G.jokers
			and context.before
			and not context.blueprint
			and not context.retrigger_joker
		then
			local reset = false
			for i,v in pairs(G.play.cards) do
				if not v.edition or not v.config.center_key then
					reset = true
				end
			end
			if not reset then
				card.ability.extra.hands = card.ability.extra.hands + 1
				if card.ability.extra.hands < card.ability.extra.threshold then 
					return {
						card_eval_status_text(card, "extra", nil, nil, nil, {
							message = card.ability.extra.hands .. "/" .. card.ability.extra.threshold,
							colour = G.C.CRY_EXOTIC,
						}),
					}
				elseif card.ability.extra.hands >= card.ability.extra.threshold and card.ability.extra.juiced_up == false then
					
					local eval = function(card)
						return not card.REMOVED and card.ability.extra.hands >= card.ability.extra.threshold
					end
					juice_card_until(card, eval, true)
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = localize("k_unik_active"),
						colour = G.C.CRY_EXOTIC,
					})
					card.ability.extra.juiced_up = true
				end
			elseif card.ability.extra.hands > 0 then
				card.ability.extra.hands = 0
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize("k_reset"),
					colour = G.C.BLACK,
				})
			end
        end
        if context.selling_self and not context.blueprint and not context.retrigger_joker then
			if card.ability.extra.hands >= card.ability.extra.threshold then
				local card = create_card("Joker", G.jokers, nil, "cry_exotic", nil, nil, nil, "unik_long_line")
				card:add_to_deck()
				G.jokers:emplace(card)
				card:start_materialize()
				return nil, true
			else
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_nope_ex"), colour = G.C.BLACK }
				)
			end
		end
    end
}
if JokerDisplay then
	JokerDisplay.Definitions["j_unik_foundation"] = {
		reminder_text = {
			{ ref_table = "card.joker_display_values", ref_value = "localized_text" },
		},
		calc_function = function(card)
			local is_active = card.ability.extra.hands >= card.ability.extra.threshold
			card.joker_display_values.localized_text = "("
				.. (is_active and localize("k_active_ex") or (card.ability.extra.hands .. "/" .. card.ability.extra.threshold))
				.. ")"
		end,
	}
end