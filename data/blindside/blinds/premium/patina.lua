BLINDSIDE.Blind({
    key = 'unik_blindside_patina',
    atlas = 'unik_blindside_blinds',
    pos = {x = 4, y = 5},
    config = {
        extra = {
            value = 22,
            fail = 3,
            chance = 5,
        }},
    hues = {"Yellow", "Green"},
    always_scores = true,
    calculate = function(self, card, context) 
         if context.cardarea == G.play and context.before and card.facing ~= 'back' then
            if not SMODS.pseudorandom_probability(card, pseudoseed("patflip"), card.ability.extra.fail, card.ability.extra.chance, 'patflip') or card.ability.extra.upgraded then
                card:flip()
                card:flip()
            else
                if card.facing ~= 'back' then 
                    card:flip()
                end
                card_eval_status_text(card, "debuff", nil, nil, nil, nil)
                return {
                }
            end
        end
        if context.unik_kite_experiment and context.scoring_hand and card.area == G.play and card.facing ~= 'back' then
            local validCards = {}
            for i = 1, 1 do
                local strct = {}
                for i,v in pairs(context.scoring_hand) do
                    strct[#strct+1] = v
                end
                strct.unik_scoring_segment = true
                validCards[#validCards+1] = strct
            end
            
            if #validCards > 0 then
                return {
                    target_cards = validCards,
                    card = card,
                    message = '+1',
                    colour = HEX('ff9052'),
                }
            end   
            
        end
    end,
    rare = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
         if not card.ability.extra.upgraded then
            info_queue[#info_queue+1] = {key = 'unik_self_debuffing', set = 'Other'}
        end
        local chance, trigger = SMODS.get_probability_vars(card, card.ability.extra.fail, card.ability.extra.chance, 'patflip')
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_patina_upgraded' or 'm_unik_blindside_patina',
            vars = {
                chance,trigger
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.upgraded = true
        end
    end
})