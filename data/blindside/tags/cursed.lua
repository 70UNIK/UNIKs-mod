--rerolls the next non-boss joker into a Cursed Joker
SMODS.Tag {
    key = "unik_blindside_cursed",
    hide_ability = false,
    atlas = 'unik_tags',
    pos = {x = 5, y = 0},
    in_pool = function(self, args)
        return false
    end,
    config = {
        extra = {
            cannot_copy = true, --martisoka
        }
    },
    pools = {["bld_obj_blindside"] = true},
    loc_vars = function(self, info_queue,tag)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_cursed_joker" }
	end,
    apply = function(self, tag, context)
        if context.type == 'immediate' and not G.GAME.unik_lock_soul_tag then 
            G.GAME.unik_lock_soul_tag = true
            local type = curse_check()
            if type then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                tag:yep('+', HEX("474931"), function() 
                    G.GAME.unik_force_cursed_jokers = true
                    soul_reroll(type)
                    G.E_MANAGER:add_event(Event({func = function()
                        G.GAME.unik_force_cursed_jokers = nil
                            
                        G.E_MANAGER:add_event(Event({func = function()
                            G.GAME.unik_force_cursed_jokers = nil
                            G.CONTROLLER.locks[lock] = nil
                            G.GAME.unik_force_cursed_jokers = nil
                        return true; end}))
                    return true; end}))
                    G.GAME.unik_lock_soul_tag = nil        
                return true end)

                tag.triggered = true
            else
                G.GAME.unik_lock_soul_tag = nil
            end
            
        end
    end,
}

function get_new_cursed(current)
    
    G.GAME.perscribed_cursed = G.GAME.perscribed_cursed or {
    }
    if G.GAME.perscribed_cursed and G.GAME.perscribed_cursed[G.GAME.round_resets.ante] then 
        local ret_boss = G.GAME.perscribed_cursed[G.GAME.round_resets.ante] 
        G.GAME.perscribed_cursed[G.GAME.round_resets.ante] = nil
        return ret_boss
    end
    if G.FORCE_CURSED then return G.FORCE_CURSED end

    if SMODS.optional_features.object_weights then
     --   print("weight1")
        local ret_boss = SMODS.poll_object({type = 'Blind',  blind_type = 'cursed', seed = 'cursed'})
     --   print(ret_boss)
        G.GAME.bosses_used[ret_boss] = G.GAME.bosses_used[ret_boss] + 1
        return ret_boss
    end

    local eligible_bosses = {bl_unik_blindside_monopoly_money = true}
    for k, v in pairs(G.P_BLINDS) do
        local res, options = SMODS.add_to_pool(v)
        options = options or {}
        if not v.cursed then
        elseif k == current then
        elseif v.in_pool and type(v.in_pool) == 'function' then
            eligible_bosses[k] = res and true or nil
        else
            eligible_bosses[k] = res and true or nil
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
                --print(min_use)
            end
        end
    end
    for k, v in pairs(eligible_bosses) do
        if eligible_bosses[k] then
            --print(eligible_bosses[k])
            if eligible_bosses[k] > min_use then 
                eligible_bosses[k] = nil
            end
        end
    end
    if G.GAME.selected_back.effect.center.config.extra and G.GAME.selected_back.effect.center.config.extra.blindside then
        for k, v in pairs(eligible_bosses) do
            if v and not BLINDSIDE.is_blindside(k) then
                eligible_bosses[k] = nil
            end
        end
    end
    local _, boss = pseudorandom_element(eligible_bosses, pseudoseed('cursed'))
    if boss then
        G.GAME.bosses_used[boss] = G.GAME.bosses_used[boss] + 1
    else --fallback
        boss = 'bl_unik_blindside_monopoly_money'
    end
    return boss
end

function isNotBossJoker(joker)
    if G.P_BLINDS[joker] and not G.P_BLINDS[joker].boss and not G.P_BLINDS[joker].cursed  then
        return true
    end
    return false
end

function curse_check()
    local triggered = nil
    local blinds = {"Small","Big","Boss"}
    for i = 1, #blinds do
        
        if G.GAME.round_resets.blind_states[blinds[i]] == "Upcoming" or G.GAME.round_resets.blind_states[blinds[i]] == 'Select' then
            if isNotBossJoker(G.GAME.round_resets.blind_choices[blinds[i]]) then
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