--TOTAL REWRK NEEDED:
--Aces and 7s each give X1.5 Chips

SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_711',
	rarity = 3,
	atlas = 'unik_uncommon',
	pos = { x = 0, y = 0 },
	cost = 8,
	blueprint_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	eternal_compat = true,
	config = {extra = {x_chips = 1.5}},
	loc_vars = function(self, info_queue, center)
		
		info_queue[#info_queue + 1] = { set = "Other", key = "food_jokers" }
		return {
			key = Cryptid.gameset_loc(self, {modest = "modest" }), 
		}
	end,
	pools = {["unik_copyrighted"] = true ,["unik_seven"] = true },
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
    calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
            if (
                context.other_card:get_id() == 2 or 
                context.other_card:get_id() == 3 or 
                context.other_card:get_id() == 5 or 
                context.other_card:get_id() == 7 or 
                context.other_card:get_id() == 14) then
                return {
                    chips = card.ability.extra.chips,
                    card = card
                }
            end
		end

	end
}