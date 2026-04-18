-- if held, hand will not score -->, while held, retrigger the first played two blinds.
BLINDSIDE.Blind({
    key = 'unik_blindside_blacklist',
    atlas = 'unik_blindside_blinds',
    pos = {x = 0, y = 6},
    config = {
        rescore = 0,
        extra = {
            value = 20,
            eqchips = 0,
            eqmult = 0,
            chips = 70,
            mult = 12,
            stubborn = true,
        }},
    hues = {"Red"},
    calculate = function(self, card, context) 
        if context.individual and context.cardarea == G.hand and not context.end_of_round and card.area == G.hand and context.other_card == card then
            if card.ability.extra.upgraded then
                return {
                    chips = card.ability.extra.chips,
                    mult = card.ability.extra.mult,
                }
            else
                return {
                    eq_chips = card.ability.extra.eqchips,
                    eq_mult = card.ability.extra.eqmult,
                }
            end
			
		end
        if (context.hand_discard or context.hand_retain) and context.other_card == card then
                return { burn = true }
            end
    end,
    curse = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
            info_queue[#info_queue+1] = {key = 'bld_stubborn', set = 'Other'}
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_blacklist_upgraded' or 'm_unik_blindside_blacklist',
            vars = {
                card.ability.extra.eqmult,card.ability.extra.eqchips,card.ability.extra.mult,card.ability.extra.chips,
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
        card.ability.extra.upgraded = true
        end
    end
})