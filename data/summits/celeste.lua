SMODS.Consumable{
    set = 'Spectral', 
	atlas = 'unik_consumables',
    cost = 4,
	pos = {x = 2, y = 1},
	key = 'unik_celeste',
    can_use = function(self, card)
        if G.hand and (#G.hand.highlighted <= card.ability.extra.max_highlighted) and G.hand.highlighted[1] then
            return true
        end
        return false
	end,
    config = { extra = { e_chips = 0.04 ,max_highlighted = 1} },
    loc_vars = function(self, info_queue, card)
		return {
			vars = {card.ability.extra.e_chips,card.ability.extra.max_highlighted},
		}
	end,
    in_pool = function(self)
        return not UNIK.hasBlindside()
	end,
    hidden = true,
    soul_set = 'unik_summit',
	use = function(self, card, area, copier)
        UNIK.add_bonus('e_chips',card.ability.extra.e_chips)
        UNIK.add_perma_bonus({
            type = 'perma_e_chips',
            message_key = 'a_powchips',
            message_colour = SMODS.Gradients.unik_echips,
            from_card = card,
            cards = G.hand.highlighted,
            value = card.ability.extra.e_chips,
        })
        card:juice_up(0.3, 0.5)  
    end
}