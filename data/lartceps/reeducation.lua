--All jokers, consumeables and cards either become positive, bloated, half, fuzzy or corrupted

local function reeducation_edition(card)
    local random_result = pseudorandom(pseudoseed("unik_redducation_edition"))
    if random_result < 1/7 then
        card:set_edition({ unik_bloated = true }, true,nil, true)
    elseif random_result < 3/7 then
        card:set_edition({ unik_positive = true }, true,nil, true)
    elseif random_result < 5/7 then
        card:set_edition({ unik_corrupted = true }, true,nil, true)
    elseif random_result < 6/7 then
        card:set_edition({ unik_fuzzy = true }, true,nil, true)
    else
        card:set_edition({ unik_halfjoker = true }, true,nil, true)
    end
end

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
    no_doe = true,
    no_grc = true,
	no_ccd = true,
    loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.unik_positive) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_unik_positive
		end
        if not center.edition or (center.edition and not center.edition.unik_bloated) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_unik_bloated
		end
        if not center.edition or (center.edition and not center.edition.unik_corrupted) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_unik_corrupted
		end
        if not center.edition or (center.edition and not center.edition.unik_dizzy) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_unik_dizzy
		end
        if not center.edition or (center.edition and not center.edition.unik_halfjoker ) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_unik_halfjoker 
		end
	end,
	use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            for i,v in pairs(G.playing_cards) do
                reeducation_edition(v)
                delay(0.1)
            end
            for i,v in pairs(G.jokers.cards) do
                reeducation_edition(v)
                delay(0.1)
            end
            for i = 1, #G.consumeables.cards do
                reeducation_edition(G.consumeables.cards[i])
                delay(0.1)
            end
            card:juice_up(0.3, 0.5)
        return true end })) 
    end 
}
