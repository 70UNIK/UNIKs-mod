local poppy_quotes = {
	normal = {
		'k_poppy_normal1',
		'k_poppy_normal2',
		'k_poppy_normal3',
		'k_poppy_normal4',
		'k_poppy_normal5',
		'k_poppy_normal6',
	},
    trigger = {
        'k_poppy_trigger1',
        'k_poppy_trigger2',
        'k_poppy_trigger3',
        'k_poppy_trigger4',
    }
}
SMODS.Joker {
    key = 'unik_poppy',
    atlas = 'placeholders',
	pos = { x = 2, y = 0 },
    rarity = 3,
    cost = 9,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    config = { extra = {retriggers = 1},immutable = {max_retriggers = 50} },
    loc_vars = function(self, info_queue, center)
        return { 
            vars = {math.min(center.ability.extra.retriggers,center.ability.immutable.max_retriggers)} 
        }
	end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local reps = 0
            if G.GAME.current_round.discards_left == 0 then
                reps = reps + 1
            end
            if reps > 0 then
                return {
                    message = localize("k_again_ex"),
                    repetitions = to_number(
                        reps
                    ),
                    colour = HEX("ff8bcb"),
                    card = card,
                }
            end
		end
    end,
}