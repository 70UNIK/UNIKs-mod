SMODS.Consumable{
    set = 'unik_summit', 
	atlas = 'unik_consumables',
    cost = 3,
	pos = {x = 1, y = 2},
	key = 'unik_narodnaya',
    can_use = function(self, card)
        if G.hand and (#G.hand.highlighted <= card.ability.extra.max_highlighted) and G.hand.highlighted[1] then
            return true
        end
        return false
	end,
    config = { extra = { mult = 3 ,max_highlighted = 2} },
    loc_vars = function(self, info_queue, card)
        local cardOrBlind = UNIK.hasBlindside() and 'k_unik_blind' or 'k_unik_card'
		return {
			vars = {card.ability.extra.mult,card.ability.extra.max_highlighted,localize(cardOrBlind)},
		}
	end,
    attributes = {'perma_bonus','mult','modify_card'},
    blindside_booster = true,
	include_in_vanilla = true,
	use = function(self, card, area, copier)
        UNIK.add_bonus('mult',card.ability.extra.mult)
        UNIK.add_perma_bonus({
            type = 'perma_h_mult',
            message_key = 'a_mult',
            message_colour = G.C.MULT,
            from_card = card,
            cards = G.hand.highlighted,
            value = card.ability.extra.mult
        })
        card:juice_up(0.3, 0.5)  
    end
}