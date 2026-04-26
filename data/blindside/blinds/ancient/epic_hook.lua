--^1.2 Mult, +2 Discards. burns itself and all blinds in hand
BLINDSIDE.Blind({
    key = 'unik_blindside_epic_hook',
    atlas = 'unik_blindside_epic_blinds',
    pos = {x = 0, y = 5},
    config = {
        extra = {
            value = 1,
            e_mult = 1.25,
            e_mult_up = 0.2,
            discards = 2,
            discards_up = 2,
        }},
    hues = {"Red", "Blue"},
    calculate = function(self, card, context) 
        if context.before and context.scoring_hand then
            if SMODS.in_scoring(card,context.scoring_hand) then
                for i,v in pairs(G.hand.cards) do
                    v.unik_burned_by_hook = true
                end
            end
        end
        if context.cardarea == G.play and context.main_scoring then
            ease_discard(card.ability.extra.discards)
            return {
                message = localize({type='variable',key='a_unik_discards_1',vars={card.ability.extra.discards}}),
                --e_mult = card.ability.extra.e_mult
                colour = G.C.MULT,
            }
        end
        if context.scoring_hand and SMODS.in_scoring(card,context.scoring_hand) and context.final_scoring_step then
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