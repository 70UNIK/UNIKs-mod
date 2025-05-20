--remove all empty joker slots then halve all jokers slots
SMODS.Consumable{
    set = 'unik_lartceps', 
	atlas = 'unik_lartceps',
    cost = 0,
	pos = {x = 4, y = 0},
	key = 'unik_trim',
    config = {},
    can_use = function(self, card)
		return true
	end,
    no_doe = true,
    no_grc = true,
	no_ccd = true,
	use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            local emptySlots = G.jokers.config.card_limit - #G.jokers.cards
            if emptySlots > 0 then
                G.jokers.config.card_limit = G.jokers.config.card_limit - emptySlots
            end
            G.jokers.config.card_limit = math.ceil(G.jokers.config.card_limit/2)
            card:juice_up(0.3, 0.5)
        return true end })) 
    end,
    in_pool = function()
		return lartcepsCheck()
	end,
}