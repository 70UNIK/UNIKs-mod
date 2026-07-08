--sadistic sword
--Always shuffled to the top of the deck
--When held, If hand contains only 1 blind, retrigger and rescore it 4 times. --> 6 times
--burns when held
BLINDSIDE.Blind({
    key = 'unik_blindside_legendary_silver_sword',
    atlas = 'unik_blindside_legendary_blinds',
    pos = {x = 0, y = 3},
    config = {
        extra = {
            value = 1,
            max_cards = 1,
            max_cards_up = 1,
            shuffled_top_start = true,
            retain = true,
            interval = 1,
        }},
    hues = {"Faded","Blue"},
    calculate = function(self, card, context) 
        if context.repetition and context.cardarea == G.play and card.area == G.hand and (context.other_card == context.scoring_hand[1] ) and context.other_card.ability.extra.rescore ~= 1 and #G.play.cards <= card.ability.extra.max_cards then
            local rescores = 0
            if G.playing_cards then
                for k, v in pairs(G.playing_cards) do
                    if v:is_color("Faded") then rescores = rescores + (1/card.ability.extra.interval) end
                end 
            end
            return {
                    repetitions = math.floor(rescores)
                }
        end
        if context.unik_kite_experiment and context.scoring_hand and context.cardarea == G.play and ((not context.cardarea and not context.main_eval) or context.main_eval) and card.area == G.hand and #G.play.cards <= card.ability.extra.max_cards then
            local rescores = 0
            if G.playing_cards then
                for k, v in pairs(G.playing_cards) do
                    if v:is_color("Faded") then rescores = rescores + (1/card.ability.extra.interval) end
                end 
            end
            local validCards = {}
            for i = 1, math.floor(rescores) do
                local strct = {}
                strct[#strct+1] = context.scoring_hand[1]
                strct.unik_scoring_segment = true
                validCards[#validCards+1] = strct
            end
            
            if #validCards > 0 then
                return {
                    target_cards = validCards,
                    card = context.blueprint_card  or card,
                    message = '+1',
                    colour = HEX('9bafcf'),
                }
            end   
            
        end
    end,
    unik_exotic = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
        info_queue[#info_queue+1] = {key = 'bld_retain', set = 'Other'}
        local rescores = 0
            if G.playing_cards then
                for k, v in pairs(G.playing_cards) do
                    if  v:is_color("Faded") then rescores = rescores + (1/card.ability.extra.interval) end
                end 
            end
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_legendary_silver_sword_upgraded' or 'm_unik_blindside_legendary_silver_sword',
            vars = {
                card.ability.extra.max_cards, card.ability.extra.interval, math.floor(rescores)
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.max_cards = card.ability.extra.max_cards + card.ability.extra.max_cards_up
            card.ability.extra.upgraded = true
        end
    end
})