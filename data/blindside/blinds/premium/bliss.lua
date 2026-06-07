--+100 chips and X1.75 chips, self debuffing with a 1 in 2 chance --> +200 chips and X2.5 chips
BLINDSIDE.Blind({
    key = 'unik_blindside_bliss',
    atlas = 'unik_blindside_blinds',
    pos = {x = 7, y = 2},
    config = {
        extra = {
            value = 17,
            x_chips = 1.75,
            x_chips_up = 0.75,
            chips = 75,
            chips_up = 75,
            chance = 1,
            trigger = 2,
        }},
    always_scores = true,
    hues = {"Green","Blue"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.before and card.facing ~= 'back' then
            if not SMODS.pseudorandom_probability(card, pseudoseed("blissflip"), card.ability.extra.chance, card.ability.extra.trigger, 'blissflip') and card.facing ~= "back" then
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
                    chips = card.ability.extra.chips,
                    x_chips = card.ability.extra.x_chips,
                }
            else
                card_eval_status_text(card, "debuff", nil, nil, nil, nil)
                return {
    
                }
            end
            
        end
    end,
    rare = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'unik_self_debuffing', set = 'Other'}
        --info_queue[#info_queue+1] = {key = 'unik_self_debuffing', set = 'Other'}
         local chance, trigger = SMODS.get_probability_vars(card, card.ability.extra.chance, card.ability.extra.trigger, 'blissflip')
        return {
            vars = {
                card.ability.extra.chips,card.ability.extra.x_chips, chance, trigger
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
        card.ability.extra.upgraded = true
        card.ability.extra.x_chips = card.ability.extra.x_chips + card.ability.extra.x_chips_up
        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_up
        end
    end
})