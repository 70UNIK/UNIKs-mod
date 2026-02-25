--When played, Gains X0.05 Chips whenever +Chips, Xchips, ^Chips, etc... is triggered --> When played, Gains X0.1 Chips whenever +Chips, Xchips, ^Chips, etc... is triggered
BLINDSIDE.Blind({
    key = 'unik_blindside_catterfly',
    atlas = 'unik_blindside_blinds',
    pos = {x = 0, y = 2},
    config = {
        extra = {
            value = 17,
            x_chips = 1,
            x_chip_mod = 0.05,
            x_chip_mod_upgrade = 0.05,
        }},
    hues = {"Purple"},
    calculate = function(self, card, context) 
         if context.before then
            for i,v in pairs(context.scoring_hand) do
                if v == card then
                    card.ability.unik_in_scoring_hand = true
                    break
                end
            end
            
         end
        if context.cardarea == G.play and context.main_scoring then
            return {
                x_chips = card.ability.extra.x_chips
            }
        end
        if context.after then
            card.ability.unik_in_scoring_hand = nil
        end
    end,
    rare = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_chips,card.ability.extra.x_chip_mod
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
        card.ability.extra.upgraded = true
        card.ability.extra.x_chip_mod = card.ability.extra.x_chip_mod + card.ability.extra.x_chip_mod_upgrade
        end
    end
})

--eval G.hand.cards[1]:set_ability('m_unik_blindside_catterfly')