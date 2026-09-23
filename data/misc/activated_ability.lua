--all in jest partially inspired, refactor lily to use activated abilities
G.FUNCS.unik_can_activate_ability_button = function(e)
    local obj = e.config.ref_table.config.center
    local can_use = false
    if obj and obj.unik_can_activate_ability and type(obj.unik_can_activate_ability) == 'function' and
            G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT then
        can_use = obj:unik_can_activate_ability(e.config.ref_table)
    end
    if e.config.ref_table.debuff then
        can_use = false
    end
    if (G.play and #G.play.cards > 0) or (G.CONTROLLER.locked) or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0) then 
        can_use = false
    end
    if can_use then 
        e.config.colour = G.C.RED
        e.config.button = 'unik_activate_ability_button'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

G.FUNCS.unik_activate_ability_button = function(e, mute, nosave)
    local card = e.config.ref_table
    local area = card.area

    e.config.ref_table.config.center:unik_activated_ability(card)
    -- SMODS.calculate_context({all_in_jest = {using_ability = true, card = card, area = card.from_area}})
end


--Add "devour" button on highlight
  local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
  function G.UIDEF.use_and_sell_buttons(card)
    local tdc =  G_UIDEF_use_and_sell_buttons_ref(card)
    if (card.area == G.jokers) and card.config.center.unik_activated_ability and type(card.config.center.unik_activated_ability) == "function"   then --Add a devour button
        local sell = nil
        local use = nil

        sell = {n=G.UIT.C, config={align = "cr"}, nodes={
        {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card'}, nodes={
            {n=G.UIT.B, config = {w=0.1,h=0.6}},
            {n=G.UIT.C, config={align = "tm"}, nodes={
            {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                {n=G.UIT.T, config={text = localize('b_sell'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
            }},
            {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
                {n=G.UIT.T, config={ref_table = card, ref_value = 'sell_cost_label',colour = G.C.WHITE, scale = 0.55, shadow = true}}
            }}
            }}
        }},
        }}
         use = 
            {n=G.UIT.C, config={align = "cr"}, nodes={
            
            {n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'unik_activate_ability_button', func = 'unik_can_activate_ability_button'}, nodes={
                {n=G.UIT.B, config = {w=0.1,h=0.6}},
                {n=G.UIT.T, config={text = localize('b_use'),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
            }}
        }}
        --overwriting usual buttons
        tdc = {
      n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
        {n=G.UIT.C, config={padding = 0.15, align = 'cl'}, nodes={
          {n=G.UIT.R, config={align = 'cl'}, nodes={
            sell
          }},
          {n=G.UIT.R, config={align = 'cl'}, nodes={
            use
          }},
        }},
    }}
    end
    return tdc
end