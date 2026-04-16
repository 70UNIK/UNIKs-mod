local createHook = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if G.jokers ~= nil then
        if G.GAME.modifiers.unik_common_only then
            if _rarity == nil
            or ((type(_rarity) == 'number') and (_rarity > 0))
            or ((type(_rarity) == 'string') and (_rarity ~= 'Common')) then
                _rarity = 0
            end
        end
    end
    local card = createHook(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    
    --Forced edition cards
    if card.ability.name == "j_unik_happiness" then
        card:set_edition("e_unik_positive", true, nil, true)
    end
    if card.ability.name == "j_unik_borg_cube" then
        card:set_edition("e_unik_steel", true, nil, true)
    end
    if card.ability.name == "j_unik_binary_asteroid" then
        card:set_edition("e_paperback_dichrome", true, nil, true)
    end
    if G.GAME.modifiers.unik_all_triggering then
        if (_type=='Base' or _type == 'Enhanced') then
            card:set_triggering(true)
        end
    end
    if G.GAME.modifiers.enable_triggering_in_shop then
        if (area == G.shop_jokers) or (area == G.shop_booster) or (area == G.pack_cards) then
            local binning = pseudorandom("unik_triggering_sfff" .. (key_append or "") .. G.GAME.round_resets.ante)
            if G.GAME.modifiers.cry_eternal_perishable_compat and binning > 0.7 then
                card:set_triggering(true)
            elseif not card.ability.eternal then
                if binning > 0.7 then
                    card:set_triggering(true)
                end
            end
        end
    end
    -- if G.GAME.modifiers.unik_bld_add_half and UNIK.hasBlindside() and (_type=='Base' or _type == 'Enhanced') then
    --     if (area == G.shop_jokers) or (area == G.pack_cards) or (area == G.shop_booster) then
    --         local binning = pseudorandom("unik_half__sfff" .. (key_append or "") .. G.GAME.round_resets.ante)
    --         if not card.edition then
    --             if binning > 0.75 then
    --                 card:set_edition({ unik_half = true }, true)
    --             end
    --         end
    --     end
    -- end
    if G.GAME.modifiers.enable_disposable_in_shop then
        local binning = pseudorandom("unik_shitty_sfff" .. (key_append or "") .. G.GAME.round_resets.ante)
        if card.ability.perishable and not card.ability.eternal and binning > 0.4 then
            card:set_disposable(true)
            card.ability.perishable = nil
        end
    end
    return card
end

function UNIK.add_detrimental_edition_blindside(edition)
    local newedition = edition
    if not edition or edition == nil or edition == 'base' then
        if G.GAME.modifiers.unik_bld_add_fuzzy and not edition then
            local binning = pseudorandom("unik_fuzzy__sfff" .. "" .. G.GAME.round_resets.ante)
            if binning > 0.9 then
                --card:set_edition({ unik_fuzzy = true }, true,nil,true)
                newedition ='e_unik_fuzzy'
            end
                
        end
        if G.GAME.modifiers.unik_bld_add_bloated and not edition then
            if (area == G.shop_jokers) or (area == G.pack_cards) or (area == G.shop_booster) then
                local binning = pseudorandom("unik_bloated__sfff" .. "" .. G.GAME.round_resets.ante)
                if binning > 0.9 then
                    newedition ='e_unik_bloated'
                
                end
            end
        end
    end
    return newedition
    
end

local stakespriter = get_stake_sprite
function get_stake_sprite(_stake, _scale)
    local stake_sprite = stakespriter(_stake, _scale)
    if G.P_CENTER_POOLS['Stake'][_stake].unik_shader then
        stake_sprite.draw = function(_sprite)
        _sprite.ARGS.send_to_shader = _sprite.ARGS.send_to_shader or {}
        _sprite.ARGS.send_to_shader[1] = math.min(_sprite.VT.r*3, 1) + G.TIMERS.REAL/(18) + (_sprite.juice and _sprite.juice.r*20 or 0) + 1
        _sprite.ARGS.send_to_shader[2] = G.TIMERS.REAL

        Sprite.draw_shader(_sprite, 'dissolve')
        Sprite.draw_shader(_sprite, G.P_CENTER_POOLS['Stake'][_stake].unik_shader, nil, _sprite.ARGS.send_to_shader)
        end
    end
    return stake_sprite
end