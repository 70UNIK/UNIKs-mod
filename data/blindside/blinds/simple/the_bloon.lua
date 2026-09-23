--X2.5 Mult, 1 in 3 chance this blind is destroyed after scoring, --> X3 Mult, 1 in 5 chance this blind is destroyed after scoring
BLINDSIDE.Blind({
    key = 'unik_blindside_bloon',
    atlas = 'unik_blindside_blinds',
    pos = {x = 7, y = 0},
    config = {
        extra = {
            value = 14,
            x_mult = 2,
            x_mult_up = 1,
            chance = 3,
            base_chance = 1,
            chance_up = 3,
        }},
    hues = {"Red"},
    bloonpop = true,
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.main_scoring then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
        if context.destroy_card and context.destroy_card == card and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, pseudoseed('unik_bloon_pop'),card.ability.extra.base_chance, card.ability.extra.chance, 'unik_bloon_pop')  then
                return { remove = true }
            end
        end
    end,
    common = true,
    loc_vars = function(self, info_queue, card)
        local chance, trigger = SMODS.get_probability_vars(card, card.ability.extra.base_chance, card.ability.extra.chance, 'unik_bloon_pop')
        return {
            vars = {
                card.ability.extra.x_mult,
                chance,
                trigger,
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_up
            card.ability.extra.chance = card.ability.extra.chance + card.ability.extra.chance_up
            card.ability.extra.upgraded = true
        end
    end
})