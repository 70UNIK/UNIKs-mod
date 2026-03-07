--gains  +2 Mult when drawn after the deck is reshuffled (currently +2 Mult)
BLINDSIDE.Blind({
    key = 'unik_blindside_artesian',
    atlas = 'unik_blindside_blinds',
    pos = {x = 5, y = 0},
    config = {
        extra = {
            value = 24,
            chips = 0,
            chips_mod = 10,
            chips_up = 10,
        }},
    hues = {"Blue"},
    calculate = function(self, card, context) 
        if (context.hand_drawn and context.cardarea == G.hand and tableContains(card, context.hand_drawn)) or (context.other_drawn and context.cardarea == G.hand and tableContains(card, context.other_drawn)) then
            if  G.GAME.current_round.reshuffles_round and  G.GAME.current_round.reshuffles_round > 0 then
                local drawn = false
                local hand_drawn = context.hand_drawn or context.other_drawn
                for i,v in pairs(hand_drawn) do
                    if v == card then
                        drawn = true
                        break
                    end
                end
                if drawn then
                    SMODS.scale_card(card, {
                        ref_table =card.ability.extra,
                        ref_value = "chips",
                        scalar_value = "chips_mod",
                        message_key = "a_chips",
                        message_colour = G.C.CHIPS,
                    })
                    return {

                    }
                end
            end
            
        end
        if context.cardarea == G.play and context.main_scoring then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
    common = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,card.ability.extra.chips_mod
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.chips_mod = card.ability.extra.chips_mod + card.ability.extra.chips_up
            card.ability.extra.upgraded = true
        end
    end
})