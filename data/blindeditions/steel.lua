--Each Held card increases blind size by +0.05x
SMODS.BlindEdition {
    key = 'unik_steel',
    blind_shader = 'unik_steel',
    weight = 0.2,
    dollars_mod = 3,
    set_blind = function(self, blind_on_deck)
            G.E_MANAGER:add_event(Event({trigger = 'immediate',func = function()
                G.GAME.unik_steel_base_size = G.GAME.blind.chips
                return true
            end}))
    end,
    loc_vars = function(self, blind_on_deck)
        return {0.05}
    end,
    collection_loc_vars = function(self, blind_on_deck)
        return {0.05}
    end,
    press_play = function(self, blind_on_deck)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
        for i = 1, #G.hand.cards do
            G.E_MANAGER:add_event(Event({delay = 0.1, func = function() 
                G.hand.cards[i]:juice_up()
                G.GAME.blind:wiggle()
                return true end })) 
            G.E_MANAGER:add_event(Event({func = function()
                G.GAME.blind.chips = G.GAME.blind.chips + G.GAME.unik_steel_base_size * 0.05
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                G.HUD_blind:recalculate(true)
                G.hand_text_area.blind_chips:juice_up()
                play_sound('chips2')
            return true end }))
        end
        return true end })) 
    end,
    defeat = function(self, blind_on_deck)

    end,
}