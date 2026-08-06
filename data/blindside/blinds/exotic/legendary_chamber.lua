--legendary chamber: 
BLINDSIDE.Blind({
    key = 'unik_blindside_legendary_chartuese_chamber',
    atlas = 'unik_blindside_legendary_blinds',
    pos = {x = 0, y = 5},
    config = {
        extra = {
            value = 1,
            x_mult = 2,
            xlogmult_base = 5,
            x_mult_up = 1,
            xlogmult_basedown = 1,
        }},
    hues = {"Green","Purple"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.main_scoring then
            for h,v in pairs(context.scoring_hand) do
                if v ~= card then
                    local hues = {}
                    local detectedHues = {}
                    local colours = {'Red', 'Green', 'Blue', 'Yellow', 'Purple', 'Faded'}
                    for i = 1, #colours do
                        if v:is_color(colours[i]) then
                            hues[colours[i]] = true
                        end
                    end
                    for j,x in pairs(G.hand.cards) do
                        for k,y in pairs(hues) do
                            if x:is_color(k) then
                                detectedHues[k] = true
                            end
                        end
                    end
                    for a,z in pairs(detectedHues) do
                        G.E_MANAGER:add_event(Event({
                            trigger = 'immediate',
                            func = function()
                                card:juice_up()
                                return true
                            end
                        }))
                        SMODS.calculate_effect({
                            x_mult = card.ability.extra.x_mult,
                            xlog_mult = card.ability.extra.xlogmult_base,
                        }, v)
                    end
                end
                
                
            end
            
            return {
                
            }
        end
    end,
    unik_exotic = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,card.ability.extra.xlogmult_base
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.xlogmult_base = card.ability.extra.xlogmult_base - card.ability.extra.xlogmult_basedown
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_up
            card.ability.extra.upgraded = true
        end
    end
})