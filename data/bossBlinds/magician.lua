--The Magician
--If score exceeds 2x requirements, redeem Magic Trick
SMODS.Blind{
    key = 'unik_magician',
    config = {},
	boss = {
		min = 2,
	},
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 29},
    boss_colour= HEX("5799b2"),
    dollars = 5,
    mult = 2,
    loc_vars = function(self, info_queue, card)

		return { vars = {  2 * get_blind_amount(G.GAME.round_resets.ante) * 2 * G.GAME.starting_params.ante_scaling  } } -- no bignum?
	end,
	collection_loc_vars = function(self)
		return { vars = { localize("k_unik_vice_placeholder2")} }
	end,
	unik_after_defeat = function(self,chips,blind_size)
		if to_big(chips) > to_big(blind_size * 2) then
			if not G.GAME.used_vouchers.v_magic_trick then
                G.GAME.blind:wiggle()
                G.ROOM.jiggle = G.ROOM.jiggle + 2
                local text = localize('k_unik_magiced')
                attention_text({
                    scale = 0.8, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                })
                G.E_MANAGER:add_event(Event({
                    trigger = "before",
                    delay = 0,
                    func = function()
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
                            local card = create_card("Voucher", area, nil, nil, nil, nil, 'v_magic_trick')
                            card:start_materialize()

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
                    return true
                end,
            }))
            end
		end
		return false
	end,
    in_pool = function()
        return not G.GAME.used_vouchers.v_magic_trick
    end
}
