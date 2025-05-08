--All jokers, consumeables and cards become positive
SMODS.Consumable{
    set = 'unik_lartceps', 
	atlas = 'unik_lartceps',
    cost = 0,
	pos = {x = 1, y = 1},
	key = 'unik_reeducation',
    config = {},
    can_use = function(self, card)
		return true
	end,
    loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.unik_positive) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_unik_positive
		end
	end,
	use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            for i,v in pairs(G.playing_cards) do
                v:set_edition({ unik_positive = true }, true,nil, true)
            end
            for i,v in pairs(G.jokers.cards) do
                v:set_edition({ unik_positive = true }, true,nil, true)
            end
            for i = 1, #G.consumeables.cards do
                G.consumeables.cards[i]:set_edition({ unik_positive = true }, true,nil, true)
            end
            card:juice_up(0.3, 0.5)
        return true end })) 
    end 
}