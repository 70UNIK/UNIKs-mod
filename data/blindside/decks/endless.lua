--+1 Hand Size, +2 Trinket Slots, Start at Ante 0, Win ante is 10
--Red: Standard
--Yellow: Standard
--Green: X4 The Tree
--Blue: Standard
--Purple: Standard
--Faded: X1 The Prison X1 The Wrench
--Crudes: The Magician X2
SMODS.Back {
    key = 'unik_blindside_endless',
    atlas = 'unik_decks',
    pos = { x = 2, y = 2 },
    config = {
        no_interest = true,
        discards = -1,
        hands = 2,
        extra = {
            blindside = true,
            ante_adder = 4,
        },
        ante_scaling = 0.5,
        joker_slot = 1,
    },
    order = 15,

    loc_vars = function(self, info_queue,card)
    local ante = 6 + self.config.extra.ante_adder
        return {
            vars = {
            self.config.joker_slot+1,1,0,ante,
            }
        }
    end,
    apply = function(self,back)
        BLINDSIDE.set_up_blindside()
        G.E_MANAGER:add_event(Event({func = function()
            BLINDSIDE.set_up_deck({"Green"}, 
            {"m_bld_flip","m_bld_flip","m_unik_blindside_tree", "m_unik_blindside_tree", "m_bld_window", "m_unik_blindside_wrench"}, 
            {'m_unik_blindside_corpo','m_unik_blindside_corpo'})
            local ante = G.GAME.win_ante * 0.75 
            local int_part, frac_part = math.modf(ante)
            local rounded = int_part + (frac_part >= 0.5 and 1 or 0) 
            G.GAME.win_ante = rounded
             G.GAME.win_ante = math.ceil(G.GAME.win_ante + back.effect.config.extra.ante_adder)
            G.E_MANAGER:add_event(Event({
                func = function()
                    ease_ante(-1)
                    G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
                    G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - 1
                    return true
                end
            }))
        return true end }))
        
    end,
    calculate = function(self, back, context) 
        if context.after then
            for i = 1, #G.playing_cards do
                G.playing_cards[i]:set_debuff(false)
            end
        end
    end
}