--+4 Mult for each green blind in scoring hand
BLINDSIDE.Blind({
    key = 'unik_blindside_tree',
    atlas = 'unik_blindside_blinds',
    pos = {x = 3, y = 4},
    config = {
        extra = {
            value = 23,
            mult_mod = 4,
            mult_mod_up = 4,
        }},
    hues = {"Green","Faded"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.main_scoring then

            return {
                mult = findNoColours(context,'Green') * card.ability.extra.mult_mod
            }
        end
    end,
    rare = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult_mod, findNoColours(nil,'Green') * card.ability.extra.mult_mod
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
        card.ability.extra.upgraded = true
        card.ability.extra.mult_mod = card.ability.extra.mult_mod + card.ability.extra.mult_mod_up
        end
    end
})
