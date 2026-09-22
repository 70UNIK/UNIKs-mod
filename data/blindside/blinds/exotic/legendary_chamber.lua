--legendary chamber: 
BLINDSIDE.Blind({
    key = 'unik_blindside_legendary_chartuese_chamber',
    atlas = 'unik_blindside_legendary_blinds',
    pos = {x = 0, y = 5},
    config = {
        extra = {
            value = 1,
            e_mult = 1,
            e_mult_mod = 0.03,
            e_mult_mod_up = 0.01,
        }},
    hues = {"Green","Purple"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.main_scoring then
            local colours = {'Red', 'Green', 'Blue', 'Yellow', 'Purple', 'Faded'}
            local hues = {}
            for h,v in pairs(context.scoring_hand) do
                if v ~= card then
                    if v.config.center.hues then
                        for z = 1, #v.config.center.hues do
                            hues[v.config.center.hues[z]] = true
                        end
                        
                    end
                end
                
            end
            local count = 0
            for i,v in pairs(hues) do
                count = count + 1
            end
            
            return {
                e_mult = card.ability.extra.e_mult + card.ability.extra.e_mult_mod * count
            }
        end
    end,
    unik_exotic = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.e_mult,card.ability.extra.e_mult_mod
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.e_mult_mod = card.ability.extra.e_mult_mod + card.ability.extra.e_mult_mod_up
            card.ability.extra.upgraded = true
        end
    end
})