SMODS.Consumable{
    set = 'unik_summit', 
	atlas = 'unik_consumables',
    cost = 3,
	pos = UNIK.isIndigenousSummitNaming() and {x = 5, y = 1} or {x = 3, y = 3},
	key = 'unik_whitney',
    can_use = function(self, card)
        if G.hand and (#G.hand.highlighted <= card.ability.extra.max_highlighted) and G.hand.highlighted[1] then
            return true
        end
        return false
	end,
    config = { extra = { money = 2 ,max_highlighted = 2} },
    loc_vars = function(self, info_queue, card)
        local key = 'c_unik_whitney'
        if UNIK.isIndigenousSummitNaming() then
            key = key .. '_i'
        end
        local cardOrBlind = UNIK.hasBlindside() and 'k_unik_blind' or 'k_unik_card'
		return {
			key = key, vars = {card.ability.extra.money,card.ability.extra.max_highlighted,localize(cardOrBlind)},
		}
	end,
    attributes = {'perma_bonus','economy','modify_card'},
    blindside_booster = true,
	include_in_vanilla = true,
	use = function(self, card, area, copier)
        UNIK.add_bonus('dollars',card.ability.extra.money)
        UNIK.add_perma_bonus({
            type = 'perma_h_dollars',
            message_colour = G.C.GOLD,
            from_card = card,
            cards = G.hand.highlighted,
            value = card.ability.extra.money,
        })
        card:juice_up(0.3, 0.5)  
    end
}