SMODS.Consumable{
    set = 'unik_summit', 
	atlas = 'unik_consumables',
    cost = 3,
	pos = {x = 1, y = 0},
	key = 'unik_aconcagua',
    attributes = {'perma_bonus','xmult','modify_card'},
    can_use = function(self, card)
        if G.hand and (#G.hand.highlighted <= card.ability.extra.max_highlighted) and G.hand.highlighted[1] then
            return true
        end
        return false
	end,
    config = { extra = { x_mult = 0.2 ,max_highlighted = 2} },
    loc_vars = function(self, info_queue, card)
        local cardOrBlind = UNIK.hasBlindside() and 'k_unik_blind' or 'k_unik_card'
		return {
			vars = {card.ability.extra.x_mult,card.ability.extra.max_highlighted,localize(cardOrBlind)},
		}
	end,
    blindside_booster = true,
	include_in_vanilla = true,
	use = function(self, card, area, copier)
        UNIK.add_bonus('x_mult',card.ability.extra.x_mult)
        UNIK.add_perma_bonus({
            type = 'perma_h_x_mult',
            message_key = 'a_xmult',
            message_colour = G.C.MULT,
            from_card = card,
            cards = G.hand.highlighted,
            value = card.ability.extra.x_mult,
        })
        card:juice_up(0.3, 0.5)  
    end
}