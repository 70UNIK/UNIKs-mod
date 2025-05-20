SMODS.Consumable {
    set = 'unik_lartceps', 
	atlas = 'unik_lartceps',
    cost = 0,
	pos = {x = 3, y = 1},
	key = 'unik_blank_lartceps',
    config = {},
    no_doe = true,
    no_grc = true,
	no_ccd = true,
    can_use = function(self, card)
        return (card.area or {}) ~= G.consumeables
    end,
    use = function(self, card, area, copier)
        if not card.already_used_once then
            card.already_used_once = true
            local card2 = copy_card(card)
            card2:add_to_deck()
            G.consumeables:emplace(card2)
        end
    end,
    in_pool = function()
		return lartcepsCheck()
	end,
}

--Originated from Polterworx,
--Far more convenient way of doing <card>.config.center, makes doing checks for variables easy, e.g. Card:gc().cost
function Card:gcc()
	return (self.config or {}).center or {}
end
local cuc = Card.use_consumeable
function Card:use_consumeable(area, copier)
    for k, v in ipairs(G.consumeables.cards) do
		if self:gcc().key ~= 'c_unik_blank_lartceps' and self.ability.set == v.ability.set and v:gcc().key == 'c_unik_blank_lartceps' and not v.changing_from_blank then
			v.changing_from_blank = true
			card_eval_status_text(v, 'extra', nil, nil, nil, {
				message = localize('k_unik_copied'),
				colour = G.C.UNIK_LARTCEPS1,
			})
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.15,
                func = function()
                    v:flip()
                    play_sound('tarot1')
                    return true
                end,
            }))
			delay(1.5)
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.15,
                func = function()
                    v:flip()
                    play_sound('tarot2')
                    v:set_ability(G.P_CENTERS[self:gcc().key])
                    v.changing_from_blank = nil
                    return true
                end,
            }))
		end
	end
    cuc(self, area, copier)
end