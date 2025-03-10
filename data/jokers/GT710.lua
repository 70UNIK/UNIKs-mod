SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_gt710',
    atlas = 'unik_common',
    rarity = 1,
	pos = { x = 1, y = 0 },
    config = { extra = { money = 7,has10 = false, has7 = false} },
    cost = 4,
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    pools = {["unik_seven"] = true },
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.money} }
	end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
			-- :get_id tests for the rank of the card. Other than 2-10, Jack is 11, Queen is 12, King is 13, and Ace is 14.
			if context.other_card:get_id() == 10 then
                card.ability.extra.has10 = true
            end
            if context.other_card:get_id() == 7 then
                card.ability.extra.has7 = true
			end
		end
		if context.joker_main then
			if card.ability.extra.has10 == true and not (context.blueprint_card or self).getting_sliced and card.ability.extra.has7 == true then
				-- Create a Food Joker according to Cryptid.
				--local jokers_to_create = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
				--G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
                G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                card.ability.extra.has10 = false
                card.ability.extra.has7 = false
                return {
                    dollars = card.ability.extra.money,
                    card = self
                }
			end
            card.ability.extra.has10 = false
			card.ability.extra.has7 = false
		end
	end
}