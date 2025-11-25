SMODS.Joker {
	key = "unik_minimized",
    atlas = "unik_rare",
	pos = { x = 4, y = 0 },
	rarity = 3,
	cost = 8,
	immutable = true,
    loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_cry_maximized
	end,
    pixel_size = { w = 71, h = 30 },
}
local cgi_ref = Card.get_id
local override_minimized = false
local checking_minimized = false --cardsauce fix
function Card:get_id()
    if not checking_minimized then
        checking_minimized = true
        local id = cgi_ref(self) or self.base.id
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
        end
        checking_minimized = false
        return id
    else
        checking_minimized = false
        local id = cgi_ref(self)
        return id
    end
    
end
--Fix issues with View Deck and Maximized
local gui_vd = G.UIDEF.view_deck
function G.UIDEF.view_deck(unplayed_only)
    override_minimized = true
    local ret_value = gui_vd(unplayed_only)
    override_minimized = false
    return ret_value
end