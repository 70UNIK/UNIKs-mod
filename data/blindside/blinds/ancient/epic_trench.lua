--^1.05 Chips, then increase this by ^0.05 when scored, resets at end of round
BLINDSIDE.Blind({
    key = 'unik_blindside_epic_trench',
    atlas = 'unik_blindside_epic_blinds',
    pos = {x = 0, y = 7},
    config = {
        extra = {
            value = 1,
            e_chips = 1.05,
            e_chips_base = 1.05,
            e_chips_up = 0.05,
            e_chips_gain = 0.01,
            e_chips_gain_up = 0.01,
        }},
    hues = {"Blue", "Faded"},
    always_scores = true,
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.main_scoring then
             SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "e_chips",
                scalar_value = "e_chips_gain",
                operation = '+',
                    message_colour = G.C.DARK_EDITION,
                    force_full_val = true,
                    no_message = true,

            })
            return {
                e_chips = card.ability.extra.e_chips
            }
        end
    end,
    unik_ancient = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                tostring(card.ability.extra.e_chips_gain),card.ability.extra.e_chips_base,card.ability.extra.e_chips
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.e_chips_base = card.ability.extra.e_chips_base + card.ability.extra.e_chips_up
            card.ability.extra.e_chips_gain = card.ability.extra.e_chips_gain + card.ability.extra.e_chips_gain_up
            card.ability.extra.upgraded = true
        end
    end
})