--^0.85 Chips to Joker, burns
BLINDSIDE.Blind({
    key = 'unik_blindside_epic_straightforwardness',
    atlas = 'unik_blindside_epic_blinds',
    pos = {x = 0, y = 0},
    config = {
        extra = {
            value = 1,
            joker_e_chips = 0.9,
            joker_e_chips_down = 0.1,
        }
    },
    hues = {"Blue", "Yellow"},
    hidden = true,
    unik_ancient = true,
    calculate = function(self, card, context)
        if context.burn_card and context.cardarea == G.play and context.burn_card == card then
            return { remove = true }
        end
        if context.cardarea == G.play and context.main_scoring then
            UNIK.blindside_chips_modifyV2({e_chips = card.ability.extra.joker_e_chips})  
            return {
                message = "^" .. card.ability.extra.joker_e_chips .. " JChips",
                colour = G.C.L_BLACK
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
        return {
            vars = {
                card.ability.extra.joker_e_chips,
            }
        }
    end,
    upgrade = function(card) 
        if not card.ability.extra.upgraded then
        card.ability.extra.joker_e_chips = card.ability.extra.joker_e_chips - card.ability.extra.joker_e_chips_down
        card.ability.extra.upgraded = true
        end
    end
})