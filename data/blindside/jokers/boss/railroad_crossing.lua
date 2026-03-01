UNIK.blindside_colours = {'Red', 'Green', 'Blue', 'Yellow', 'Purple', 'Faded'}
BLINDSIDE.Joker({
    blindside_joker = true,
    key = 'unik_blindside_railroad_crossing',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=7},
    boss_colour = HEX("f00039"),
    mult = 8,
    base_dollars = 8,
    order = 1,
    boss = {min = 2},
    active = true,
    loc_vars = function(self)
        if not G.GAME.railroad_debuffed_hue then
            return { vars = { localize('k_unik_random_hue') } }
        end
        return { vars = { localize("bld_" .. G.GAME.railroad_debuffed_hue,"suits_plural") } }
    end,
    collection_loc_vars = function(self)
        
        return { vars = { localize('k_unik_random_hue') } }
    end,
    death_card = {
        card = 'j_unik_railroad_crossing', 
        mod_card = function(self, card) --used to apply editions and/or stickers
            
        end,
        quotes = {'unik_blindside_railroad_crossing_lose'},
    },
    unik_before_play = function(self)
        
        for i,v in pairs(G.hand.cards) do
            if v.facing ~= 'back' and v.debuff then
                v:flip()
                v.flipped_by_railroad = true
            end
        end
    end,
    calculate = function(self, blind, context)
        
        if context.setting_blind and not context.disabled then
            blind.active = true
        end
        if context.before then
            for i,v in pairs(G.play.cards) do
                if v.facing ~= 'back' and v.debuff then
                    v:flip()
                end
            end
        end
        if context.after and not G.GAME.blind.disabled  then
            
            G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0, func = function()
                    
            for i=1, #G.hand.cards do
                local carder = G.hand.cards[i]
                
                if carder.flipped_by_railroad and carder.facing == 'back' and (not carder.ability.extra or (carder.ability.extra and not carder.ability.extra.flipped)) then
                    carder:flip()
                    carder.flipped_by_railroad = nil
                end
            end
            for i,v in pairs(G.playing_cards) do
                v.flipped_by_railroad = nil
            end
                        return true
                    end}))
            if G.GAME.blind.active then

            for i=1,2 do
                if i == 2 then
                    G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.5, func = function()
                    
                        G.GAME.blind:wiggle()
                        return true
                    end}))
                    
                    play_area_status_text(localize('k_unik_repeat'))
                    if SMODS.hand_debuff_source then SMODS.hand_debuff_source:juice_up(0.3,0) else  end
                end
                G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.5, func = function()
                    
                    G.hand_text_area.blind_mult_text:juice_up()
                    G.GAME.blind.mult_text = number_format(G.GAME.blind.mult*1.31^i)
                    if not silent then play_sound('multhit2') end
                    return true
                end}))
                delay(1)
            end
             G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.5, func = function()
                    
                G.GAME.blind.mult = G.GAME.blind.mult*1.31*1.31
                return true
            end}))
            
            G.GAME.playing_with_fire_num = G.GAME.playing_with_fire_num + 1
            G.GAME.playing_with_fire_each = G.GAME.used_vouchers.v_bld_swearjar and "bld_playing_with_fire_each_3" or "bld_playing_with_fire_each_2"
            G.GAME.playing_with_fire = G.GAME.playing_with_fire + 2 + (G.GAME.used_vouchers.v_bld_swearjar and 1 or 0)
            G.GAME.blind.active = nil
        end
        end
        if not G.GAME.blind.disabled then
            if context.debuff_card then
                if G.GAME.railroad_debuffed_hue and context.debuff_card:is_color(G.GAME.railroad_debuffed_hue) then
                    return {
                        debuff = true
                    }
                end
            end
            if context.press_play then
                blind.prepped = true

            end
            if context.hand_drawn then
                G.GAME.unik_dynamic_text_realtime = true
                if blind.prepped then
                    local valid_colours = {}
                    for i=1,#UNIK.blindside_colours do
                        if not G.GAME.railroad_debuffed_hue then
                            valid_colours[#valid_colours+1] = UNIK.blindside_colours[i]
                        elseif UNIK.blindside_colours[i] ~= G.GAME.railroad_debuffed_hue then
                            valid_colours[#valid_colours+1] = UNIK.blindside_colours[i]
                        end
                    end
                    G.GAME.railroad_debuffed_hue = pseudorandom_element(valid_colours, pseudoseed("unik_railroad_debuff_blind"))
                    for i,v in pairs(G.playing_cards) do
                        if not v.seal or (v.seal and not v.seal ~= 'bld_wild') then
                            SMODS.recalc_debuff(v)
                            if v:is_color(G.GAME.railroad_debuffed_hue) then
                                v:juice_up()
                            end
                        end

                    end
                    blind:wiggle()
                end
            end
        if context.hand_drawn then
            blind.prepped = nil
        end
        end
    end,
    disable = function(self)
        G.GAME.unik_dynamic_text_realtime = nil
        G.GAME.railroad_debuffed_hue = nil
        for i,v in pairs(G.playing_cards) do
            SMODS.recalc_debuff(v)
        end
    end,
    joker_defeat = function()
        G.GAME.unik_dynamic_text_realtime = nil
        G.GAME.railroad_debuffed_hue = nil
    end
})