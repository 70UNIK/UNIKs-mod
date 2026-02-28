--+X0.4 Mult for each Green Blind in scoring hand
BLINDSIDE.Blind({
    key = 'unik_blindside_evergreen',
    atlas = 'unik_blindside_blinds',
    pos = {x = 7, y = 1},
    config = {
        extra = {
            value = 17,
            x_mult = 1,
            x_mult_mod = 0.3,
            x_mult_mod_upgrade = 0.3,
        }},
    hues = {"Green","Faded"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.main_scoring then

            return {
                x_mult = card.ability.extra.x_mult + findNoColours(context,'Green') * card.ability.extra.x_mult_mod
            }
        end
    end,
    rare = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult_mod, card.ability.extra.x_mult + findNoColours(nil,'Green') * card.ability.extra.x_mult_mod
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
        card.ability.extra.upgraded = true
        card.ability.extra.x_mult_mod = card.ability.extra.x_mult_mod + card.ability.extra.x_mult_mod_upgrade
        end
    end
})

function findNoColours(context,color)
    local colours = 0
    if context and context.scoring_hand then
        for i,v in pairs(context.scoring_hand) do
            if v:is_color(color, true, false) then
                colours = colours + 1
            end
        end
        return colours
    else
        if G and G.GAME then
            if G.hand then
                if G.hand.highlighted then
                    for i,v in pairs(G.hand.highlighted) do
                        if v:is_color(color, true, false) then
                            colours = colours + 1
                        end
                    end
                end

                return colours
            end
        end
    end
    return 1
end