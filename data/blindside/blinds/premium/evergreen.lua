--+X0.4 Mult for each Green Blind in scoring hand
BLINDSIDE.Blind({
    key = 'unik_blindside_evergreen',
    atlas = 'unik_blindside_blinds',
    pos = {x = 7, y = 1},
    config = {
        extra = {
            value = 17,
            x_mult = 2,
            x_mult_up = 1,
            chance = 5,
            trigger = 5,
        }},
    always_scores = true,
    hues = {"Green","Faded"},
    calculate = function(self, card, context) 
        -- if context.cardarea == G.play and context.before and card.facing ~= 'back' then
        --     --print(findNoColours(nil,'Green',card))
        --     if not SMODS.pseudorandom_probability(card, pseudoseed("evergreenflip"), math.max(0,card.ability.extra.chance - findNoColours(nil,'Green',card)), card.ability.extra.trigger, 'evergreenflip') and card.facing ~= "back" then
        --         card:flip()
        --         card:flip()
        --         return {
        --         }
        --     else
        --         if card.facing ~= 'back' then 
        --         card:flip()
        --         end
        --         return {
        --         }
        --     end
        -- end
        if context.cardarea == G.play and context.main_scoring then
            if not SMODS.pseudorandom_probability(card, pseudoseed("evergreenflip"), math.max(0,card.ability.extra.chance - findNoColours(nil,'Green',card)), card.ability.extra.trigger, 'evergreenflip') then
                return {
                    x_mult = card.ability.extra.x_mult
                }
            else
                                --card_eval_status_text(card, "debuff", nil, nil, nil, nil)
                return {
                    message = localize('k_nope_ex'),
                    colour = G.C.GREEN
                }
            end
            
        end
    end,
    rare = true,
    loc_vars = function(self, info_queue, card)
        --info_queue[#info_queue+1] = {key = 'unik_self_debuffing', set = 'Other'}
         local chance, trigger = SMODS.get_probability_vars(card, math.max(0,card.ability.extra.chance - findNoColours(nil,'Green',card)), card.ability.extra.trigger, 'evergreenflip')
        return {
            vars = {
                card.ability.extra.x_mult, chance, trigger
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
        card.ability.extra.upgraded = true
        card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_up
        end
    end
})

function findNoColours(context,color,card)
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
            if G.play and G.play.cards and #G.play.cards > 0 and card.area == G.play then
                for i,v in pairs(G.play.cards) do
                    if v:is_color(color, true, false) then
                        colours = colours + 1
                    end
                end

                return colours
            end
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