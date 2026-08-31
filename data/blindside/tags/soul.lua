--replaces the next boss joker with a finisher joker
--


SMODS.Tag {
    key = "unik_blindside_soul",
    hide_ability = false,
    atlas = 'unik_tags',
    pos = {x = 3, y = 5},
    in_pool = function(self, args)
        return false
    end,
    pools = {["bld_obj_blindside"] = true},
    loc_vars = function(self, info_queue,tag)
        
	end,
    config = {
        extra = {
            hex = true,
        }
    },
    apply = function(self, tag, context)
        if context.type == 'immediate' and not G.GAME.unik_lock_soul_tag then 
            G.GAME.unik_lock_soul_tag = true
            local type = soul_check()
            if type then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                tag:too_bad("TOO BAD", G.C.UNIK_VOID_COLOR, function()
                    G.GAME.unik_force_finisher_blinds = true
                    soul_reroll(type)
                    G.E_MANAGER:add_event(Event({func = function()
                        G.GAME.unik_force_finisher_blinds = nil
                            
                        G.E_MANAGER:add_event(Event({func = function()
                            
                            G.CONTROLLER.locks[lock] = nil
                        return true; end}))
                    return true; end}))
                    
                    G.GAME.unik_lock_soul_tag = nil
                    return true
                end)
                tag.triggered = true
            else
                G.GAME.unik_lock_soul_tag = nil
            end
            
        end
    end,
}
--rerolls the next avaliable non-finisher into a finisher:

--excludes epic+
function isFinisherJoker(joker,include_ancients)
    if G.P_BLINDS[joker] and G.P_BLINDS[joker].boss and G.P_BLINDS[joker].boss.showdown then
        if not include_ancients and (G.P_BLINDS[joker].boss.epic or G.P_BLINDS[joker].boss.legendary or
        G.P_BLINDS[joker].boss.ancient or G.P_BLINDS[joker].boss.exotic) then
            return false
        end
        return true
    end
end

local small_overrider = get_new_small
function get_new_small(current)
    if G.GAME.unik_force_cursed_jokers then
        local ret = get_new_cursed()
        return ret
    end
    if G.GAME.modifiers.unik_bld_boss_everywhere_big_small and G.GAME.blindside_banana_generated and pseudorandom(pseudoseed('unik_small_override')) > 0.75 then
        local ret = get_new_big()
        return ret
    end
    if G.GAME.unik_force_finisher_blinds or (G.GAME.unik_force_epic_plus and G.GAME.unik_force_epic_plus > 0) or (UNIK.overshootEnabled() and G.GAME.OvershootFXVal and G.GAME.OvershootFXVal >= 4) then
        local boss = get_new_boss()
        if boss then
            return boss
        end
    end
    local ret = small_overrider(current)
    return ret

end

local big_overrider = get_new_big
function get_new_big(current)
    if G.GAME.unik_force_cursed_jokers then
        local ret = get_new_cursed()
        return ret
    end
    if G.GAME.unik_force_finisher_blinds or (G.GAME.unik_force_epic_plus and G.GAME.unik_force_epic_plus > 0) or (UNIK.overshootEnabled() and G.GAME.OvershootFXVal and G.GAME.OvershootFXVal >= 4) then
        local boss = get_new_boss()
        if boss then
            return boss
        end
    end
    if G.GAME.modifiers.unik_bld_boss_everywhere_big_small and G.GAME.blindside_banana_generated and pseudorandom(pseudoseed('unik_big_override')) > 0.75 then
        local ret = get_new_boss()
        return ret
    end
    local boss = big_overrider(current)
    
    return boss

end


local poller = SMODS.poll_object
function SMODS.poll_object(args)
    local newArgs = args
    if BLINDSIDE.hasBlindside() then
        if newArgs and newArgs.type == 'Blind' then
            if newArgs.blind_type then
                if G.GAME.unik_force_cursed_jokers then
                        newArgs.blind_type = 'cursed'
                    end
                if newArgs.blind_type == 'small' then
                    if G.GAME.modifiers.unik_bld_boss_everywhere_big_small and G.GAME.blindside_banana_generated and pseudorandom(pseudoseed('unik_small_override')) > 0.75 then
                        print("bigchance")
                        newArgs.blind_type = 'big'
                    end
                    if G.GAME.unik_force_finisher_blinds or (G.GAME.unik_force_epic_plus and G.GAME.unik_force_epic_plus > 0) or (UNIK.overshootEnabled() and G.GAME.OvershootFXVal and G.GAME.OvershootFXVal >= 4) then
                        print("bossoverride")
                        newArgs.blind_type = 'boss'
                    end
                end
                if newArgs.blind_type == 'big' then
                    if G.GAME.modifiers.unik_bld_boss_everywhere_big_small and G.GAME.blindside_banana_generated and pseudorandom(pseudoseed('unik_big_override')) > 0.75 then
                        print("bigchance")
                        newArgs.blind_type = 'boss'
                    end
                    if G.GAME.unik_force_finisher_blinds or (G.GAME.unik_force_epic_plus and G.GAME.unik_force_epic_plus > 0) or (UNIK.overshootEnabled() and G.GAME.OvershootFXVal and G.GAME.OvershootFXVal >= 4) then
                        print("bossoverride")
                        newArgs.blind_type = 'boss'
                    end
                end
            end
        end
    end
    local ret = poller(newArgs)
    if BLINDSIDE.hasBlindside() and newArgs and newArgs.type == 'Blind' and type(ret) == 'string' then
        if ret == 'bl_unik_blindside_infuriating_note' then
            --print("infury")
            G.GAME.unik_infuriating_multiplier = G.GAME.unik_infuriating_multiplier or 1.2
            G.GAME.unik_infuriating_xmult =  G.GAME.unik_infuriating_xmult or 1.2
            G.GAME.unik_infuriating_xmult =  G.GAME.unik_infuriating_multiplier
            G.GAME.unik_infuriating_multiplier = G.GAME.unik_infuriating_multiplier * 1.2
            --print(G.GAME.unik_infuriating_xmult)
            --print(G.GAME.unik_infuriating_multiplier)

        elseif ret == 'bl_unik_blindside_infuriating_notes' then
            --print("infury2")
            G.GAME.unik_infuriating_multiplier = G.GAME.unik_infuriating_multiplier or 1.2
            G.GAME.unik_infuriating_xmult =  G.GAME.unik_infuriating_xmult or 1.2
            G.GAME.unik_infuriating_xmult =  G.GAME.unik_infuriating_multiplier
            G.GAME.unik_infuriating_multiplier = G.GAME.unik_infuriating_multiplier * 1.2^2
            --print(G.GAME.unik_infuriating_xmult)
            --print(G.GAME.unik_infuriating_multiplier)
        end
    end
    return ret
end

-- local getter = SMODS.get_new_blind
-- function SMODS.get_new_blind(blind_type)
--     local typer = blind_type
--     if G.GAME.unik_force_cursed_jokers then
--         typer = 'cursed'
--     end

    
    
--     print(typer)
--     local ret = getter(typer)


--     if BLINDSIDE.hasBlindside() and not BLINDSIDE.is_blindside(ret) then
--         warn("MAJOR JOKER SPAWN FAILURE; fallback to bl_bld_joker")
--         return 'bl_bld_joker'
--     end
    
--     return ret
-- end


function soul_check()
    local triggered = nil
    local blinds = {"Small","Big","Boss"}
    for i = 1, #blinds do
        
        if G.GAME.round_resets.blind_states[blinds[i]] == "Upcoming" or G.GAME.round_resets.blind_states[blinds[i]] == 'Select' then
            if not isFinisherJoker(G.GAME.round_resets.blind_choices[blinds[i]],true) then
                if blinds[i] == "Small" then
                    triggered = blinds[i]
                    break
                elseif blinds[i] == "Big" then
                    triggered = blinds[i]
                    break
                elseif blinds[i] == "Boss" then
                    triggered = blinds[i]
                    break
                end
            end
            
        
        end
    end
    
    return triggered
end
function soul_reroll(type)
    local triggered = false
    if type == "Small" then
        G.from_boss_tag = true
        G.FUNCS.reroll_small()
        triggered = true
    elseif type == "Big" then
        G.from_boss_tag = true
        G.FUNCS.reroll_big()
        triggered = true
    elseif type == "Boss" then
        G.from_boss_tag = true
        G.FUNCS.reroll_boss()
        triggered = true
    end
    
    return triggered
end 