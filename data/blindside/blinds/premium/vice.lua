--rescore all played blinds, and create a finisher tag when scored (replaces the next Boss Joker with a Finisher/Legendary Joker)
--rescore all played blinds
BLINDSIDE.Blind({
    key = 'unik_blindside_vice',
    atlas = 'unik_blindside_blinds',
    pos = {x = 7, y = 5},
    config = {
        extra = {
            value = 20,
        }},
    hues = {"Faded"},
    always_scores = true,
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.before and card.facing ~= 'back' then

             G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        
                    add_tag(Tag('tag_unik_blindside_soul'))
                    return true
                    end
                }))
            return {
                message = localize("k_unik_too_bad"),
                colour = G.C.SECONDARY_SET.Tarot,
            }
        end
        if context.unik_kite_experiment and context.scoring_hand and card.area == G.play then
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
                    colour = HEX('404040'),
                }
            end   
            
        end
    end,
    rare = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
        if not card.ability.extra.upgraded then
            info_queue[#info_queue+1] = G.P_TAGS['tag_unik_blindside_soul']
        end
        
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_vice_upgraded' or 'm_unik_blindside_vice',
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
        card.ability.extra.upgraded = true
        end
    end
})