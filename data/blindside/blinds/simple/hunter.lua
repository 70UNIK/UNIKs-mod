BLINDSIDE.Blind({
    key = 'unik_blindside_hunter',
    atlas = 'unik_blindside_blinds',
    pos = {x =4, y = 7},
    config = {
        extra = {
            value = 21,
            cards = 1,
            cards_up = 1,
            discards = 1,
            discards_up = 1,
        }},
    hues = {"Red"},
    always_scores = true,
    calculate = function(self, card, context) 
        if context.on_select_play and card.highlighted then
            local found = false
            local count = 0
            for i,v in pairs(G.hand.highlighted) do
                if found and count < card.ability.extra.cards then
                    v.debuff = true --preemptive measure (the goblin for instance)
                end
                if v == card then
                    found = true
                end
            end
        end
        if context.cardarea == G.play and context.before and card.facing ~= 'back'  then
            card.ability.extra.successful = nil
            local count = 0
            local found = false
            for i,v in pairs(context.full_hand) do
                if found and count < card.ability.extra.cards then
                    v.to_be_destroyed_by_hunter = true
                    v.config.center.blind_debuff(v, true)
                    card.ability.extra.successful = true
                    count = count + 1
                end
                if v == card then
                    found = true
                end
            end
            if count > 0 then
                ease_discard(card.ability.extra.discards)
                return {
                    message = localize('k_unik_hunter_1'),
                    colour = G.C.RED
                }
            end
        end
        if context.destroy_card  then
            if context.destroy_card.to_be_destroyed_by_hunter then
                context.destroy_card.to_be_destroyed_by_hunter = nil
                return { 
                    remove = true, 
                    message = localize('k_unik_hunter_2'),
                    colour = G.C.RED,
                }
            end
        end
        if context.burn_card and context.cardarea == G.play and context.burn_card == card and card.ability.extra.successful then
            card.ability.extra.successful = nil
            return { remove = true }
        end
    end,
    common = true,
    loc_vars = function(self, info_queue, card)
         info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
        return {
            vars = {
                card.ability.extra.cards,card.ability.extra.discards
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.cards = card.ability.extra.cards + card.ability.extra.cards_up
            card.ability.extra.discards = card.ability.extra.discards + card.ability.extra.discards_up
            card.ability.extra.upgraded = true
        end
    end
})