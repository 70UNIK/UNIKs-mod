--change to:
--X1.5 mult and mult Xlog_50(mult)
SMODS.Enhancement {
	atlas = 'unik_enhancements',
	pos = {x = 2, y = 0},
	key = 'unik_timber',
	not_stoned = true,
    config = { extra = {base_odds = 1, break_odds = 3,Xmult = 1.5},immutable = {Xlogmultbase = 50}},
    weight = 1,
    woodbreak = true,
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card,card.ability.extra.base_odds,card.ability.extra.break_odds, 'unik_timber_enhancement')
        return {
            vars = { card.ability.extra.Xmult,card.ability.immutable.Xlogmultbase,new_numerator, new_denominator }
        }
    end,
	calculate = function(self, card, context, effect)
		if context.cardarea == G.play and context.main_scoring then
            return {
                x_mult = card.ability.extra.Xmult,
				xlog_mult = card.ability.immutable.Xlogmultbase,
                colour = G.C.DARK_EDITION,
			}
		end
        if context.destroy_card and context.destroy_card == card and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, pseudoseed('unik_timber_enhancement'),card.ability.extra.base_odds,card.ability.extra.break_odds, 'unik_timber_enhancement')  then
                return { remove = true }
            end
		end
    
	end,
}
