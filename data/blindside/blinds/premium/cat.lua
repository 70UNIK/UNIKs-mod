--when scored, all other scored blinds permanently gain X0.05 Chips
BLINDSIDE.Blind({
    key = 'unik_blindside_cat',
    atlas = 'unik_blindside_blinds',
    pos = {x = 2, y = 2},
    config = {
        extra = {
            value = 12,
            x_chips = 0.04,
            x_chips_up = 0.04,
        }},
    hues = {"Purple","Red", },
    rare = true,
    calculate = function(self, card, context)
        
        if context.cardarea == G.play and context.main_scoring then
            for i,v in pairs(context.scoring_hand) do
                --MAKE SURE TO AVOID ITSELF! it otherwise powercreeps chelsea
                if v ~= card then
                    v.ability["perma_x_chips"] = v.ability["perma_x_chips"] or 0
                    v.ability["perma_x_chips"] = v.ability["perma_x_chips"] + card.ability.extra.x_chips
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
            vars = {card.ability.extra.x_chips}
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.x_chips = card.ability.extra.x_chips + card.ability.extra.x_chips_up
            card.ability.extra.upgraded = true
        end
    end
})