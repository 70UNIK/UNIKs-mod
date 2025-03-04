--Retrigger the last scoring card 2 times (the opposite of the hanging chad)
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'holepunched_card',
    atlas = 'placeholders',
    rarity = 1,
	pos = { x = 0, y = 0 },
    cost = 4,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    config = { extra = {repetitions = 2} },
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.repetitions} }
	end,
    calculate = function(self, card, context)
		if context.cardarea == G.play and context.other_card == context.scoring_hand[#context.scoring_hand] then
			return {
				message = localize('k_again_ex'),
				repetitions = card.ability.extra.repetitions,
				card = card
			}
		end
    end,
}