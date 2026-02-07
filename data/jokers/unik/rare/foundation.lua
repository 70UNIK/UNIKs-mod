-- after playing 150 hands, sell to get an exotic joker. EPIC
-- TODO: Must play at least 4 cards,
-- All cards must not be unmodified
-- and cards ranks and suit must
-- be different to each card in last hand

SMODS.Joker {
    key = 'unik_foundation',
    atlas = 'unik_epic',
    rarity = 3,
	pos = { x = 0, y = 0 },
    cost = 1,
    config = {extra = {hands = 0,juiced_up = false,threshold = 18}},
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.hands,center.ability.extra.threshold} }
    end,
    immutable = true,
	no_doe = true, --only because it becomes garbage in that mode
    blueprint_compat = false,
	perishable_compat = false,
	eternal_compat = false,
	demicoloncompat = true, --NOPE!
	update = function(self,card,dt)
		card.ability.extra.threshold = 18
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
	in_pool = function() --reduce frequency of it appearing
        if pseudorandom('unik_foundation'..G.SEED) < 0.5 then
            return true
        else
            return false
        end
    end,
    calculate = function(self, card, context)
		if context.forcetrigger then --NOPE! YOU ARE NOT GETTING A FREE EXOTIC!
			card.ability.extra.hands = 0
			card_eval_status_text(card, "extra", nil, nil, nil, {
				message = localize("k_nope_ex"),
				colour = G.C.BLACK,
			})
			return {
				
			}
		end
        if
			context.cardarea == G.jokers
			and context.before
			and not context.blueprint
			and not context.retrigger_joker
		then
			card.ability.extra.hands = card.ability.extra.hands + 1
			if card.ability.extra.hands < card.ability.extra.threshold then 
				
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = card.ability.extra.hands .. "/" .. card.ability.extra.threshold,
						colour = G.C.UNIK_ANCIENT,
					}),
				}
			elseif card.ability.extra.hands >= card.ability.extra.threshold and card.ability.extra.juiced_up == false then
				
				local eval = function(card)
					return not card.REMOVED and card.ability.extra.hands >= card.ability.extra.threshold
				end
				juice_card_until(card, eval, true)
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize("k_unik_active"),
					colour = G.C.UNIK_ANCIENT,
				})
				card.ability.extra.juiced_up = true
			end
        end
        if context.selling_self and not context.blueprint and not context.retrigger_joker then
			if card.ability.extra.hands >= card.ability.extra.threshold then
				local card = create_card("Joker", G.jokers, nil, "unik_ancient", nil, nil, nil, "unik_foundation")
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

