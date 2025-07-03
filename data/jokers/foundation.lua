-- after playing 150 hands, sell to get an exotic joker. EPIC
-- TODO: Must play at least 4 cards,
-- All cards must not be unmodified
-- and cards ranks and suit must
-- be different to each card in last hand

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
	demicoloncompat = true, --NOPE!
	-- remove_from_deck = function(self, card, from_debuff)
	-- 	--Remove baseless stickers if removed and no other foundation exists
	-- 	local foundationExists = false
	-- 	if not from_debuff then
	-- 		if G.jokers and G.jokers.cards and G.playing_cards then
	-- 			for i,v in pairs(G.jokers.cards) do
	-- 				if v.config.center.key == "j_unik_foundation" then
	-- 					foundationExists = true
	-- 					break
	-- 				end
	-- 			end
	-- 			if not foundationExists then
	-- 				for i,v in pairs(G.playing_cards) do
	-- 					v.ability.unik_baseless = nil
	-- 				end
	-- 			end
	-- 		end
	-- 	end
	-- end,
	update = function(self,card,dt)
		card.ability.extra.threshold = 150
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
		if context.forcetrigger then --NOPE! YOU ARE NOT GETTING A FREE EXOTIC!
			card.ability.extra.hands = 0
			card_eval_status_text(card, "extra", nil, nil, nil, {
				message = localize("k_nope"),
				colour = G.C.BLACK,
			})
		end
        if
			context.cardarea == G.jokers
			and context.before
			and not context.blueprint
			and not context.retrigger_joker
		then
			local reset = FoundationResetFunction(card,context)
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
				local card = create_card("Joker", G.jokers, nil, "cry_exotic", nil, nil, nil, "unik_foundation")
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

function FoundationResetFunction(card,context)
	if #G.play.cards < 4 then
		return true
	end
	for i,v in pairs(G.play.cards) do
		if not v.edition or (not v.seal or v.seal == "" or v.seal == "base") or v.config.center == G.P_CENTERS.c_base then
			return true
		end
	end
	return false
end

