--cards have a 1 in 5 of being destroyed before play
SMODS.BlindEdition {
    key = 'unik_bloated',
    blind_shader = 'unik_bloated',
    weight = 0.2,
    dollars_mod = 3,
    loc_vars = function(self, blind_on_deck)
        return {"" .. ((Cryptid.safe_get(G.GAME, "probabilities", "normal") or 1) * 1),6}
    end,
    collection_loc_vars = function(self, blind_on_deck)
        return {"" .. ((Cryptid.safe_get(G.GAME, "probabilities", "normal") or 1) * 1),6}
    end,
    unik_before_play = function(self)
        for i,v in pairs(G.hand.highlighted) do
            if not v.ability.eternal and (pseudorandom(pseudoseed("unik_bloated_edition_pop_chance")) < ((G.GAME.probabilities.normal * 1) / 6)) then
                v:bloated_pop()
                G.GAME.blind:wiggle()
                G.hand:remove_from_highlighted(v)
                SMODS.calculate_context({ remove_playing_cards = true, removed = v })
            end
        end
    end,
    defeat = function(self, blind_on_deck)

    end,
}