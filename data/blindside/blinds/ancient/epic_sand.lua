--X1.5 Mult and log_50(Mult) rescore this for every 2 tags  held
BLINDSIDE.Blind({
    key = 'unik_blindside_epic_sand',
    atlas = 'unik_blindside_epic_blinds',
    pos = {x = 0, y = 2},
    config = {
        extra = {
            value = 1,
            x_mult = 1.5,
            log_base = 40,
            log_down = 20,
            x_mult_up = 0.5,
            tags = 2,
            tag_down = 1,
        }
    },
    hues = {"Yellow", "Blue"},
    hidden = true,
    unik_ancient = true,
    calculate = function(self, card, context)
        if context.unik_after_effect and context.scoring_hand then
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i] == card then
                    local tags = 0

                    for key, tag in pairs(G.GAME.tags) do
                        if not tag.triggered then
                            tags = tags + 1
                        end
                    end
                    return {
                        rescore = math.floor(tags / card.ability.extra.tags)
                    }
                end
            end
            
        end
        if context.cardarea == G.play and context.main_scoring then
            
            return {
                x_mult = card.ability.extra.x_mult,
                xlog_mult = card.ability.extra.log_base,
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
        local tags = 0
        if G.GAME then
                for key, tag in pairs(G.GAME.tags) do
                            if not tag.triggered then
                                tags = tags + 1
                            end
                        end
        end

        return {
            vars = {
                card.ability.extra.x_mult,card.ability.extra.log_base,card.ability.extra.tags,math.floor(tags / card.ability.extra.tags)
            }
        }
    end,
    upgrade = function(card) 
        if not card.ability.extra.upgraded then
        card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_up
        card.ability.extra.log_base = card.ability.extra.log_base - card.ability.extra.log_down
        card.ability.extra.tags = card.ability.extra.tags - card.ability.extra.tag_down
        card.ability.extra.upgraded = true
        end
    end
})