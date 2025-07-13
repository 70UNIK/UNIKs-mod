local handSizeChange = CardArea.change_size
function CardArea:change_size(delta)
    local res = handSizeChange(self,delta)
    G.E_MANAGER:add_event(Event({
        trigger = "after",
        func = function() 
            if G.jokers then
                for _, v in pairs(G.jokers.cards) do
                    if v.ability.name == "j_unik_handcuffs" then
                        if G.hand.config.card_limit < v.ability.extra.min and v.ability.extra.selfDestruct == false then
                            selfDestruction(v,"k_unik_manacle_small",HEX("575757"))
                            v.ability.extra.selfDestruct = true
                        elseif G.hand.config.card_limit > v.ability.extra.max and v.ability.extra.selfDestruct == false then
                            selfDestruction(v,"k_unik_manacle_big",HEX("575757"))
                            v.ability.extra.selfDestruct = true
                        end
                    end
                end
            end
    return true
    end}))
    return res
end