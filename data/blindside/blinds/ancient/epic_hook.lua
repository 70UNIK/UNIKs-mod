--^1.2 Mult, +2 Discards. burns itself and all blinds in hand
BLINDSIDE.Blind({
    key = 'unik_blindside_epic_hook',
    atlas = 'unik_blindside_epic_blinds',
    pos = {x = 0, y = 5},
    config = {
        extra = {
            value = 1,
            e_mult = 1.3,
            e_mult_up = 0.15,
            discards = 2,
            discards_up = 2,
        }},
    hues = {"Red", "Blue"},
    always_scores = true,
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.main_scoring then
            ease_discard(card.ability.extra.discards)
            return {
                e_mult = card.ability.extra.e_mult
            }
        end
         if context.burn_card and context.cardarea == G.play and context.burn_card == card then
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function() 
                            for i=#G.hand.cards, 1, -1 do
                local card2 = G.hand.cards[i]
                if not card2.ability.extra.burned_by_hook then
                    card2.ability.extra.burned_by_hook = true 
                    card2:start_burn(G.hand)
                    
                end

            end
                return true end }))
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