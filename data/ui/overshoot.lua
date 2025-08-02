local uibox_ref = create_UIBox_HUD
function create_UIBox_HUD()
    local orig = uibox_ref()
    local scale = 0.4
    local stake_sprite = get_stake_sprite(G.GAME.stake or 1, 0.5)

    -- local contents = {}

    local spacing = 0.13
    local temp_col = G.C.DYN_UI.BOSS_MAIN
    local temp_col2 = G.C.DYN_UI.BOSS_DARK

    G.GAME.unik_overshoot = G.GAME.unik_overshoot or 0
    G.GAME.OvershootFXVal = G.GAME.OvershootFXVal or 0

    --Shortening buttons:
    --Run info
    if orig.nodes[1].nodes[1].nodes[5].nodes[1].nodes[1].nodes[1].config.id == "run_info_button" then
    orig.nodes[1].nodes[1].nodes[5].nodes[1].nodes[1].nodes[1] = {n=G.UIT.R, config={id = 'run_info_button', align = "cm", minh = 1, minw = 1.5,padding = 0.05, r = 0.1, hover = true, colour = G.C.RED, button = "run_info", shadow = true}, nodes={
            {n=G.UIT.R, config={align = "cm", padding = 0, maxw = 1.4}, nodes={
              {n=G.UIT.T, config={text = localize('b_run_info_1'), scale = 1.2*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
            }},
            {n=G.UIT.R, config={align = "cm", padding = 0, maxw = 1.4}, nodes={
              {n=G.UIT.T, config={text = localize('b_run_info_2'), scale = 1*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true, focus_args = {button = G.F_GUIDE and 'guide' or 'back', orientation = 'bm'}, func = 'set_button_pip'}}
            }}
          }}
    end
    --options:
    if orig.nodes[1].nodes[1].nodes[5].nodes[1].nodes[1].nodes[2].config.button == "options" then
        orig.nodes[1].nodes[1].nodes[5].nodes[1].nodes[1].nodes[2] = {n=G.UIT.R, config={align = "cm", minh = 1, minw = 1.5,padding = 0.05, r = 0.1, hover = true, colour = G.C.ORANGE, button = "options", shadow = true}, nodes={
            {n=G.UIT.C, config={align = "cm", maxw = 1.4, focus_args = {button = 'start', orientation = 'bm'}, func = 'set_button_pip'}, nodes={
              {n=G.UIT.T, config={text = localize('b_options'), scale = scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
            }},
          }}
    end
    
    local info_queue = {}
    info_queue[#info_queue+1] = UNIK.OvershootFXs["overshoot_unik_" .. G.GAME.OvershootFXVal]
    --adding a new button
     orig.nodes[1].nodes[1].nodes[5].nodes[1].nodes[1].nodes[#orig.nodes[1].nodes[1].nodes[5].nodes[1].nodes[1].nodes + 1] = {n=G.UIT.R, config={
        align = "cm", 
        
        minh = 1, 
        maxw = 1.4,
        padding = 0.05, 
        r = 0.1, 
        colour=G.C.DYN_UI.BOSS_MAIN,
        emboss=0.05,
        -- hover = true, 
        -- can_collide = true,
        -- detailed_tooltip = UNIK.OvershootFXs["overshoot_unik_" .. G.GAME.OvershootFXVal],
        },
     nodes={
        {n=G.UIT.R, config={align = "cm", maxw = 1.4}, nodes={
          {n=G.UIT.T, config={text = localize('k_overshoot'), minh = 0.33, scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
        }},
        {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1, colour = temp_col2, id = 'row_overshoot_text'}, nodes={
          {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'unik_overshoot'}}, colours = {G.C.UNIK_RGB},shadow = true, scale = 2*scale}),id = 'unik_overshoot_UI_count'}},
        }},
        }}
    return orig
end
local ante_modifier = ease_ante
function ease_ante(mod)
    local newAnteMod = mod
    if newAnteMod > 0 then
        if G.GAME.OvershootFXVal >= 5 then
            newAnteMod = newAnteMod + math.max(0,G.GAME.unik_overshoot - 20)
        elseif G.GAME.OvershootFXVal >= 4 then
            newAnteMod = newAnteMod + 2
        elseif G.GAME.OvershootFXVal >= 1 then
            newAnteMod = newAnteMod + 1
        end
    end
    
    ante_modifier(newAnteMod)
end
local function removeFormat(string_in)
    return string.gsub(string_in, "{.-}", "")
end

--Taken from aikoyoris for overshoot hover FX
-- UNIK.overshoot_ui_add = function(nodes, key, scale)
--     local m = G.localization.descriptions["OvershootFX"][key]
--     local l = {
--         {
--             n = G.UIT.R,
--             nodes = {
--                 { n = G.UIT.T, config = { text = m.name, colour = G.C.UI.TEXT_LIGHT, scale = scale*1.2 }},
--             }
--         }
--     }
--     if m.text and false then
--         for i, tx in ipairs(m.text) do
--             table.insert(l, 
--                 {
--                     n = G.UIT.R,
--                     nodes = {
--                         { n = G.UIT.T, config = { text = removeFormat(tx), colour = G.C.UI.TEXT_LIGHT, scale = scale }},
--                     }
--                 }
--             )
--         end
--     end
    
--     local x = {
--         n = G.UIT.C,
--         config = { align = "lm", padding = 0.1 },
--         nodes = {
--             { n = G.UIT.R, config = {}, nodes = l },
            
--         }
--     }
--     table.insert(nodes, x)
-- end

function unik_ease_overshoot(mod)
    G.GAME.unik_overshoot = G.GAME.unik_overshoot or 0
    if G.GAME.unik_overshoot + mod >= 0 then
        G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
            local ante_UI = G.HUD:get_UIE_by_ID('unik_overshoot_UI_count')
            mod = mod or 0
            if mod ~= 0 then
                local text = '+'
            local col = G.C.UNIK_EYE_SEARING_RED
            if mod < 0 then
                text = '-'
                col = G.C.GREEN
            end
            G.GAME.unik_overshoot = G.GAME.unik_overshoot + mod
            --   G.GAME.round_resets.ante_disp = number_format(G.GAME.round_resets.ante)
            G.GAME.unik_overshoot = math.floor(G.GAME.unik_overshoot)
            ante_UI.config.object:update()
            G.HUD:recalculate()
            --Popup text next to the chips in UI showing number of chips gained/lost
            attention_text({
                text = text..tostring(math.abs(mod)),
                scale = 1, 
                hold = 0.7,
                cover = ante_UI.parent,
                cover_colour = col,
                align = 'cm',
                })
            --Play a chip sound
                play_sound('highlight2', 0.5, 0.2)
                play_sound('generic1')
            end
            return true
        end
        }))
    end
end