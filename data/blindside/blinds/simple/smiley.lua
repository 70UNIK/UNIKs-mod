--+$6, create a handcuffs tag, burns
BLINDSIDE.Blind({
    key = 'unik_blindside_smiley',
    atlas = 'unik_blindside_blinds',
    pos = {x = 0, y = 1},
    config = {
        extra = {
            value = 34,
            dollars = 6,
            dollars_up = 6,
        }
    },
    hues = {"Yellow"},
    calculate = function(self, card, context) 
        if context.before then
            local exists = false
            for i,v in pairs(context.scoring_hand) do
                if v == card then
                    exists = true
                    break
                end
            end
            if exists then
                add_tag(Tag('tag_unik_blindside_handcuffs'))
                return {
                    focus = card,
                    message = localize('k_unik_too_bad'),
                    card = card,
                    colour = G.C.MULT,
                }
            end
        end
        if context.cardarea == G.play and context.main_scoring then
            
            return {
                p_dollars = card.ability.extra.dollars
            }
        end
    end,
    common = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS['tag_unik_blindside_handcuffs']
        return {
            vars = {
                card.ability.extra.dollars,
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.dollars_up
            card.ability.extra.upgraded = true
        end
    end,
})