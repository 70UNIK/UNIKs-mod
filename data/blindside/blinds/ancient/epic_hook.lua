--^1.2 Mult, +2 Discards. burns itself and all blinds in hand
BLINDSIDE.Blind({
    key = 'unik_blindside_epic_hook',
    atlas = 'unik_blindside_epic_blinds',
    pos = {x = 0, y = 5},
    config = {
        extra = {
            value = 1,
            e_mult = 1.2,
            e_mult_up = 0.15,
            discards = 2,
            discards_up = 2,
        }},
    hues = {"Red", "Blue"},
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
                for i,v in pairs(G.hand.cards) do
                    v.ability.unik_burned_by_hook = true
                end
            end
        end
        if context.cardarea == G.play and context.main_scoring then
            ease_discard(card.ability.extra.discards)
            return {
                e_mult = card.ability.extra.e_mult
            }
        end
        if context.burn_card and context.cardarea == G.play and context.burn_card == card then
            return { remove = true }
            
        end
    end,
    unik_ancient = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
        return {
            vars = {
                card.ability.extra.e_mult,card.ability.extra.discards
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.e_mult = card.ability.extra.e_mult + card.ability.extra.e_mult_up
            card.ability.extra.discards = card.ability.extra.discards + card.ability.extra.discards_up
        card.ability.extra.upgraded = true
        end
    end
})