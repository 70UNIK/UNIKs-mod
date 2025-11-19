--If more than 3 cards are played, debuff 1 random played card
SMODS.BlindEdition {
    key = 'unik_half',
    blind_shader = 'unik_halfjoker',
    weight = 0.2,
    dollars_mod = 1,
    loc_vars = function(self, blind_on_deck)
        return {2,3}
    end,
    collection_loc_vars = function(self, blind_on_deck)
        return {2,3}
    end,
    press_play = function(self, blind_on_deck)
        if (G.hand and G.hand.highlighted and #G.hand.highlighted > 3) or (G.play and G.play.cards and #G.play.cards > 3) then
            local triggered = false
            for g = 1, 1 do

                local eligible_cards2 = {}
                for i,v in pairs(G.hand.highlighted) do
                    if not v.ability.selected_for_debuff then
                        eligible_cards2[#eligible_cards2 + 1] = v
                    end
                end
                if #eligible_cards2 > 0 then
                    triggered = true
                    local rip2 = pseudorandom_element(eligible_cards2, pseudoseed("unik_half_joker_maker2"))
                    rip2:set_debuff(true)
                    rip2.ability.selected_for_debuff = true
                end
                
            end
            if triggered then
                G.GAME.blind.triggered = true
                G.GAME.blind:wiggle()
            end
            --reset
            for i,v in pairs(G.hand.highlighted) do
                if v.ability.selected_for_debuff then
                    v.ability.selected_for_debuff = nil
                end
            end
        end
    end,
    defeat = function(self, blind_on_deck)

    end,
}
