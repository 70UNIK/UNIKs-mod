--cards have a 1 in 5 of being destroyed before play
SMODS.BlindEdition {
    key = 'unik_bloated',
    blind_shader = 'unik_bloated',
    weight = 0.2,
    dollars_mod = 3,
    unik_before_play = function(self)
        if G.hand.highlighted and G.hand.highlighted[#G.hand.highlighted] then
            if not G.hand.highlighted[#G.hand.highlighted].ability.eternal then
                G.hand.highlighted[#G.hand.highlighted]:bloated_pop()
                G.GAME.blind:wiggle()
                SMODS.calculate_context({ remove_playing_cards = true, removed = G.hand.highlighted[#G.hand.highlighted] })
                G.hand:remove_from_highlighted(G.hand.highlighted[#G.hand.highlighted])
            end
        end
    end,
    defeat = function(self, blind_on_deck)

    end,
}