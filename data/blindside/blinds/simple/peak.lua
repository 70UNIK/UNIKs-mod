--when scored, scored blinds permanently gain +5 Chips
BLINDSIDE.Blind({
    key = 'unik_blindside_peak',
    atlas = 'unik_blindside_blinds',
    pos = {x = 4, y = 4},
    config = {
        extra = {
            value = 12,
            chips = 5,
            chips_up = 5,
        }},
    hues = {"Blue" },
    common = true,
    calculate = function(self, card, context)
        
        if context.cardarea == G.play and context.main_scoring then
            for i,v in pairs(context.scoring_hand) do
                if v ~= card then
                    v.ability["perma_bonus"] = v.ability["perma_bonus"] or 0
                    v.ability["perma_bonus"] = v.ability["perma_bonus"] + card.ability.extra.chips
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end,
                    }))
                end

            end
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.chips}
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_up
            card.ability.extra.upgraded = true
        end
    end
})