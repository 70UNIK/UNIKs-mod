function CanSpawnEpic()
    --will never spawn if blindside is enabled, ancient jokers will take its place eventually
    if UNIK.hasBlindside() then
		return false
	end
    G.GAME.OvershootFXVal = G.GAME.OvershootFXVal or 0
    if G.GAME.unik_force_epic_plus > 0 then
        return true
    end
    if G.GAME.modifiers.unik_legendary_at_any_time then
        return true
    end
    if not UNIK.overshootEnabled() then
        --if overshoot is disabled, but almanac is installed, it spawns like any other epic blind, AFTER ROUND 40 OF COURSE!!!!!
        if UNIK.has_almanac() then
            if G.GAME.round >= 40 then
                return true
            end
        end
        return false
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
function CanSpawnLegendary()
    --will never spawn if blindside is enabled, exotic jokers will take its place eventually
    if UNIK.hasBlindside() then
		return false
	end
    G.GAME.OvershootFXVal = G.GAME.OvershootFXVal or 0
    if G.GAME.modifiers.unik_legendary_at_any_time then
        return true
    end
    if not UNIK.overshootEnabled() then
        return false
    end
    if G.GAME.round >= 90 then
        if G.GAME.OvershootFXVal >= 3 then
            return true
        end
    end
    if G.GAME.unik_overshoot and G.GAME.OvershootFXVal >= 4 then
        return true
    end
    return false
end

