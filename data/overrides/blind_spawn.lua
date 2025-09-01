--My very own customized blind spawning system.
--Takes in account The Vice (Faster Finisher Blind spawn rates), Epic Blind Sauce, Epic Vice (Force Epic Blinds)
local start_run_boss_override = Game.start_run
function Game:start_run(args)
    start_run_boss_override(self,args)
    local saveTable = args.savetext or nil
    if not saveTable then
        if G.GAME.OvershootFXVal and G.GAME.OvershootFXVal >= 5 then
            G.GAME.unik_force_epic_plus = math.max(1,G.GAME.unik_force_epic_plus)
        end
        if G.GAME.unik_force_epic_plus > 0 or G.GAME.modifiers.cry_rush_hour_ii then
            self.GAME.round_resets.blind_choices.Small = get_new_boss()
        else
            self.GAME.round_resets.blind_choices.Small = "bl_small"
        end
        if G.GAME.unik_force_epic_plus > 0 or G.GAME.modifiers.cry_rush_hour_ii then
            self.GAME.round_resets.blind_choices.Big = get_new_boss()
        else
            self.GAME.round_resets.blind_choices.Big = "bl_big"
        end
        if vice_check() == 1 then
            self.GAME.round_resets.blind_choices.Boss = get_new_boss()
        end
        
    end
end

local reset_override = reset_blinds
function reset_blinds()
    --default state
    if G.GAME.round_resets.blind_states.Boss == 'Defeated' then
        G.GAME.round_resets.blind_choices.Small = "bl_small"
        G.GAME.round_resets.blind_choices.Big = "bl_big"
    end
    reset_override()
    if G.GAME.OvershootFXVal and G.GAME.OvershootFXVal >= 5 then
        G.GAME.unik_force_epic_plus = math.max(1,G.GAME.unik_force_epic_plus)
    end
    if G.GAME.round_resets.blind_states.Small == 'Upcoming' and
        G.GAME.round_resets.blind_states.Big == 'Upcoming' and
        G.GAME.round_resets.blind_states.Boss == 'Upcoming' then

        if G.GAME.unik_force_epic_plus > 0 or G.GAME.modifiers.cry_rush_hour_ii then
            G.GAME.round_resets.blind_choices.Small = get_new_boss()
        end
        if G.GAME.unik_force_epic_plus > 0 or G.GAME.modifiers.cry_rush_hour_ii or G.GAME.superboss_active then
            G.GAME.round_resets.blind_choices.Big = get_new_boss()
        end
        G.GAME.blind_on_deck = 'Small'
        G.GAME.round_resets.boss_rerolled = false
    end
    
end

--Blind refresh

--Gets either:
--Bigger blind randomly
--A finisher blind if the vice check succeeds
local boss_override = get_new_boss
function get_new_boss()
    
    local boss = boss_override()
    --Upper
    G.GAME.perscribed_bosses = G.GAME.perscribed_bosses or {
    }
    if G.GAME.perscribed_bosses and G.GAME.perscribed_bosses[G.GAME.round_resets.ante] then 
        local ret_boss = G.GAME.perscribed_bosses[G.GAME.round_resets.ante] 
        G.GAME.perscribed_bosses[G.GAME.round_resets.ante] = nil
        G.GAME.bosses_used[ret_boss] = G.GAME.bosses_used[ret_boss] + 1
        return ret_boss
    end
    if G.FORCE_BOSS then return G.FORCE_BOSS end


    --BIGGER BLINDS!
    G.GAME.bigger_blind_blacklist = G.GAME.bigger_blind_blacklist or 0
    G.GAME.boring_blank_blacklist = G.GAME.boring_blank_blacklist or 0
    if not G.GAME.modifiers.cry_rush_hour_ii and not G.GAME.round_resets.boss_rerolled and G.GAME.bigger_blind_blacklist == 0 and G.P_BLINDS[boss].boss and not G.P_BLINDS[boss].boss.showdown and not (G.GAME.unik_force_epic_plus and G.GAME.unik_force_epic_plus > 0) and pseudorandom(pseudoseed("BIGGER_BLIND")) < 0.05 then
        G.GAME.bigger_blind_blacklist = 16
        G.GAME.bosses_used[boss] = G.GAME.bosses_used[boss] - 1
        return 'bl_unik_bigger_blind'
    elseif not G.GAME.modifiers.cry_rush_hour_ii and not G.GAME.round_resets.boss_rerolled and G.GAME.boring_blank_blacklist == 0 and G.P_BLINDS[boss].boss and G.P_BLINDS[boss].boss.showdown and not (G.GAME.unik_force_epic_plus and G.GAME.unik_force_epic_plus > 0) and pseudorandom(pseudoseed("BORING_BLANK")) < 0.05 then
        G.GAME.boring_blank_blacklist = 64
        G.GAME.bosses_used[boss] = G.GAME.bosses_used[boss] - 1
        return 'bl_unik_boring_blank'
    end

    --The logic:
    --It overrides when:
    --A finisher boss occurs outside of the designated spots (vice)
    --An Epic Blind spawns
    local forceNewBoss = nil
    if G.GAME.OvershootFXVal and G.GAME.OvershootFXVal >= 5 then
        G.GAME.unik_force_epic_plus = math.max(1,G.GAME.unik_force_epic_plus)
    end
    local eligible_bosses = {}
    local force_override = (vice_check() == 1)
    if G.GAME.unik_force_epic_plus > 0 then
        force_override = true
    end
    --Ignore if a showdown boss.
    if force_override and (not G.P_BLINDS[boss].boss or (G.P_BLINDS[boss].boss and not G.P_BLINDS[boss].boss.showdown)) then
        for k, v in pairs(G.P_BLINDS) do
            if not v.boss then
            else
                if v.in_pool and type(v.in_pool) == 'function' then
                    local res, options = SMODS.add_to_pool(v)
                    if 
                        v.boss.showdown
                        or (options or {}).ignore_showdown_check then
                        eligible_bosses[k] = res and true or nil
                    end
                    if
                        unik_config.unik_legendary_blinds and 
                        (v.boss and (v.boss.epic or v.boss.legendary) and G.GAME.modifiers.unik_legendary_at_any_time)
                    then
                        if v.boss.epic and string.sub(k,1,6) == "bl_jen" then
                            eligible_bosses[k] = true
                        elseif (v.boss.epic or v.boss.legendary) then
                            local res, options = v:in_pool()
                            eligible_bosses[k] = res and true or nil
                        end
                    end
                elseif v.boss.showdown then
                    eligible_bosses[k] = true
                else
                    eligible_bosses[k] = nil
                end
            end
            if G.GAME.unik_force_epic_plus > 0 then
            if unik_config.unik_legendary_blinds then
                if v.boss and v.boss.epic and string.sub(k,1,6) == "bl_jen" then
                    eligible_bosses[k] = true
                elseif v.boss and (v.boss.epic or v.boss.legendary) then
                    if v.in_pool then
                        local res, options = v:in_pool()
                        eligible_bosses[k] = res and true or nil
                    else
                        eligible_bosses[k] = true
                    end
                elseif v.boss then
                    eligible_bosses[k] = nil
                end
                else
                --fallback to finisher blinds if epic blinds are disabled or jens not installed
                    if v.boss and v.boss.showdown then
                        if v.in_pool then
                            local res, options = v:in_pool()
                            eligible_bosses[k] = res and true or nil
                        else    
                            eligible_bosses[k] = true
                        end
                    elseif v.boss then
                        eligible_bosses[k] = nil
                    end
                end
            end
        end
        for k, v in pairs(G.GAME.banned_keys) do
            if eligible_bosses[k] then eligible_bosses[k] = nil end
        end

        local min_use = 100
        for k, v in pairs(G.GAME.bosses_used) do
            if eligible_bosses[k] then
                eligible_bosses[k] = v
                if eligible_bosses[k] <= min_use then 
                    min_use = eligible_bosses[k]
                end
            end
        end
        for k, v in pairs(eligible_bosses) do
            if eligible_bosses[k] then
                if eligible_bosses[k] > min_use then 
                    eligible_bosses[k] = nil
                end
            end
        end
        local _, newBoss = pseudorandom_element(eligible_bosses, pseudoseed('unik_boss_finisher'))
        forceNewBoss = newBoss
        --Revert
        G.GAME.bosses_used[boss] = G.GAME.bosses_used[boss] - 1
        G.GAME.bosses_used[forceNewBoss] = G.GAME.bosses_used[forceNewBoss] + 1
        if unik_config.unik_legendary_blinds and G.P_BLINDS[forceNewBoss] and G.P_BLINDS[forceNewBoss].boss then
            if ((G.P_BLINDS[forceNewBoss].boss.epic or G.P_BLINDS[forceNewBoss].boss.legendary)) and G.GAME.unik_force_epic_plus and G.GAME.unik_force_epic_plus > 0 then
                G.GAME.unik_force_epic_plus = G.GAME.unik_force_epic_plus - 1
            end
        else
            if ((G.P_BLINDS[forceNewBoss].boss.showdown)) and G.GAME.unik_force_epic_plus and G.GAME.unik_force_epic_plus > 0 then
                G.GAME.unik_force_epic_plus = G.GAME.unik_force_epic_plus - 1
            end
        end
    else
        if unik_config.unik_legendary_blinds and G.P_BLINDS[boss] and G.P_BLINDS[boss].boss then
            if ((G.P_BLINDS[boss].boss.epic or G.P_BLINDS[boss].boss.legendary)) and G.GAME.unik_force_epic_plus and G.GAME.unik_force_epic_plus > 0 then
                G.GAME.unik_force_epic_plus = G.GAME.unik_force_epic_plus - 1
            end
        else
            if ((G.P_BLINDS[boss].boss.showdown)) and G.GAME.unik_force_epic_plus and G.GAME.unik_force_epic_plus > 0 then
                G.GAME.unik_force_epic_plus = G.GAME.unik_force_epic_plus - 1
            end
        end
    end
    
    if forceNewBoss then
        return forceNewBoss
    end
    return boss
end