

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
            {"m_unik_blindside_bloon","m_unik_blindside_bloon","m_unik_blindside_bloon","m_unik_blindside_hunter", "m_unik_blindside_hunter", "m_unik_blindside_trade","m_unik_blindside_trade","m_unik_blindside_trade"}, 
            {'m_unik_blindside_nut','m_unik_blindside_nut'})
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
        if  context.setting_blind and context.blind then
            local cardsadded = {}
             G.E_MANAGER:add_event(Event({
                delay = 1,
                trigger = 'before',
                    func = function()
                        local args = {}
                        args.guaranteed = true
                        args.options = G.P_CENTER_POOLS.bld_obj_blindcard_generate
                        args.basic = true
                        local cardtype = BLINDSIDE.poll_enhancement(args)
                        
                        local cardr = SMODS.create_card { set = "Base", enhancement = cardtype, area = G.hand }
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        cardr.playing_card = G.playing_card
                        table.insert(G.playing_cards, cardr)
                        cardr:start_materialize()
                        G.deck:emplace(cardr)
                        cardsadded[#cardsadded+1] = cardr
                        return true
                    end
                }))
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.calculate_context({ playing_card_added = true, cards = cardsadded })
                        
                    return true
                end
            }))
        end
    end,
    
}