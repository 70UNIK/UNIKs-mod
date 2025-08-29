--+X0.2 blind size per joker owned, x1.5 blind size for each joker over maximum slots
SMODS.BlindEdition {
    key = 'unik_positive',
    blind_shader = 'unik_positive',
    weight = 0.2,
    dollars_mod = 3,
    set_blind = function(self, blind_on_deck)
        if G.jokers then
            G.GAME.unik_positive_base_size = G.GAME.blind.chips
            local diff = #G.jokers.cards - G.jokers.config.card_limit 
            G.GAME.blind.chips = G.GAME.blind.chips + #G.jokers.cards * 0.2 * G.GAME.unik_positive_base_size
            if diff > 0 then
                for i = 1, diff do
                    G.GAME.blind.chips = G.GAME.blind.chips * 1.5
                end
            end
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            G.HUD_blind:recalculate(true)
        end
    end,
    loc_vars = function(self, blind_on_deck)
        return {0.2,1.5}
    end,
    collection_loc_vars = function(self, blind_on_deck)
        return {0.2,1.5}
    end,
}