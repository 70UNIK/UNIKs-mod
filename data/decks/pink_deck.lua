SMODS.Back {
    key = 'unik_pink_deck',
    atlas = 'unik_decks',
    pos = { x = 4, y = 3 },
    order = 15,
    config = {unik_joker_frequency = 3},

    loc_vars = function(self, info_queue,card)
        return {
            vars = {
            self.config.unik_joker_frequency
            }
        }
    end,
    apply = function(self, back)
        G.GAME.unik_joker_frequency = G.GAME.unik_joker_frequency or 1
        G.GAME.unik_joker_frequency = G.GAME.unik_joker_frequency * 3
        print("rate: X" .. G.GAME.unik_joker_frequency)
    end
}
function UNIK.get_unik_joker_frequency()
    G.GAME.unik_joker_frequency = G.GAME.unik_joker_frequency or 1
    local val = G.GAME.unik_joker_frequency
    return val
end