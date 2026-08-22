--Create a max tag when joker is selected
--Red: Standard
--Yellow: X2 The Ore, X2 The Gun
--Green: Standard
--Blue: Standard
--Purple: Standard
--Faded: THe Cliff X2
--Crudes: The Impatience X2
SMODS.Back {
    key = 'unik_blindside_persimmon',
    atlas = 'unik_decks',
    pos = { x = 1, y = 2 },
    config = {
        no_interest = true,
        hand_size = -1,
        discards = -1,
        hands = 2,
        extra = {
            blindside = true
        },
        ante_scaling = 0.5,
        joker_slot = -1,
    },
    order = 15,

    loc_vars = function(self, info_queue,card)

    end,
    apply = function(self,back)
        BLINDSIDE.set_up_blindside()
        G.E_MANAGER:add_event(Event({func = function()
            BLINDSIDE.set_up_deck({"Yellow"}, 
            {"m_unik_blindside_gun", "m_unik_blindside_gun", "m_unik_blindside_cliff","m_unik_blindside_cliff", "m_unik_blindside_cliff"}, 
            {'m_unik_blindside_impatience','m_unik_blindside_impatience'})
            local ante = G.GAME.win_ante * 0.75 
            local int_part, frac_part = math.modf(ante)
            local rounded = int_part + (frac_part >= 0.5 and 1 or 0) 
            G.GAME.win_ante = rounded
        return true end }))
        
    end,
    calculate = function(self, back, context) 
        if context.after then
            for i = 1, #G.playing_cards do
                G.playing_cards[i]:set_debuff(false)
            end
        end
        if context.setting_blind then
            add_tag(Tag('tag_bld_maxim'))
            delay(0.3)
        end
    end,
    edition_back_shader = 'voucher'
}