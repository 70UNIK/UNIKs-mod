--Banish and unredeem all vouchers
SMODS.Consumable{
    set = 'unik_lartceps', 
	atlas = 'unik_lartceps',
    cost = 0,
	pos = {x = 5, y = 0},
	key = 'unik_expiry',
    config = {},
    no_doe = true,
    no_grc = true,
	no_ccd = true,
    can_use = function(self, card)
		return true --Fallback for now if no vouchers exist, as the booster is unskippable (avoid softlock).
	end,
	use = function(self, card, area, copier)
        local used_consumable = copier or card
		local usable_vouchers = {}
		for k, v in ipairs(G.vouchers.cards) do
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


			local card = copy_card(v)
            card.ability.extra = copy_table(v.ability.extra)
            if card.facing == "back" then
                card:flip()
            end

            card:start_materialize()
            area:emplace(card)
            card.cost = 0
            card.shop_voucher = false
            local current_round_voucher = G.GAME.current_round.voucher
            card:juice_up(0.3, 0.5)
            card:unredeem()
            G.GAME.current_round.voucher = current_round_voucher
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0,
                func = function()
                    card:start_dissolve()
                    v:start_dissolve()
                    return true
                end,
            }))

            --BANISH!
            if not G.GAME.banned_keys then
				G.GAME.banned_keys = {}
			end
            if not G.GAME.banned_keys then
				G.GAME.cry_banished_keys = {}
			end
			local c = nil
            c = v

			G.GAME.cry_banished_keys[c.config.center.key] = true

		end
    end
}
