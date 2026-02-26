--+20 Mult, debuffed if played with more than 3 blinds, X1.25 Mult, +30 Mult, debuffed if played with more than 3 blinds
BLINDSIDE.Blind({
    key = 'unik_blindside_halved',
    atlas = 'unik_blindside_blinds',
    pos = {x = 1, y = 1},
    config = {
        extra = {
            value = 20,
            mult = 20,
            multup = 10,
            card_limit = 3,
        }},
    hues = {"Blue"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.main_scoring then
            if #G.play.cards <= card.ability.extra.card_limit then
                return {
                    mult = card.ability.extra.mult
                }
            else
            if card.facing ~= 'back' then 
            card:flip()
            card_eval_status_text(card, "debuff", nil, nil, nil, nil)
            end

            end
        end
    end,
    common = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.card_limit,
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multup
            card.ability.extra.upgraded = true
        end
    end
})
--eval G.hand.cards[1]:set_ability('m_unik_blindside_halved')