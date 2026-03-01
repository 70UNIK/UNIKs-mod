--if part of a discard, destroy 1->2 cards to its right and earn $3 then burns
BLINDSIDE.Blind({
    key = 'unik_blindside_trade',
    atlas = 'unik_blindside_blinds',
    pos = {x =3, y = 3},
    config = {
        extra = {
            value = 23,
            money = 3,
            cards = 1,
            cards_up = 1,
            money_up = 3,
        }},
    hues = {"Yellow"},
    calculate = function(self, card, context) 
        if context.pre_discard and context.full_hand then
            local activate = false
            local counter = 0
            for i = 1, #context.full_hand do
                if activate and counter < card.ability.extra.cards then
                    counter = counter + 1
                    context.full_hand[i].unik_marked_for_destruction_after_discard = true
                end
                if context.full_hand[i] == card then
                    activate = true
                end
            end
        end
        if context.discard and context.main_eval and context.other_card == card then
            ease_dollars(card.ability.extra.money)
            return { 
                message = "$" .. card.ability.extra.money, 
                burn = true 
            }

            -- local count = false
            -- local cards = {}
            -- for i = 1, #G.hand.highlighted do
            --     if count and #cards < card.ability.extra.cards then
            --         cards[#cards+1] = G.hand.highlighted[i]
            --     end
            --     if card == G.hand.highlighted[i] then
            --         count = true
            --     end
            -- end
            -- SMODS.destroy_cards(cards)
            
            
        end
    end,
    common = true,
    loc_vars = function(self, info_queue, card)
         info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
        return {
            vars = {
                card.ability.extra.cards,card.ability.extra.money,
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.cards = card.ability.extra.cards + card.ability.extra.cards_up
            card.ability.extra.money = card.ability.extra.money + card.ability.extra.money_up
            card.ability.extra.upgraded = true
        end
    end
})