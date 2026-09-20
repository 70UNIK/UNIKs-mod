SMODS.Consumable{
    set = 'unik_summit', 
	atlas = 'unik_consumables',
    cost = 3,
	pos = UNIK.isIndigenousSummitNaming() and {x = 3, y = 1} or  {x = 1, y = 3},
	key = 'unik_mitchell',
    can_use = function(self, card)
        if G.hand and (#G.hand.highlighted <= card.ability.extra.max_highlighted) and G.hand.highlighted[1] then
            return true
        end
        return false
	end,
    config = { extra = { chips = 22 ,max_highlighted = 2} },
    loc_vars = function(self, info_queue, card)
        local key = 'c_unik_mitchell'
        if UNIK.isIndigenousSummitNaming() then
            key = key .. '_i'
        end
        local cardOrBlind = UNIK.hasBlindside() and 'k_unik_blind' or 'k_unik_card'
		return {
			key = key, vars = {card.ability.extra.chips,card.ability.extra.max_highlighted,localize(cardOrBlind)},
		}
	end,
    attributes = {'perma_bonus','chips','modify_card'},
    blindside_booster = true,
	include_in_vanilla = true,
	use = function(self, card, area, copier)
        UNIK.add_bonus('chips',card.ability.extra.chips)
        UNIK.add_perma_bonus({
            type = 'perma_h_chips',
            message_key = 'a_chips',
            message_colour = G.C.CHIPS,
            from_card = card,
            cards = G.hand.highlighted,
            value = card.ability.extra.chips,
        })
        card:juice_up(0.3, 0.5)  
    end
}