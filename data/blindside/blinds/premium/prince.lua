--+5 Mult, creates a crown tag (disabl)
BLINDSIDE.Blind({
    key = 'unik_blindside_prince',
    atlas = 'unik_blindside_blinds',
    pos = {x = 3, y = 1},
    config = {
        extra = {
            value = 25,
            mult = 6,
            multup = 6,
        }},
    hues = {"Red"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.main_scoring then
            if card.ability.extra.upgraded then
                add_tag(Tag('tag_unik_blindside_dethroning'))
            end
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.before and not card.ability.extra.upgraded then
            local exists = false
            for i,v in pairs(context.scoring_hand) do
                if v == card then
                    exists = true
                    break
                end
            end
            if exists and not card.ability.extra.upgraded then
                add_tag(Tag('tag_unik_blindside_dethroning'))
                return {
                    focus = card,
                    message = localize('k_tagged_ex'),
                    card = card,
                }
            end
        end
    end,
    rare = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_unik_blindside_dethroning
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_prince_upgraded' or 'm_unik_blindside_prince',
            vars = {
                card.ability.extra.mult,
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multup
            card.ability.extra.upgraded = true
        end
    end
})
--eval G.hand.cards[1]:set_ability('m_unik_blindside_prince')