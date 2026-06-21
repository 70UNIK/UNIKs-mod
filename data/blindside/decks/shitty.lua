

--Earn $3 for each blind destroyed
--Red: 2 The Bloon + 2 The Hunter
--Yellow: 2 The Trade
--Green: Standard
--Blue: Standard
--Purple: Standard
--Detrimental: X2 The AI
SMODS.Back {

    key = 'unik_blindside_shitty',
    atlas = 'unik_decks',
    pos = { x = 0, y = 2 },
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
        extra_hand_bonus = 0,
    },
    order = 15,

    loc_vars = function(self, info_queue,card)
        return {
            vars = {
            3
            }
        }
    end,
    apply = function(self,back)
        BLINDSIDE.set_up_blindside()
        G.E_MANAGER:add_event(Event({func = function()
            BLINDSIDE.set_up_deck({"Red","Yellow"}, 
            {"m_unik_blindside_bloon","m_unik_blindside_bloon","m_bld_fire","m_bld_fire","m_unik_blindside_hunter", "m_unik_blindside_hunter", "m_unik_blindside_trade","m_unik_blindside_trade"}, 
            {'m_unik_blindside_ai_brainrot','m_unik_blindside_ai_brainrot'})
        return true end }))
        
    end,
    calculate = function(self, back, context) 
        if context.after then
            for i = 1, #G.playing_cards do
                G.playing_cards[i]:set_debuff(false)
            end
        end
        if context.unik_blind_destroyed then
            ease_dollars(3)
            delay(0.3)
        end
    end,
    
}