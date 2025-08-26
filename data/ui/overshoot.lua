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
    
    --adding a new button
     orig.nodes[1].nodes[1].nodes[5].nodes[1].nodes[1].nodes[#orig.nodes[1].nodes[1].nodes[5].nodes[1].nodes[1].nodes + 1] = {n=G.UIT.R, config={
        align = "cm", 
        
        minh = 1, 
        maxw = 1.4,
        padding = 0.05, 
        r = 0.1, 
        colour=G.C.DYN_UI.BOSS_MAIN,
        emboss=0.05,
        hover = true, 
        can_collide = true,
        id = 'unik_overshoot_desc',
        unik_fake_tooltip = {text = localize("overshoot_unik_" .. G.GAME.OvershootFXVal)},
        },
     nodes={
        {n=G.UIT.R, config={align = "cm", maxw = 1.4}, nodes={
          {n=G.UIT.T, config={text = localize('k_overshoot'), minh = 0.33, scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true
        }},
        }},
        {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1, colour = temp_col2, id = 'row_overshoot_text'}, nodes={
          {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'unik_overshoot'}}, colours = {G.C.UNIK_RGB},shadow = true, scale = 2*scale}),id = 'unik_overshoot_UI_count'}},
        }},
        }}
    return orig
end

--overshoot hover effect update
function set_hud_text()

end

local hover2 = UIElement.hover
function UIElement:hover() 
    if self.config.unik_fake_tooltip then
        self.config.h_popup = create_UIBox_detailed_tooltip_fake_unik(self.config.unik_fake_tooltip)
        self.config.h_popup_config ={align="tm", offset = {x=0,y=-0.1}, parent = self}
    end
    hover2(self)
end

function create_UIBox_detailed_tooltip_fake_unik(tooltip)
    local title = tooltip.title or nil
    local text = tooltip.text or {}
    local rows = {}
    if title then
        local r = {n=G.UIT.R, config={align = "cm"}, nodes={
            {n=G.UIT.C, config={align = "cm"}, nodes={
                {n=G.UIT.T, config={text = title,colour = G.C.UI.TEXT_DARK, scale = 0.2}}}}}}
        table.insert(rows, r)
    end
    for i = 1, #text do
      if type(text[i]) == 'table' then
        local r = {n=G.UIT.R, config={align = "cm", padding = 0.01}, nodes={
          {n=G.UIT.T, config={ref_table = text[i].ref_table, ref_value = text[i].ref_value,colour = G.C.UI.TEXT_DARK, scale = 0.25}}}}
        table.insert(rows, r)
      else
        local r = {n=G.UIT.R, config={align = "cm", padding = 0.01}, nodes={
                {n=G.UIT.T, config={text = text[i],colour = G.C.UI.TEXT_DARK, scale = 0.25}}}}
        table.insert(rows, r)
      end
    end
    if tooltip.filler then 
      table.insert(rows, tooltip.filler.func(tooltip.filler.args))
    end
    local t = {
        n=G.UIT.ROOT, config = {align = "cm", padding = 0.05, r=0.1, colour = G.C.UNIK_RGB, emboss = 0.05}, nodes=
        {{n=G.UIT.C, config={align = "cm", padding = 0.05, r = 0.1, colour = G.C.WHITE, emboss = 0.05}, nodes=rows}}}
    return t
  end

local ante_modifier = ease_ante
function ease_ante(mod)
    local newAnteMod = mod
    if newAnteMod > 0 then
        if G.GAME.OvershootFXVal and G.GAME.OvershootFXVal >= 4 then
            newAnteMod = newAnteMod + G.GAME.OvershootFXVal + math.max(0,math.floor((G.GAME.unik_overshoot - 20)/2))
        elseif G.GAME.OvershootFXVal and G.GAME.OvershootFXVal >= 1 then
            newAnteMod = newAnteMod + G.GAME.OvershootFXVal
        end
    end
    
    ante_modifier(newAnteMod)
end

--Taken from VallKarri, this is to show how much you need for overshoot to increase so you wont have to hit in the dark
local fakeupd = Game.update
function Game:update(dt)
    fakeupd(self, dt)

    if (G.GAME.blind) then

        if (G.GAME.blind.chips) then
            local num = number_format(G.GAME.blind.chips^2.5)
            G.GAME.blind.overshootUIchips = "Overshoot at " .. num
        else
            G.GAME.blind.overshootUIchips = ""
        end
    end

end

local _create_UIBox_HUD_blind = create_UIBox_HUD_blind
function create_UIBox_HUD_blind()
    local ret = _create_UIBox_HUD_blind()


    -- if (not G.GAME.blind.boss) then
    --     return ret
    -- end

    local node = ret.nodes[2]
    node.nodes[#node.nodes + 1] = {
        n = G.UIT.R,
        config = { align = "cm", minh = 0.3, r = 0.1, emboss = 0.05, colour = G.C.DYN_UI.MAIN },
        nodes = {
            {
                n = G.UIT.C,
                config = { align = "cm", minw = 3 },
                nodes = {
                    {
                        n = G.UIT.O,
                        config = {
                            object = DynaText({
                                string = { { ref_table = G.GAME.blind, ref_value = "overshootUIchips"} },
                                colours = { G.C.UI.TEXT_LIGHT },
                                shadow = true,
                                float = true,
                                scale = 0.25,

                            }),
                            id = "overshoot_chips_UI",
                        },
                    },
                },
            },
        },
    }
    return ret
end

-- local function removeFormat(string_in)
--     return string.gsub(string_in, "{.-}", "")
-- end

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
            local ante_UI2 = G.HUD:get_UIE_by_ID('unik_overshoot_desc')
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
            if G.GAME.unik_overshoot < 5 then
                G.GAME.OvershootFXVal = 0
            elseif G.GAME.unik_overshoot < 10 then
                G.GAME.OvershootFXVal = 1
            elseif G.GAME.unik_overshoot < 15 then
                G.GAME.OvershootFXVal = 2
            elseif G.GAME.unik_overshoot < 20 then
                G.GAME.OvershootFXVal = 3
            elseif G.GAME.unik_overshoot < 25 then
                G.GAME.OvershootFXVal = 4
            else
                G.GAME.OvershootFXVal = 5
                
            end
            ante_UI.config.object:update()
            ante_UI2.config.unik_fake_tooltip = {text = localize("overshoot_unik_" .. G.GAME.OvershootFXVal)}
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