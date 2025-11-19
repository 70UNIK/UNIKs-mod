--+4 joker slots, final boss blinds appear every 4 antes, must win at ante 16
SMODS.Back {
    key = 'unik_endless',
    atlas = 'unik_decks',
    pos = { x = 0, y = 1 },
    config = {joker_slot = 3,extra = {ante_multiplier = 1.5,finisher_multiplier = 2}},
    order = 15,

    loc_vars = function(self, info_queue,card)
    local ante = 8 * self.config.extra.ante_multiplier
        return {
            vars = {
            self.config.joker_slot,ante,self.config.extra.finisher_multiplier
            }
        }
    end,
    apply = function(self, back)
        G.GAME.unik_vice_squeeze = G.GAME.unik_vice_squeeze * back.effect.config.extra.finisher_multiplier
        G.GAME.win_ante = math.ceil(G.GAME.win_ante * back.effect.config.extra.ante_multiplier)
    end
}