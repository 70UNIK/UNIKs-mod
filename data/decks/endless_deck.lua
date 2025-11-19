--+4 joker slots, final boss blinds appear every 4 antes, must win at ante 16
SMODS.Back {
    key = 'unik_endless',
    atlas = 'unik_decks',
    pos = { x = 0, y = 1 },
    config = {starting_ante = 0, joker_slot = 4,extra = {ante_multiplier = 2,finisher_multiplier = 2}},
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
        G.E_MANAGER:add_event(Event({trigger = 'before',func = function() 
			ease_ante(back.effect.config.starting_ante - G.GAME.round_resets.ante)
		return true end })) 
        G.GAME.round_resets.ante = back.effect.config.starting_ante
		G.GAME.round_resets.blind_ante = back.effect.config.starting_ante
    end
}