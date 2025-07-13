--Only spawn lartceps inside the lartceps pack;
function lartcepsCheck()
    local obj = SMODS.OPENED_BOOSTER
    if (obj and obj.config and obj.config.center and obj.config.center.generate_lartceps) or G.GAME.unik_enable_lartcep_spawn then
        return true
    end
    return false
end