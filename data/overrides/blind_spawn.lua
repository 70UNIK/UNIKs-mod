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
        end
        if G.GAME.OvershootFXVal and G.GAME.OvershootFXVal >= 5 then
            G.GAME.unik_force_epic_plus = math.max(1,G.GAME.unik_force_epic_plus)
        end
        if G.GAME.unik_force_epic_plus > 0 or G.GAME.modifiers.cry_rush_hour_ii then
            self.GAME.round_resets.blind_choices.Big = get_new_boss()
        end
        if G.GAME.OvershootFXVal and G.GAME.OvershootFXVal >= 5 then
            G.GAME.unik_force_epic_plus = math.max(1,G.GAME.unik_force_epic_plus)
        end
        if G.GAME.superboss_active and G.GAME.unik_force_epic_plus > 0 then
            self.GAME.round_resets.blind_choices.Boss = get_new_boss()
        end
        
    end
end
get_new_small = get_new_small or function() return 'bl_small' end
get_new_big = get_new_big or function() return 'bl_big' end

--can force modify a small slot into a boss, etc...
function UNIK.check_and_change_blind_type(type)
    local newType = string.lower(type)
    if G.GAME.OvershootFXVal and G.GAME.OvershootFXVal >= 5 then
            G.GAME.unik_force_epic_plus = math.max(1,G.GAME.unik_force_epic_plus)
        end
    if newType == 'small' then
        if G.GAME.unik_force_epic_plus > 0 or G.GAME.modifiers.cry_rush_hour_ii then
            newType = 'boss'
            print("BOSS overrides small")
        end
    elseif newType == 'big' then
        if G.GAME.unik_force_epic_plus > 0 or G.GAME.modifiers.cry_rush_hour_ii or G.GAME.aij_force_big_to_be_boss then
            newType = 'boss'
            print("BOSS overrides big")
        end
    elseif newType == 'boss' then
        
    end
    return newType
end
local reset_override = reset_blinds
function reset_blinds()
    if not UNIK.hasBlindside() then
        if G.GAME.round_resets.blind_states.Boss == 'Defeated' then
            G.GAME.round_resets.blind_choices.Small = "bl_small"
            G.GAME.round_resets.blind_choices.Big = "bl_big"
        end
    end
    --default state
    reset_override()
    if not UNIK.hasBlindside() then
        if G.GAME.OvershootFXVal and G.GAME.OvershootFXVal >= 5 then
            G.GAME.unik_force_epic_plus = math.max(1,G.GAME.unik_force_epic_plus)
        end
        if G.GAME.round_resets.blind_states.Small == 'Upcoming' and
            G.GAME.round_resets.blind_states.Big == 'Upcoming' and
            G.GAME.round_resets.blind_states.Boss == 'Upcoming' then
             SMODS.calculate_context({unik_refresh_blinds = true})
             G.GAME.unik_force_cursed_jokers = nil
             G.GAME.ante_rerolls = 0
             G.GAME.unik_ante_spent = 0
             G.GAME.ante_spent = 0
             for i,v in pairs(G.jokers.cards) do
                v.ability.unik_bought_this_ante = nil
             end
        end
    else
        if G.GAME.round_resets.blind_states.Small == 'Upcoming' and
            G.GAME.round_resets.blind_states.Big == 'Upcoming' and
            G.GAME.round_resets.blind_states.Boss == 'Upcoming' then
                SMODS.calculate_context({unik_refresh_blinds = true})
                G.GAME.unik_force_cursed_jokers = nil
                G.GAME.ante_rerolls = 0
                G.GAME.unik_ante_spent = 0
                G.GAME.ante_spent = 0
                for i,v in pairs(G.jokers.cards) do
                    v.ability.unik_bought_this_ante = nil
                end
        end
    end
end

local showdowner = SMODS.is_showdown_ante
function SMODS.is_showdown_ante()
    local ret = showdowner()
    if vice_check() == 1 then
        return true
    end
    return ret
end

--Blind refresh

local blindPool = SMODS.create_blind_pool
function SMODS.create_blind_pool(blind_type, skip_cull,...)
    local force_bosses = blind_type == 'boss' or false
    
    local force_finishers = blind_type == 'boss' and SMODS.is_showdown_ante() or false
    local force_epic = false
    local other_args = {...}
    if G.GAME.OvershootFXVal and G.GAME.OvershootFXVal >= 5 then
        G.GAME.unik_force_epic_plus = math.max(1,G.GAME.unik_force_epic_plus)
    end
    local eligible_bosses = {}
    if G.GAME.unik_force_epic_plus > 0 then
        force_epic = true
    end


    if force_epic then force_finishers = true end
    if force_finishers then force_bosses = true end
    
    
    local ret = blindPool(force_bosses and 'boss' or blind_type, skip_cull,...)

    local boss_already_chosen = function(key)
        for _, k in pairs(G.GAME.round_resets.blind_choices) do
            if k == key then return true end
        end
    end
    
    if force_finishers then
        blind_type = 'boss'
        for k, v in pairs(G.P_BLINDS) do
            if v.boss and v.boss.showdown then
                local res, options = SMODS.add_to_pool(v)
                options = options or {}
                if boss_already_chosen(k) then
                elseif options.ignore_showdown_check then
                    eligible_bosses[k] = res and true or nil
                else
                    if not UNIK.hasBlindside() then
                        if (unik_config.unik_legendary_blinds and force_epic and (v.boss.epic or v.boss.legendary)) then
                            eligible_bosses[k] = res and true or nil
                        elseif (not force_epic) then
                            eligible_bosses[k] = res and true or nil
                        end
                    else
                        if (unik_config.unik_legendary_blinds and force_epic and (v.boss.ancient or v.boss.exotic)) then
                            eligible_bosses[k] = res and true or nil
                        elseif (not force_epic) then
                            eligible_bosses[k] = res and true or nil
                        end
                    end
                    
                end
            else
                eligible_bosses[k] = nil
            end
        end

        if skip_cull then 
            local final_pool = {}
            for k, _ in pairs(eligible_bosses) do
                final_pool[#final_pool + 1] = k
            end
            return final_pool
        end

        local min_use = 100
        for k, v in pairs(G.GAME.bosses_used[blind_type] or G.GAME.bosses_used) do
            if eligible_bosses[k] then
                eligible_bosses[k] = v
                if eligible_bosses[k] <= min_use then 
                    min_use = eligible_bosses[k]
                end
            end
        end
        local final_pool = {}
        for k, v in pairs(eligible_bosses) do
            if eligible_bosses[k] then
                if eligible_bosses[k] > min_use and not G.P_BLINDS[k][blind_type].allow_duplicates then 
                    eligible_bosses[k] = nil
                else
                    final_pool[#final_pool + 1] = k
                end
            end
        end

        local output = {}
        for k, _ in pairs(eligible_bosses) do
            output[#output + 1] = k
        end
        
        return output
    end


    
    return ret
end

--Gets either:
--Bigger blind randomly
--A finisher blind if the vice check succeeds
local boss_override = get_new_boss
function get_new_boss()
    if G.GAME.unik_force_cursed_jokers then
        local ret = get_new_cursed()
        return ret
    end
    if G.GAME.OvershootFXVal and G.GAME.OvershootFXVal >= 5 then
        G.GAME.unik_force_epic_plus = math.max(1,G.GAME.unik_force_epic_plus)
    end
    local boss = boss_override()
    --decrement force epic plus for every epic/legendary blind successfully selected due to stuff like Epic Vice
    if unik_config.unik_legendary_blinds and G.P_BLINDS[boss] and G.P_BLINDS[boss].boss then
        if ((G.P_BLINDS[boss].boss.epic or G.P_BLINDS[boss].boss.legendary)) and G.GAME.unik_force_epic_plus and G.GAME.unik_force_epic_plus > 0 then
            G.GAME.unik_force_epic_plus = G.GAME.unik_force_epic_plus - 1
        end
    else
        if ((G.P_BLINDS[boss].boss.showdown)) and G.GAME.unik_force_epic_plus and G.GAME.unik_force_epic_plus > 0 then
            G.GAME.unik_force_epic_plus = G.GAME.unik_force_epic_plus - 1
        end
    end
    --blindside
    if unik_config.unik_legendary_blinds and G.P_BLINDS[boss] and G.P_BLINDS[boss].boss then
        if ((G.P_BLINDS[boss].boss.ancient or G.P_BLINDS[boss].boss.exotic)) and G.GAME.unik_force_epic_plus and G.GAME.unik_force_epic_plus > 0 then
            G.GAME.unik_force_epic_plus = G.GAME.unik_force_epic_plus - 1
        end
    else
        if ((G.P_BLINDS[boss].boss.showdown)) and G.GAME.unik_force_epic_plus and G.GAME.unik_force_epic_plus > 0 then
            G.GAME.unik_force_epic_plus = G.GAME.unik_force_epic_plus - 1
        end
    end
    
    return boss
end