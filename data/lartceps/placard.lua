--add permadebuffed and absolute to all cards
SMODS.Consumable{
    set = 'unik_lartceps', 
	atlas = 'unik_lartceps',
    cost = 0,
	pos = {x = 1, y = 0},
	key = 'unik_placard',
    config = {},
    no_doe = true,
    no_grc = true,
	no_ccd = true,
    can_use = function(self, card)
		return true
	end,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_ultradebuffed" }
	end,
	use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            for i,v in pairs(G.playing_cards) do
                v.ability.cry_absolute = true
                v.ability.unik_ultradebuffed = true
            end
        return true end })) 
    end,
    in_pool = function()
		return lartcepsCheck()
	end,
}