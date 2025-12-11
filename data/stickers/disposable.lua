--Disposable: Self destructs after 1 round. can be removed
--Jokers and playing cards self destruct after 1 round
--Vouchers unredeem after 1 round
--Consumables self destruct after 1 round and have 1 in 2 chance to do nothing on use
--Cost is set to 0.
--incompatible with eternal
function Card:set_disposable(disposable)
	self.ability.unik_disposable = nil
    if self.config.center.perishable_compat then 
        self.ability.unik_disposable = disposable
        unik_set_sell_cost(self,0)
        self:set_cost()
        
    end
    
end
SMODS.Sticker{
    key="unik_disposable",
    badge_colour=HEX("ff0000"),
    atlas = 'unik_stickers', 
    pos = { x = 1, y = 0 },
    rate = 0.0,
    
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 2,3, 'unik_disposable_consumable')
		if card.ability.consumeable then
			return { key = "unik_disposable_consumable", vars = { new_numerator, new_denominator } }
		elseif card.ability.set == "Voucher" then
			return { key = "unik_disposable_voucher" }
		elseif card.ability.set == "Booster" then
			return { key = "unik_disposable_booster" }
		else
			return { }
		end
	end,
	calculate = function(self, card, context)
		if
			context.end_of_round
			and not context.repetition
			and not context.playing_card_end_of_round
			and not context.individual
		then
			if card.ability.set == "Voucher" and not card.ability.shield_immediate_disposal then
                local area
                if G.STATE == G.STATES.HAND_PLAYED then
                    if not G.redeemed_vouchers_during_hand then
                        G.redeemed_vouchers_during_hand = CardArea(
                            G.play.T.x,
                            G.play.T.y,
                            G.play.T.w,
                            G.play.T.h,
                            { type = "play", card_limit = 5 }
                        )
                    end
                    area = G.redeemed_vouchers_during_hand
                else
                    area = G.play
                end

                local _card = copy_card(card)
                _card.ability.extra = copy_table(card.ability.extra)
                if _card.facing == "back" then
                    _card:flip()
                end

                _card:start_materialize()
                area:emplace(_card)
                _card.cost = 0
                _card.shop_voucher = false
                _card:unredeem()
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0,
                    func = function()
                        _card:start_dissolve()
                        card:start_dissolve()
                        return true
                    end,
                }))
            -- next time it will be unredeemed!
			elseif card.ability.set == "Voucher" then
                card.ability.shield_immediate_disposal = nil
            end
		end
	end,
}