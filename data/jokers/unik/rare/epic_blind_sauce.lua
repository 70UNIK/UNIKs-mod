
--EPIC
function ForceEpicBlind()
    G.GAME.unik_force_epic_plus = G.GAME.unik_force_epic_plus or 0
    G.GAME.unik_force_epic_plus = G.GAME.unik_force_epic_plus + 1
    if G.GAME.round_resets.blind_states.Small == "Upcoming" then
        if G.GAME.round_resets.cookie_increment and G.GAME.round_resets.cookie_increment.Small then
            G.GAME.round_resets.cookie_increment.Small = nil
        end
        G.GAME.round_resets.blind_choices.Small = get_new_boss()
        
    elseif G.GAME.round_resets.blind_states.Big == "Upcoming" then
        if G.GAME.round_resets.cookie_increment and G.GAME.round_resets.cookie_increment.Big then
            G.GAME.round_resets.cookie_increment.Big = nil
        end
        G.GAME.round_resets.blind_choices.Big = get_new_boss()
    elseif G.GAME.round_resets.blind_states.Boss == "Upcoming" then 
        if G.GAME.round_resets.cookie_increment and G.GAME.round_resets.cookie_increment.Boss then
            G.GAME.round_resets.cookie_increment.Boss = nil
        end
        G.GAME.round_resets.blind_choices.Boss = get_new_boss()
    else
        
    end
end

function rerollAnyBlind(type,blind)
    stop_use()
    
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
        play_sound('other1')
            if G.STATE == G.STATES.BLIND_SELECT then
                G.blind_select_opts[string.lower(type)]:set_role({xy_bond = 'Weak'})
                G.blind_select_opts[string.lower(type)].alignment.offset.y = 20
            end

        return true
        end
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.3,
        func = (function()
            G.GAME.round_resets.blind_choices[type] = blind
            if G.STATE == G.STATES.BLIND_SELECT then
                local par = G.blind_select_opts[string.lower(type)].parent
                G.blind_select_opts[string.lower(type)]:remove()
                    G.blind_select_opts[string.lower(type)] = UIBox{
                    T = {par.T.x, 0, 0, 0, },
                    definition =
                        {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
                        UIBox_dyn_container({create_UIBox_blind_choice(type)},false,get_blind_main_colour('Boss'), mix_colours(G.C.BLACK, get_blind_main_colour('Boss'), 0.8))
                        }},
                    config = {align="bmi",
                                offset = {x=0,y=G.ROOM.T.y + 9},
                                major = par,
                                xy_bond = 'Weak'
                            }
                    }
                par.config.object = G.blind_select_opts[string.lower(type)]
                par.config.object:recalculate()
                G.blind_select_opts[string.lower(type)].parent = par
                G.blind_select_opts[string.lower(type)].alignment.offset.y = 0
            end
            return true
        end)
    }))
end
function epic_blind_sauce_reroll()
    local triggered = false
    G.CONTROLLER.locks.boss_reroll = true
    local blinds = {Small = true, Big = true, Boss = true}
    for i,v in pairs(blinds) do
        
        if G.GAME.round_resets.blind_states[i] == "Upcoming" or G.GAME.round_resets.blind_states[i] == 'Select' then
            local isSelected = false
            if G.GAME.round_resets.blind_states[i] == 'Select' then
                isSelected = true
            end
            if G.P_BLINDS[G.GAME.round_resets.blind_choices[i]] and G.P_BLINDS[G.GAME.round_resets.blind_choices[i]].boss and
            (G.P_BLINDS[G.GAME.round_resets.blind_choices[i]].boss.epic or G.P_BLINDS[G.GAME.round_resets.blind_choices[i]].boss.legendary or
            G.P_BLINDS[G.GAME.round_resets.blind_choices[i]].boss.ancient or G.P_BLINDS[G.GAME.round_resets.blind_choices[i]].boss.exotic) then
                
            elseif (G.GAME.round_resets.blind_choices[i] == "bl_small" or G.GAME.round_resets.blind_choices[i] == "bl_big") and
            not G.P_BLINDS[G.GAME.round_resets.blind_choices[i]].boss
            then
                triggered = true
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        
                    G.GAME.unik_force_boss_blind = G.GAME.unik_force_boss_blind or 0
                    G.GAME.unik_force_boss_blind = G.GAME.unik_force_boss_blind + 1
                   -- print("Reroll small/big")
                    local boss = get_new_boss()
                  --  print(boss)
                    rerollAnyBlind(i,boss)
                    return true
                    end
                }))
                
            elseif i == "Boss" and ((G.P_BLINDS[G.GAME.round_resets.blind_choices[i]] and G.P_BLINDS[G.GAME.round_resets.blind_choices[i]].boss 
            and not G.P_BLINDS[G.GAME.round_resets.blind_choices[i]].boss.showdown) or 
            G.GAME.round_resets.blind_choices[i] == "bl_unik_bigger_blind")
             then
                triggered = true
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        
                    G.GAME.unik_force_finisher_blinds = true
                 --   print("reroll_boss")
                    local boss = get_new_boss()
                 --   print(boss)
                    rerollAnyBlind(i,boss)
                    G.GAME.unik_force_finisher_blinds = nil
                    return true
                    end
                }))
                
            end
              G.E_MANAGER:add_event(Event({blocking = false, trigger = 'after', delay = 0,func = function()
                    if isSelected then
                        G.GAME.round_resets.blind_states[i] = 'Select'
                    end
                    return true
                    end
                }))
        end
    end
     G.E_MANAGER:add_event(Event({blocking = false, trigger = 'after', delay = 0.2,func = function()
        G.CONTROLLER.locks.boss_reroll = nil
        return true
        end
    }))
    return triggered
end 
SMODS.Joker {
    key = 'unik_epic_blind_sauce',
    atlas = 'unik_epic',
    rarity = 3,
	pos = { x = 0, y = 1 },
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = false,
    demicoloncompat = true,
    config = { extra = { x_mult = 6 }},
    loc_vars = function(self, info_queue, center)
        return { vars = {center.ability.extra.x_mult} }

	end,
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
            if epic_blind_sauce_reroll() then
                card:juice_up(0.8, 0.8)
            end
            return true
            end
        }))
        
    end,
    calculate = function(self, card, context)
        --dont try to force trigger it. It will self destruct and guarantee an epic blind.
        if context.forcetrigger or context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
        if context.unik_refresh_blinds then
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                if epic_blind_sauce_reroll() then
                    card:juice_up(0.8, 0.8)
                end
                return true
                end
            }))
        end
    end
}