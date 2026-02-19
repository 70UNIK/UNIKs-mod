--Redeem a random disposable voucher at the end of the round. 1 in 2 chance to redeem another disposable voucher.
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_coupon_codes',
    atlas = 'unik_uncommon',
    rarity = 3,
	pos = { x = 1, y = 1 },

    cost = 10,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    demicoloncompat = true,
    config = { extra = {purchased_cards = 0,requirement=12} },
	loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_coupon
        info_queue[#info_queue + 1] = G.P_TAGS.tag_voucher
		return { vars = { center.ability.extra.requirement,center.ability.extra.purchased_cards,0} }
	end,
    calculate = function(self, card, context)
        if context.buying_card and to_big(context.card.sell_cost) > to_big(0) and to_big(context.card.cost) > to_big(0) then
            if not context.blueprint and not context.retrigger_joker then
                card.ability.extra.purchased_cards = card.ability.extra.purchased_cards + 1
            end
            
            if card.ability.extra.purchased_cards >= card.ability.extra.requirement then
                G.E_MANAGER:add_event(Event({
					trigger = 'before',
					func = function()
						add_tag(Tag("tag_voucher"))
						play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
						play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
						return true
					end,
				}))
                G.E_MANAGER:add_event(Event({
					trigger = 'before',
					func = function()
						add_tag(Tag("tag_coupon"))
						play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
						play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
						return true
					end,
				}))
                if not context.blueprint and not context.retrigger_joker then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        func = function()
                            card.ability.extra.purchased_cards = 0
                            return true
                        end,
                    }))
                end
                

                return {
                    message = localize('k_unik_code')..string.char(math.random(65, 65 + 25))..string.char(math.random(65, 65 + 25))..string.char(math.random(65, 65 + 25))..string.char(math.random(65, 65 + 25))..string.char(math.random(65, 65 + 25))..string.char(math.random(65, 65 + 25)),
                    colour = G.C.RED
                }
            elseif not context.blueprint and not context.retrigger_joker then
                return {
                    message = card.ability.extra.purchased_cards .. "/" .. card.ability.extra.requirement,
                    colour = G.C.RED
                }
            end
        end
        if context.force_trigger then
            if not context.blueprint and not context.retrigger_joker then
                card.ability.extra.purchased_cards = card.ability.extra.purchased_cards + 1
            end
            if card.ability.extra.purchased_cards >= card.ability.extra.requirement then
                G.E_MANAGER:add_event(Event({
					trigger = 'before',
					func = function()
						add_tag(Tag("tag_voucher"))
						play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
						play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
						return true
					end,
				}))
                G.E_MANAGER:add_event(Event({
					trigger = 'before',
					func = function()
						add_tag(Tag("tag_coupon"))
						play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
						play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
						return true
					end,
				}))
                if not context.blueprint and not context.retrigger_joker then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        func = function()
                            card.ability.extra.purchased_cards = 0
                            return true
                        end,
                    }))
                end
                return {
                    message = localize('k_unik_code')..string.char(math.random(65, 65 + 25))..string.char(math.random(65, 65 + 25))..string.char(math.random(65, 65 + 25))..string.char(math.random(65, 65 + 25))..string.char(math.random(65, 65 + 25))..string.char(math.random(65, 65 + 25)),
                    colour = G.C.RED
                }
            elseif not context.blueprint and not context.retrigger_joker then
                return {
                    message = card.ability.extra.purchased_cards .. "/" .. card.ability.extra.requirement,
                    colour = G.C.RED
                }
            end
        end
    end,
}