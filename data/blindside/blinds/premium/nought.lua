BLINDSIDE.Blind({
    key = 'unik_blindside_nought',
    atlas = 'unik_blindside_blinds',
    pos = {x = 1, y = 3},
    config = {
        extra = {
            value = 100,
            badchance = 1,
            trigger = 2,
        }},
    hues = {"Blue"},
rare = true,
    always_scores = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.before and card.facing ~= 'back' then
            if not SMODS.pseudorandom_probability(card, pseudoseed("nought_unik"), card.ability.extra.badchance, card.ability.extra.trigger, 'nought_unik') or card.ability.extra.upgraded then
                card:flip()
                card:flip()
                add_tag(Tag('tag_unik_blindside_recursive'))
                return {
                    focus = card,
                    message = localize('k_tagged_ex'),
                    card = card,
                }
            else
                if card.facing ~= 'back' then 
                    card:flip()
                end
                card_eval_status_text(card, "debuff", nil, nil, nil, nil)
                return {
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_TAGS['tag_unik_blindside_recursive']
        if not card.ability.extra.upgraded then
            info_queue[#info_queue+1] = {key = 'unik_self_debuffing', set = 'Other'}
        end
        
        local chance, trigger = SMODS.get_probability_vars(card, card.ability.extra.badchance, card.ability.extra.trigger, 'nought_unik')
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_nought' or 'm_unik_blindside_nought',
            vars = {
                chance,
                trigger
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.upgraded = true
        end
    end
})