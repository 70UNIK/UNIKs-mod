--Niko: Self destructs after final scoring is finished (aka after 1 round). CANNOT be removed
SMODS.Sticker{
    key="unik_niko",
    badge_colour=G.C.UNIK_SHITTY_EDITION,
    atlas = 'unik_stickers', 
    pos = { x = 1, y = 1 },
    rate = 0.0,
    should_apply = false,
	no_sticker_sheet = true,
    draw = function(self, card, layer)
		local notilt = nil
		if card.area and card.area.config.type == "deck" then
			notilt = true
		end
		G.shared_stickers["unik_niko"].role.draw_major = card
		G.shared_stickers["unik_niko"]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
		G.shared_stickers["unik_niko"]:draw_shader(
			"polychrome",
			nil,
			card.ARGS.send_to_shader,
			notilt,
			card.children.center
		)
		G.shared_stickers["unik_niko"]:draw_shader(
			"voucher",
			nil,
			card.ARGS.send_to_shader,
			notilt,
			card.children.center
		)
	end,
    loc_vars = function(self, info_queue, card)
		local new_numerator, new_denominator = SMODS.get_probability_vars(card, 2,3, 'unik_niko_consumable')
		if card.ability.consumeable then
			return { key = "unik_niko_consumable", vars = { new_numerator, new_denominator } }
		elseif card.ability.set == "Voucher" then
			return { key = "unik_niko_voucher" }
		elseif card.ability.set == "Booster" then
			return { key = "unik_niko_booster" }
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
			end
		end
	end,
}
--set cost of disposable stickers to 0.
local setCoster = Card.set_cost
function Card:set_cost()
    setCoster(self)
    if self.ability.unik_disposable or self.ability.unik_niko or self.ability.unik_depleted then self.cost = 0 end
end

--Disposable effect on Jokers
function Card:calculate_disposable()
	if not self.ability.unik_disposed then
		if self.ability.unik_disposable or self.ability.unik_niko then
			self.ability.unik_disposed = true
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("tarot1")
					self.T.r = -0.2
					self:juice_up(0.3, 0.4)
					self.states.drag.is = true
					self.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.3,
						blockable = false,
						func = function()
							if self.area then
								self.area:remove_card(self)
							end
							self:remove()
							self = nil
							return true
						end,
					}))
					return true
				end,
			}))
            if self.ability.unik_niko then
                card_eval_status_text(self, "jokers", nil, nil, nil, {
                    message = localize("k_unik_you_killed_niko"),
                    delay = 0.5 ,
                    colour = G.C.RED,
               })               
            else
                card_eval_status_text(self, "jokers", nil, nil, nil, {
                    message = localize("k_unik_disposed"),
                    delay = 0.5 ,
                    colour = G.C.RED,
               })
            end
			return true
		end
	end
	return false
end