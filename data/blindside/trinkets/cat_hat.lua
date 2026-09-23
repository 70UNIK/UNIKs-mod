SMODS.Joker({
    key = 'unik_blindside_cat_hat',
    atlas = 'unik_trinkets',
    pos = {x = 2, y = 0},
    rarity = 'bld_keepsake',
    cost = 15,
    blueprint_compat = true,
    eternal_compat = true,
    config = {
            extra = {
                x_mult = 1.75,
            }
        },
    in_pool = function(self, args)
        return UNIK.hasBlindside()
    end,
    loc_vars = function (self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.x_mult,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card and context.other_card.facing ~= "back" and not context.end_of_round then
            if (context.other_card == context.scoring_hand[1] ) then
                if context.other_card:is_color("Faded", true, false) or context.other_card:is_color("Red", true, false) or context.other_card:is_color("Yellow", true, false) then
                    return {
                        x_mult = card.ability.extra.x_mult,
                    }
                end
                
            end
        end
    end,
})