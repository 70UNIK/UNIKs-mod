function CanSpawnAncient()
    if not UNIK.hasBlindside() then
		return false
	end
    G.GAME.OvershootFXVal = G.GAME.OvershootFXVal or 0
    if G.GAME.unik_force_epic_plus > 0 then
        return true
    end
    if G.GAME.round >= 40 then
        if G.GAME.OvershootFXVal >= 2 then
            return true
        end
    end
    if G.GAME.unik_overshoot and G.GAME.OvershootFXVal >= 3 then
        return true
    end
    return false
end