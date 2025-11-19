--+X0.1 requirements when xchips or higher operators are triggered
SMODS.BlindEdition {
    key = 'unik_shining_glitter',
    blind_shader = 'unik_shining_glitter',
    weight = 0.2,
    dollars_mod = 1,
    set_blind = function(self, blind_on_deck)
        G.GAME.unik_shining_glitter_edition_blind = true
         G.E_MANAGER:add_event(Event({trigger = 'immediate',func = function()
            G.GAME.unik_shining_glitter_base = G.GAME.blind.chips
            return true
        end}))
    end,
    loc_vars = function(self, blind_on_deck)
        return {0.1}
    end,
    collection_loc_vars = function(self, blind_on_deck)
        return {0.1}
    end,
    defeat = function(self, blind_on_deck)
        G.GAME.unik_shining_glitter_edition_blind = nil
        
    end,
}