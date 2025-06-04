

local updateHook = Game.update
function Game:update(dt)
    --Artisan builds
    if G.GAME.round_resets.blind_choices and G.GAME.round_resets.blind_choices.Boss and (
        ((G.GAME.defeated_blinds["bl_unik_artisan_builds"] or 
        G.GAME.defeated_blinds["bl_unik_epic_artisan"]) 
        and (G.GAME.round_resets.blind_choices.Boss == "bl_cry_obsidian_orb" or
        G.GAME.round_resets.blind_choices.Big == "bl_cry_obsidian_orb" or
        G.GAME.round_resets.blind_choices.Small == "bl_cry_obsidian_orb"))
        or 
        G.GAME.round_resets.blind_choices.Boss == 'bl_unik_artisan_builds' or
        G.GAME.round_resets.blind_choices.Boss == 'bl_unik_epic_artisan' or 
        G.GAME.round_resets.blind_choices.Big == 'bl_unik_epic_artisan' or 
        G.GAME.round_resets.blind_choices.Small == 'bl_unik_epic_artisan' or 
        G.GAME.round_resets.blind_choices.Big == 'bl_unik_artisan_builds' or  
        G.GAME.round_resets.blind_choices.Small == 'bl_unik_artisan_builds'
        ) then
        G.GAME.unik_artisan_reroll_time = true
    else
        G.GAME.unik_artisan_reroll_time = nil
        G.GAME.ante_rerolls = 0
    end
    local res = updateHook(self,dt)
    return res
end

