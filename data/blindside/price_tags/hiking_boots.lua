--PRICE TAGS:
SMODS.Voucher {
    key = 'unik_blindside_hiking_boots',
    atlas = 'unik_blindside_consumables',
    pos = {x = 0, y = 3},
    cost = 10,
    in_pool = function(self, args)
        return UNIK.hasBlindside()
    end,
    set_card_type_badge = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_relic'), G.C.RED, G.C.WHITE, 1.2 )
    end,
    redeem = function(self, card)
        add_tag(Tag('tag_unik_blindside_hiking_boots_relic'))
    end,
    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = {key = 'p_unik_summit_2', set = 'Other', vars = {G.P_CENTERS.p_unik_summit_2.config.choose, G.P_CENTERS.p_unik_summit_2.config.extra}}
        return {}
    end,
    calculate = function(self, card, context)
        if context.starting_shop and card.ability.triggered then
            card.ability.triggered = false
            -- Adds a free booster to the shop
            G.E_MANAGER:add_event(Event {
                func = function()
                local booster = SMODS.add_booster_to_shop('p_unik_summit_2')
                booster.ability.couponed = true
                booster:set_cost()
                return true
                end
            })
            end

            if context.end_of_round and context.main_eval and G.GAME.blind.boss then
            card.ability.triggered = true
        end
    end
}
-- function UNIK.add_booster_to_blindshop(key)
--     if UNIK.hasBlindside() then
--         if key then assert(G.P_CENTERS[key], "Invalid booster key: "..key) else key = get_pack('shop_pack').key end
--         local card = Card(G.shop_booster.T.x + G.shop_booster.T.w/2,
--         G.shop_booster.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
--         create_shop_card_ui(card, 'Booster', G.shop_jokers)
--         card.ability.booster_pos = #G.shop_jokers.cards + 1
--         card:start_materialize()
--         G.shop_jokers:emplace(card)
--         return card
--     end
    
-- end