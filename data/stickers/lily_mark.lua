--ineligible for copying by white lily cookie
SMODS.Sticker{
    key="unik_lily_mark",
    badge_colour=HEX("1a6e51"),
    atlas = 'unik_stickers', 
    pos = { x = 3, y = 1 },
    rate = 0.0,
    no_sticker_sheet = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.j_unik_white_lily_cookie
	end,
}