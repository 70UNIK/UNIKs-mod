SMODS.Enhancement {
	atlas = 'placeholders2',
	pos = {x = 1, y = 0},
	key = 'unik_dollar',
    config = { extra = { money = 2} },
    weight = 0,
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.money}
        }
    end,
	calculate = function(self, card, context, effect)
		if context.cardarea == G.play and context.main_scoring then
            return {
                p_dollars = card.ability.extra.money,
                card = card,
            }
		end
	end
}