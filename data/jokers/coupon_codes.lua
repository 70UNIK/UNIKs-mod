--Redeem a random disposable voucher at the end of the round. 1 in 2 chance to redeem another disposable voucher.
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_coupon_codes',
    atlas = 'unik_uncommon',
    rarity = 2,
	pos = { x = 1, y = 1 },

    cost = 7,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    demicoloncompat = true,
    config = { extra = {prob = 3, odds = 5} },
	loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_disposable" }
        local new_numerator, new_denominator = SMODS.get_probability_vars(center, center.ability.extra.prob, center.ability.extra.odds, 'unik_coupon_codes')
		return { vars = { new_numerator, new_denominator} }
	end,
    gameset_config = {
		modest = {extra = {prob = 4} },
	},
    calculate = function(self, card, context)
        if context.forcetrigger then
            card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_redeemed_ex")})
            G.E_MANAGER:add_event(Event({
                    trigger = "before",
                    delay = 0,
                    func = function()
                        local max = 2
                        for i = 1, max do
                            local area
                            if G.STATE == G.STATES.HAND_PLAYED then
                                if not G.redeemed_vouchers_during_hand then
                                    G.redeemed_vouchers_during_hand =
                                        CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, { type = "play", card_limit = 5 })
                                end
                                area = G.redeemed_vouchers_during_hand
                            else
                                area = G.play
                            end
                            local _pool = get_current_pool("Voucher", nil, nil, nil, true)
                            local center = pseudorandom_element(_pool, pseudoseed("cry_trade_redeem"))
                            local it = 1
                            while center == "UNAVAILABLE" do
                                it = it + 1
                                center = pseudorandom_element(_pool, pseudoseed("cry_trade_redeem_resample" .. it))
                            end
                            local card = create_card("Voucher", area, nil, nil, nil, nil, center)
                            card:start_materialize()
                            card.ability.unik_disposable = true

                            area:emplace(card)
                            card.cost = 0
                            card.shop_voucher = false
                            local current_round_voucher = G.GAME.current_round.voucher
                            card:redeem()
                            G.GAME.current_round.voucher = current_round_voucher
                            G.E_MANAGER:add_event(Event({
                                trigger = "after",
                                delay = 0,
                                func = function()
                                    card:start_dissolve()
                                    
                                    return true
                                end,
                            }))
                        end
                    return true
                end,
            }))
            return {
                
            }
        end
        if (context.end_of_round and context.game_over == false) then
            card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_redeemed_ex")})
            local max = 1
            if not SMODS.pseudorandom_probability(card, 'unik_coupon_codes', card.ability.extra.prob, card.ability.extra.odds, 'unik_coupon_codes') then
                max = 2
            end
            for i = 1, max do
                local area
                if G.STATE == G.STATES.HAND_PLAYED then
                    if not G.redeemed_vouchers_during_hand then
                        G.redeemed_vouchers_during_hand =
                            CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, { type = "play", card_limit = 5 })
                    end
                    area = G.redeemed_vouchers_during_hand
                else
                    area = G.play
                end
                local _pool = get_current_pool("Voucher", nil, nil, nil, true)
                local center = pseudorandom_element(_pool, pseudoseed("cry_trade_redeem"))
                local it = 1
                while center == "UNAVAILABLE" do
                    it = it + 1
                    center = pseudorandom_element(_pool, pseudoseed("cry_trade_redeem_resample" .. it))
                end
                local card = create_card("Voucher", area, nil, nil, nil, nil, center)
                card:start_materialize()
                card.ability.unik_disposable = true
                --Prevent disposable's effect from activating immediately
                card.ability.shield_immediate_disposal = true
                area:emplace(card)
                card.cost = 0
                card.shop_voucher = false
                local current_round_voucher = G.GAME.current_round.voucher
                card:redeem()
                G.GAME.current_round.voucher = current_round_voucher
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0,
                    func = function()
                        card:start_dissolve()
                        
                        return true
                    end,
                }))
            end
        end
    end,
}
-- if JokerDisplay then
-- 	JokerDisplay.Definitions["j_unik_coupon_codes"] = {
--         reminder_text = {
--             {
--                 ref_table = "card.joker_display_values",
--                 ref_value = "localized_text",
--                 retrigger_type = "mult",
--             },	
--         },
--         extra = {
--             {
--                 {
--                     ref_table = "card.joker_display_values",
--                     ref_value = "odds",
--                     colour = G.C.GREEN,
--                     scale = 0.3,
--                 },		
-- 			},
-- 		},
--         calc_function = function(card)
--             local text = ""
--             local odds = ""
--            
--             text = "(" .. localize("k_voucher") .. ")"
-- 			card.joker_display_values.localized_text = text
--             card.joker_display_values.odds = odds
--         end
-- 	}
-- end