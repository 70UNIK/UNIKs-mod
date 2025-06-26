SMODS.Joker {
	key = "unik_minimized",
    atlas = "placeholders",
	pos = { x = 2, y = 0 },
	rarity = 3,
	cost = 11,
	immutable = true,
    loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_cry_maximized
	end,
}
local cgi_ref = Card.get_id
local override_minimized = false
function Card:get_id()
    local id = cgi_ref(self)
    if next(find_joker("j_unik_minimized")) and not override_minimized and not next(find_joker("cry-Maximized")) then
        if id == nil then
            id = 2
        end
        if (id >= 2 and id <= 10) or (id >= 15)then
            id = 2
        end
        if id >= 11 and id <= 13 or next(find_joker("Pareidolia")) then
            id = 11
        end
        --whill this worrkrkrrk???
        
    end
    return id
end
--Fix issues with View Deck and Maximized
local gui_vd = G.UIDEF.view_deck
function G.UIDEF.view_deck(unplayed_only)
    override_minimized = true
    local ret_value = gui_vd(unplayed_only)
    override_minimized = false
    return ret_value
end