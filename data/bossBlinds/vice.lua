--The vice: Defeating this blind will make Finisher Blinds appear every (4 antes, 2 antes, ante)
--cannot be rerolled if appears during rerolls, endless exclusive
SMODS.Blind{
    key = 'unik_vice',
    config = {},
	boss = {
		min = 2,
	},
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 19},
    boss_colour= HEX("404040"),
    dollars = 5,
    mult = 2,
    loc_vars = function(self, info_queue, card)
        local string = ""
		G.GAME.unik_vice_squeeze = G.GAME.unik_vice_squeeze or 1
        if math.ceil(G.GAME.win_ante/(G.GAME.unik_vice_squeeze*2)) > 1 then
            string = "" .. tostring(math.ceil(G.GAME.win_ante/(G.GAME.unik_vice_squeeze*2))) .. " antes"
        else
            string = "ante"
        end

		return { vars = {  2 * get_blind_amount(G.GAME.round_resets.ante) * 2 * G.GAME.starting_params.ante_scaling ,string } } -- no bignum?
	end,
	collection_loc_vars = function(self)
		return { vars = { localize("k_unik_vice_placeholder2"), localize("k_unik_vice_placeholder") } }
	end,
	unik_after_defeat = function(self,chips,blind_size)
		if to_big(chips) > to_big(blind_size * 2) then
			G.GAME.unik_vice_squeeze = G.GAME.unik_vice_squeeze or 1
			G.GAME.unik_vice_squeeze = G.GAME.unik_vice_squeeze * 2
			G.GAME.blind.triggered = true
			G.GAME.blind:wiggle()
			G.ROOM.jiggle = G.ROOM.jiggle + 3
			local text = localize('k_unik_viced')
			attention_text({
				scale = 0.8, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
			})
		end
		return false
	end
}
--Epic vice: the next 8 boss blinds become epic+ blinds

