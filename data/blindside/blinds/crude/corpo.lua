--the corpo
-- +1 Mult to Joker, -2 Mult and -$3 dollars --> -0.5 Mult to joker, +4 Mult and +$3 dollars
BLINDSIDE.Blind({
    key = 'unik_blindside_corpo',
    atlas = 'unik_blindside_blinds',
    pos = {x = 1, y = 7},
    config = {
        extra = {
            value = 30,
            jokermult = 1,
            jokermultdown = -1.5,
            mult = -2,
            multup = 7,
            dollars = -3,
            dollarsup = 6,
            retain = true,
        }
    },
    hues = {"Faded"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.main_scoring then
            BLINDSIDE.chipsmodify(card.ability.extra.jokermult, 0, 0)
            return {
                mult = card.ability.extra.mult,
                p_dollars = card.ability.extra.dollars,
            }
        end
        if context.burn_card and context.cardarea == G.play and context.burn_card == card then
            return { remove = true }
        end
    end,
    curse = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
if not  card.ability.extra.upgraded then
            info_queue[#info_queue+1] = {key = 'bld_retain', set = 'Other'}  
        else
        end
        
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_corpo_upgraded' or 'm_unik_blindside_corpo',
            vars = {
                card.ability.extra.jokermult,card.ability.extra.mult,math.abs(card.ability.extra.dollars)
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.jokermult = card.ability.extra.jokermult + card.ability.extra.jokermultdown
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multup
            card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.dollarsup
            card.ability.extra.retain = nil
            card.ability.extra.upgraded = true
        end
    end
})