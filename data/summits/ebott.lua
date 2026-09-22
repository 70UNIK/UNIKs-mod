SMODS.Consumable{
    set = 'Spectral', 
	atlas = 'unik_consumables',
    cost = 4,
	pos = {x = 2, y = 0},
	key = 'unik_ebott',
    can_use = function(self, card)
        if G.hand and (#G.hand.highlighted <= card.ability.extra.max_highlighted) and G.hand.highlighted[1] then
            return true
        end
        return false
	end,
    --attributes = {'perma_bonus','emult','modify_card'},
    config = { extra = { e_mult = 0.05 ,max_highlighted = 1} },
    loc_vars = function(self, info_queue, card)
		return {
			vars = {card.ability.extra.e_mult,card.ability.extra.max_highlighted},
		}
	end,
    in_pool = function(self)
        return not UNIK.hasBlindside()
	end,
    hidden = true,
    soul_set = 'unik_summit',
	use = function(self, card, area, copier)
        UNIK.add_bonus('e_mult',card.ability.extra.e_mult)
        UNIK.add_perma_bonus({
            type = 'perma_e_mult',
            message_key = 'a_powmult',
            message_colour = SMODS.Gradients.unik_emult,
            from_card = card,
            cards = G.hand.highlighted,
            value = card.ability.extra.e_mult,
        })
        card:juice_up(0.3, 0.5)  
    end
}