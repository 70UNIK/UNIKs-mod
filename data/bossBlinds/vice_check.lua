function vice_check()
	if G.GAME.round_resets.ante >= 0 and G.GAME.round_resets.ante < 2 then
		return G.GAME.win_ante
	end
	G.GAME.unik_vice_squeeze = G.GAME.unik_vice_squeeze or 1
	G.GAME.OvershootFXVal = G.GAME.OvershootFXVal or 0
	if G.GAME.OvershootFXVal >= 4 then
		return 1
	end
	local multiplier = 1
	if G.GAME.OvershootFXVal >= 2 then
		multiplier = 2
	end
	if G.GAME.OvershootFXVal >= 3 then
		multiplier = 4
	end
	if G.GAME.win_ante < G.GAME.unik_vice_squeeze then
		return 1
	end
	
    if G.GAME.round_resets.ante and G.GAME.round_resets.ante % math.floor(G.GAME.win_ante/(math.floor(G.GAME.unik_vice_squeeze*multiplier*10000)/10000)) == 0 then
        return 1
    end
    if G.GAME.round_resets.ante and G.GAME.round_resets.ante% G.GAME.win_ante == 0 then
        return 1
    end
	if G.GAME.all_finishers then
		return 1
	end
    return G.GAME.win_ante
end