BLINDSIDE.Blind({
    key = 'unik_blindside_bronze_bug',
    atlas = 'unik_blindside_blinds',
    pos = {x = 9, y = 1},
    config = {
        extra = {
            value = 1,
            retriggers = 1,
            rescores = 1,
            min_cards = 5,
            retriggers_up = 1,
            min_cards_down = 1,
        }},
    hues = {"Faded"},
    legendary = true,
    calculate = function(self, card, context)
        if context.unik_kite_experiment and context.scoring_hand and card.area == G.play and card.facing ~= 'back' and #context.scoring_hand >= card.ability.extra.min_cards then
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
                    card =  context.blueprint_card or card,
                    message = '+1',
                    colour = HEX('754223'),
                }
            end   
            
        end
        if context.cardarea == G.play and context.before and card.facing ~= 'back' and #context.scoring_hand < card.ability.extra.min_cards and not context.blueprint then
            for i=1, #G.play.cards do
                if G.play.cards[i] ~= card then
                    G.play.cards[i].config.center.blind_debuff(G.play.cards[i], true)
                    
                else
                    if card.facing ~= 'back' then 
                        card:flip()
                    end
                    card_eval_status_text(card, "debuff", nil, nil, nil, nil)
                    return {
                    }
                end
            end
        end
        if context.cardarea == G.play and context.after and card.facing ~= 'back' and #context.scoring_hand < card.ability.extra.min_cards and not context.blueprint then
            for i=1, #G.play.cards do
                if  G.play.cards[i] ~= card then
                    G.play.cards[i]:set_debuff(false)

                end
            end
        end
        if context.cardarea == G.play and context.main_scoring and context.scoring_hand and #context.scoring_hand >= card.ability.extra.min_cards then
            return {
                    func = function()
                            local retrigger_cards = {}
                            for i=1, #context.scoring_hand do
                                if context.scoring_hand[i] ~= card then
                                table.insert(retrigger_cards, context.scoring_hand[i])
                                end
                            end
                            for streak_index = 1, #retrigger_cards do
                                local streak_card = retrigger_cards[streak_index]
                                for _, play_card in ipairs(G.play.cards) do
                                    if play_card == streak_card and streak_card.ability.extra.rescore ~= 1 then
                                        card:juice_up()
                                        local passed_context = context
                                        card_eval_status_text(play_card, 'extra', nil, nil, nil, {
                                            message = localize('k_again_ex'),
                                            colour = HEX('754223')})
                                        BLINDSIDE.rescore_card(play_card, passed_context)
                                    end
                                end
                            end
                            SMODS.calculate_context({rescore_cards = retrigger_cards})
                    end
                }
        end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
        return {
            vars = {card.ability.extra.retriggers,card.ability.extra.rescores}
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.retriggers = card.ability.extra.retriggers + card.ability.extra.retriggers_up
            card.ability.extra.min_cards = card.ability.extra.min_cards - card.ability.extra.min_cards_down
            card.ability.extra.upgraded = true
        end
    end,
    always_scores = true,
})