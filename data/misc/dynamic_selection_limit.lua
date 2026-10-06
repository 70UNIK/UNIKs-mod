function UNIK.get_bonus_selection_limit(args)
    local summation = 0
    if UNIK.hasBlindside() then
        for i,v in pairs(G.hand.cards) do
            if v.config.center.key == 'm_unik_blindside_legendary_sapphire_stamp' then
                summation = summation + v.ability.extra.selection_limit
            end
        end
    end
    return summation
end