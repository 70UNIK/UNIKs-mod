--debuffs all blinds not adjacent to each copy of itself --> rescores adjacent blinds 2 times
BLINDSIDE.Blind({
    key = 'unik_blindside_close',
    atlas = 'unik_blindside_blinds',
    pos = {x = 0, y = 7},
    config = {
        rescore = 0,
        extra = {
            value = 20,
            rescores = 2,
            rescore = 1,
        }},
    hues = {"Red",},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.before and card.facing ~= 'back' and not card.ability.extra.upgraded then
            for i=1, #G.play.cards do
                local adjacent = false
                if G.play.cards[i].config.center.key == 'm_unik_blindside_close' then
                    adjacent = true
                end
                if i > 1 and G.play.cards[i-1].config.center.key == 'm_unik_blindside_close' then
                    adjacent = true
                end
                if i < #G.play.cards and G.play.cards[i+1].config.center.key == 'm_unik_blindside_close' then
                    adjacent = true
                end
                if not adjacent and G.play.cards[i] ~= card then
                    G.play.cards[i].config.center.blind_debuff(G.play.cards[i], true)
                end
            end
        end
        if context.cardarea == G.play and context.after and card.facing ~= 'back' and not card.ability.extra.upgraded  then
            for i=1, #G.play.cards do
                local adjacent = false
                if G.play.cards[i].config.center.key == 'm_unik_blindside_close' then
                    adjacent = true
                end
                if i > 1 and G.play.cards[i-1].config.center.key == 'm_unik_blindside_close' then
                    adjacent = true
                end
                if i < #G.play.cards and G.play.cards[i+1].config.center.key == 'm_unik_blindside_close' then
                    adjacent = true
                end
                if not adjacent and G.play.cards[i] ~= card then
                    G.play.cards[i].config.center.blind_debuff(G.play.cards[i], true)
                end
            end
        end
        if context.unik_kite_experiment and context.scoring_hand and context.cardarea == G.play and card.area == G.play and card.ability.extra.upgraded then
            local isScoring = false
            local index = -1
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i] == card then
                    isScoring = true
                    index = i
                    break
                end
            end
            if isScoring and index > 0 then
                local validCards = {}
                for z = 1, card.ability.extra.rescores do
                    local strct = {}
                    if index > 1 then
                        strct[#strct+1] = context.scoring_hand[index - 1]
                    end
                    if index < #context.scoring_hand then
                        strct[#strct+1] = context.scoring_hand[index + 1]
                    end
                    strct.unik_scoring_segment = true
                    validCards[#validCards+1] = strct
                end
                
                if #validCards > 0 then
                    return {
                        target_cards = validCards,
                        card = card,
                        message = '+1',
                    }
                end   
            end
            
            
        end
    end,
    curse = true,
    always_scores = true,
    loc_vars = function(self, info_queue, card)
        if card.ability.extra.upgraded then
            info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
        end
        
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_close_upgraded' or 'm_unik_blindside_close',
            vars = {
                card.ability.extra.rescores
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
        card.ability.extra.upgraded = true
        end
    end
})