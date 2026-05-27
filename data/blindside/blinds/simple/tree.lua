--+4 Mult for each green blind in scoring hand
BLINDSIDE.Blind({
    key = 'unik_blindside_tree',
    atlas = 'unik_blindside_blinds',
    pos = {x = 3, y = 4},
    config = {
        extra = {
            value = 23,
            mult = 10,
            mult_up = 10,
            chance = 5,
            trigger = 5,
            interval = 2,
        }},
        
    always_scores = true,
    hues = {"Green"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.before and card.facing ~= 'back' then
            --print(findNoColours(nil,'Green',card))
             local greens = 0
            if G.playing_cards then
                for k, v in pairs(G.playing_cards) do
                    if v:is_color("Green") then 
                        greens = greens + 1 
                    end
                end 
                --greens = greens - 1
            end
            greens = math.floor(greens/card.ability.extra.interval)
            if not SMODS.pseudorandom_probability(card, pseudoseed("treeflip"), math.max(0,card.ability.extra.chance -  greens), card.ability.extra.trigger, 'treeflip') and card.facing ~= "back" then
                card:flip()
                card:flip()
                return {
                }
            else
                if card.facing ~= 'back' then 
                card:flip()
                end
                return {
                }
            end
        end
        if context.cardarea == G.play and context.main_scoring then
            if card.facing ~= 'back' then
                return {
                    mult = card.ability.extra.mult
                }
            else
                                card_eval_status_text(card, "debuff", nil, nil, nil, nil)
                -- return {
                --     message = localize('k_nope_ex'),
                --     colour = G.C.GREEN
                -- }
            end
            
        end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'unik_self_debuffing', set = 'Other'}
         local greens = 0
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if v:is_color("Green") then 
                    greens = greens + 1 
                end
            end 
            
        end
           greens = math.floor(greens/card.ability.extra.interval) 

        local chance, trigger = SMODS.get_probability_vars(card, math.max(0,card.ability.extra.chance -  greens), card.ability.extra.trigger, 'treeflip')
        return {
            vars = {
                card.ability.extra.mult,chance, trigger,card.ability.extra.interval
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
        card.ability.extra.upgraded = true
        card.ability.extra.mult = card.ability.extra.mult+ card.ability.extra.mult_up
        end
    end
})
