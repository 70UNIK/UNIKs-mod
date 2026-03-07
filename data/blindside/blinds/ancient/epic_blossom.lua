--Rescores the leftmost blind for every red and faded blinds in full deck
BLINDSIDE.Blind({
    key = 'unik_blindside_epic_blossom',
    atlas = 'unik_blindside_epic_blinds',
    pos = {x = 0, y = 8},
    config = {
        extra = {
            value = 1,
            interval = 1
        }},
    hues = {"Red", "Faded"},
    calculate = function(self, card, context) 
        if context.unik_kite_experiment and context.scoring_hand and context.cardarea == G.play and ((not context.cardarea and not context.main_eval) or context.main_eval) and card.area == G.hand then
            local validCards = {}
            local rescores = 0
            if G.playing_cards then
                for k, v in pairs(G.playing_cards) do
                    if v:is_color("Red") or v:is_color("Faded") then rescores = rescores + (1/card.ability.extra.interval) end
                end 
            end

            for i = 1, math.floor(rescores) do
                local strct = {}
                strct[#strct+1] = context.scoring_hand[1]
                if card.ability.extra.upgraded then
                    strct[#strct+1] = context.scoring_hand[#context.scoring_hand]
                end
                strct.unik_scoring_segment = true
                validCards[#validCards+1] = strct
            end
            
            if #validCards > 0 then
                return {
                    target_cards = validCards,
                    card = card,
                    message = '+1',
                    colour = HEX('F16C74'),
                }
            end   
            
        end
    end,
    unik_ancient = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
        local rescores = 0
            if G.playing_cards then
                for k, v in pairs(G.playing_cards) do
                    if v:is_color("Red") or v:is_color("Faded") then rescores = rescores + (1/card.ability.extra.interval) end
                end 
            end
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_epic_blossom_upgraded' or 'm_unik_blindside_epic_blossom',
            vars = {
                math.floor(rescores),card.ability.extra.interval
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
        card.ability.extra.upgraded = true
        end
    end
})