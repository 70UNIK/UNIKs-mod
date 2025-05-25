--I feel that if you have a high enough score in Cryptid, such as from Oil lamp, an exotic, or simply scoring way too high too often, 
--epic blinds should spawn to "curb" your run and give a bit of challenge outside of polterworx.
--Modest will have those never appear, while the "always epic blinds" flag will have them always appearing
function CanSpawnEpic()
    if G.GAME.unik_force_epic_plus > 0 then
        return true
    end
    if Cryptid.gameset() == "modest" then
        return false
    end
    --you summon zenith, epic blinds and legnedary blinds will come at you ANY time
    if G.GAME.modifiers.unik_legendary_at_any_time or (not (SMODS.Mods["jen"] or {}).can_load and G.jokers and #Cryptid.advanced_find_joker(nil, "k_entr_zenith", nil, nil, true) ~= 0) then
        return true
    end
    --always loads when jens mod is installed
    if (SMODS.Mods["jen"] or {}).can_load then
        return G.GAME.round > Jen.config.ante_threshold * 2
    elseif G.GAME.round >= 40 then
        --Exotic, Entropic, 
        if G.jokers and (#Cryptid.advanced_find_joker(nil, "entr_reverse_legendary", nil, nil, true) ~= 0 or #Cryptid.advanced_find_joker(nil, "cry_exotic", nil, nil, true) ~= 0 or #Cryptid.advanced_find_joker(nil, "entr_entropic", nil, nil, true) ~= 0) then
            return true
        end
        --Cryptid legendaries/Epics == after consecutively scoring above ^2 reqs 6 times
        local hasCryptidLegendary = false
        if G.jokers then
            for i,v in pairs(G.jokers.cards) do
                if  string.sub(v.config.center.key,1,5) == 'j_cry' and v.config.center.rarity == 4 then
                    hasCryptidLegendary = true
                end
            end
        end
        if G.jokers and ( #Cryptid.advanced_find_joker(nil, "cry_epic", nil, nil, true) ~= 0 or hasCryptidLegendary) and G.GAME.unik_scores_really_big > 6 then
            return true
        end
        --Otherwise: == After consecutively scoring over ^2.6 reqs 10 times
        if G.GAME.unik_scores_really_big_back > 10 then
            return true
        end
    end
    return false
end
function CanSpawnLegendary()
    local straddle = 0
    if G.GAME.straddle then
        straddle = G.GAME.straddle
    end
    if Cryptid.gameset() == "modest" then
        return false
    end
    --you summon zenith, epic blinds and legnedary blinds will come at you ANY time
    if G.GAME.modifiers.unik_legendary_at_any_time or (not (SMODS.Mods["jen"] or {}).can_load and G.jokers and #Cryptid.advanced_find_joker(nil, "k_entr_zenith", nil, nil, true) ~= 0) then
        return true
    end
    if G.GAME.round >= 100 - (straddle*5)then
        if (SMODS.Mods["jen"] or {}).can_load then
            return true
        end
        --Exotic, Entropic,
        if G.jokers and ( #Cryptid.advanced_find_joker(nil, "entr_reverse_legendary", nil, nil, true) ~= 0 or #Cryptid.advanced_find_joker(nil, "cry_exotic", nil, nil, true) ~= 0 or #Cryptid.advanced_find_joker(nil, "entr_entropic", nil, nil, true) ~= 0) then
            return true
        end
        --Cryptid legendaries/Epics == after consecutively scoring above ^2 reqs 6 times
        local hasCryptidLegendary = false
        if G.jokers then
            for i,v in pairs(G.jokers.cards) do
                if  string.sub(v.config.center.key,1,5) == 'j_cry' and v.config.center.rarity == 4 then
                    hasCryptidLegendary = true
                end
            end
        end
        if G.jokers and (#Cryptid.advanced_find_joker(nil, "cry_epic", nil, nil, true) ~= 0 or hasCryptidLegendary) and G.GAME.unik_scores_really_big > 6 then
            return true
        end
        --Otherwise: == After consecutively scoring over ^2.6 reqs 10 times
        if G.GAME.unik_scores_really_big_back > 15 then
            return true
        end
    end
    return false
end
