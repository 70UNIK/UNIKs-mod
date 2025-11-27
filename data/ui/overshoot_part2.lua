
--shows:
--overshot amount, the required score to overshoot, your current overshoot and the current overshoot effect
function G.UIDEF.overshoot_info(highlighted)
    
    local overshoot_amounts = {}
    local base_value = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling
    if G.GAME and G.GAME.blind and G.GAME.blind.in_blind then
        base_value = G.GAME.blind.chips
    end
    -- automatically break if naneinf is detected (will default to +7)
    local amount = math.min(base_value*10^50,base_value^2.5)
    for i = 1, 20 do 
        local spacing = 1 - math.min(20, math.max(15, base_value))*0.06
        if spacing > 0 and i > 1 then 
            overshoot_amounts[#overshoot_amounts+1] = {n=G.UIT.R, config={minh = spacing}, nodes={}}
        end
        local blind_chip = Sprite(0,0,0.2,0.2,G.ASSET_ATLAS["ui_"..(G.SETTINGS.colourblind_option and 2 or 1)], {x=0, y=0})
        blind_chip.states.drag.can = false
        local value = amount
        local interval = i
        --naneinf is a flat +7
        if tostring(number_format(value)) == 'naneinf' then
            interval = 7
        end
        overshoot_amounts[#overshoot_amounts+1] = {n=G.UIT.R, config={align = "cm", padding = 0.03}, nodes={
            {n=G.UIT.C, config={align = "cm", minw = 0.7}, nodes={
            {n=G.UIT.T, config={text = "+" .. interval, scale = 0.4, colour = G.C.FILTER, shadow = true}},
            }},
            {n=G.UIT.C, config={align = "cr", minw = 2.8}, nodes={
            {n=G.UIT.O, config={object = blind_chip}},
            {n=G.UIT.C, config={align = "cm", minw = 0.03, minh = 0.01}, nodes={}},
            {n=G.UIT.T, config={text =number_format(value), scale = 0.4, colour = G.C.RED, shadow = true,id='overshoot_info_amount_' .. i}},
            }}
        }}
        --naneinf will stop generating more lists
        if tostring(number_format(value)) == 'naneinf' then
            break
        end
        amount = math.min(amount^1.5,amount*10^25)
    end

    local overshootUIs = {}
    local storage = {}
    --overshoot effect indicators (6 exactly)
    for i = 1, 6 do
        local numero = i - 1
        local requirement = numero*5
        local highlighted = G.GAME.OvershootFXVal == numero or false
        
        overshootUIs[#overshootUIs+1] = {n=G.UIT.C, config={
        align = "cm", 
        minh = 1, 
        padding = 0.05, 
        r = 0.1, 
        colour=highlighted and darken(G.C.UNIK_RGB,0.3) or darken(G.C.JOKER_GREY,0.3),
        emboss=0.05,
        hover = true, 
        can_collide = true,
        shadow = true,
        id = 'unik_overshoot_effect_box'..numero,
        unik_fake_tooltip = {title = localize("overshoot_unik"), text = localize("overshoot_unik_" .. numero)},
        },
        nodes={
            {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
                {n=G.UIT.T, config={text = localize('k_overshoot'), scale = 0.5, colour = G.C.WHITE, shadow = true}},
            }},
            {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
                {n=G.UIT.T, config={text = requirement, scale = 0.5, colour = G.C.WHITE, shadow = true, id = 'overshoot_info_number'}},
            }}
        }}
        --loop ui
        if i % 3 == 0 then
            storage[#storage+1] = {n=G.UIT.R, config={align = "cm", minw = 0.7}, nodes=overshootUIs}
            overshootUIs = {}
        end
        
        
    end

    local realstorage = {}
    realstorage[#realstorage+1] = {n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
            {n=G.UIT.C, config={align = "cm", r = 0.1, colour = darken(G.C.BLACK, 0.05), padding = 0.1,minw = 2,scale = 0.6}, nodes={
                {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
                    {n=G.UIT.T, config={text = localize('k_current') .. " ", scale = 0.5, colour = lighten(G.C.RED, 0.2), shadow = true}},
                    {n=G.UIT.T, config={text = localize('k_overshoot'), scale = 0.5, colour = lighten(G.C.RED, 0.2), shadow = true}},
                }},
                {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
                    --{n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'unik_overshoot'}}, colour = lighten(G.C.UNIK_RGB, 0.2),shadow = true, scale = 2}),id = 'overshoot_info_number'}},
                    {n=G.UIT.T, config={text = G.GAME.unik_overshoot, scale = 2, colour = lighten(G.C.UNIK_RGB, 0.2), shadow = true, id = 'overshoot_info_number'}},
                }}
            }},
        }}
    realstorage[#realstorage+1] = {n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
        {n=G.UIT.C, config={align = "cm"}, nodes={
            {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
                {n=G.UIT.T, config={text = localize('k_overshoot_effects'), scale = 0.5, colour = G.C.WHITE, shadow = true}},
            }},
        }},
    }}
    for i = 1, #storage do
        -- print(#storage)
        realstorage[#realstorage+1] = storage[i]
    end
    local w = {}
    --the amounts for overshoot
    w[#w+1] = {n=G.UIT.C, config={align = "cm", r = 0.1, colour = G.C.L_BLACK, padding = 0.1, force_focus = true, focus_args = {nav = 'tall'}}, nodes={
        {n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
          {n=G.UIT.C, config={align = "cm", minw = 0.7}, nodes={
            {n=G.UIT.T, config={text = localize('k_unik_overshoot_addition'), scale = 0.4, colour = lighten(G.C.FILTER, 0.2), shadow = true}},
          }},
          {n=G.UIT.C, config={align = "cr", minw = 2.8}, nodes={
            {n=G.UIT.T, config={text = localize('k_unik_overshoot_score'), scale = 0.4, colour = lighten(G.C.RED, 0.2), shadow = true}},
          }}
        }},
        {n=G.UIT.R, config={align = "cm"}, nodes=overshoot_amounts}
    }}
    --big overshoot number
    w[#w+1] = {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes=realstorage}
    -- w[#w+1] = 
    -- --overshoot effect dials
    -- w[#w+1] = 
    local t = create_UIBox_generic_options({contents =w})
    

    return t
end


G.FUNCS.overshoot_jiggle = function(e)
    G.GAME.OvershootFXVal = G.GAME.OvershootFXVal or 0
    if G.OVERLAY_MENU then
        local overshootEffect = G.OVERLAY_MENU:get_UIE_by_ID('unik_overshoot_effect_box'.. G.GAME.OvershootFXVal)
        local target = G.OVERLAY_MENU:get_UIE_by_ID("overshoot_info_number")
        if target and overshootEffect then
            overshootEffect:juice_up(1.0,1.0)
            target:juice_up(1.0,1.0)
        else
            print("ERROR!")
        end
    else
        print("err not found")
    end
    
end

--straddle styled overshoot popup
function unik_trigger_overshoot_menu()