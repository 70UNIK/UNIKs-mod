SMODS.Sticker:take_ownership("rental", {
	loc_vars = function(self, info_queue, card)
		if card.ability.consumeable then
			return { key = "cry_rental_consumeable", vars = { G.GAME.cry_consumeable_rental_rate or 2 } }
		elseif card.ability.set == "Voucher" then
			return { key = "cry_rental_voucher", vars = { G.GAME.cry_voucher_rental_rate or 2 } }
		elseif card.ability.set == "Booster" then
			return { key = "cry_rental_booster" }
		else
			return { vars = { G.GAME.rental_rate or 1 } }
		end
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval then
			if card.ability.consumeable then
				card:cry_calculate_consumeable_rental()
			elseif card.ability.set == "Voucher" then
				card:cry_calculate_voucher_rental()
			else
				card:calculate_rental()
			end
		end
		if context.playing_card_end_of_round then
			card:calculate_rental()
		end
	end,
})

-- Calculates Rental sticker for Consumables
function Card:cry_calculate_consumeable_rental()
	if self.ability.rental then
        G.GAME.cry_consumeable_rental_rate = G.GAME.cry_consumeable_rental_rate or 2
		ease_dollars(-G.GAME.cry_consumeable_rental_rate)
		card_eval_status_text(self, "dollars", -G.GAME.cry_consumeable_rental_rate)
	end
end
-- Calculates Rental sticker for Vouchers
function Card:cry_calculate_voucher_rental()
	if self.ability.rental then
        G.GAME.cry_voucher_rental_rate = G.GAME.cry_voucher_rental_rate or 2
		ease_dollars(-G.GAME.cry_voucher_rental_rate)
		card_eval_status_text(self, "dollars", -G.GAME.cry_voucher_rental_rate)
	end
end