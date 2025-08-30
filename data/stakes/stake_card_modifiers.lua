local createHook = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
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
    if G.GAME.modifiers.enable_disposable_in_shop then
        local binning = pseudorandom("unik_shitty_sfff" .. (key_append or "") .. G.GAME.round_resets.ante)
        if card.ability.perishable and not card.ability.eternal and binning > 0.4 then
            card:set_disposable(true)
            card.ability.perishable = nil
        end
    end
    return card
end