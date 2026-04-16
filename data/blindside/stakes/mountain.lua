--mountain stake????
--add 1 random crude blind to deck when Boss+ Joker is selected
SMODS.Stake{
    key = 'unik_blindside_mountain_deck',

    applied_stakes = {'unik_blindside_tic_tac_toe_deck'},
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}, unlocked_stake = {mod = false}},
    
    modifiers = function()
        
    end,
    calculate = function(self, context) 
        if  context.setting_blind and context.blind and context.blind.boss then
            local cardsadded = {}
             G.E_MANAGER:add_event(Event({
                delay = 1,
                trigger = 'before',
                    func = function()
                        local args = {}
                        args.guaranteed = true
                        args.options = G.P_CENTER_POOLS.bld_obj_blindcard_generate
                        args.cursed = true
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
                    SMODS.calculate_context({ playing_card_added = true, cards = { cardsadded } })
                        
                    return true
                end
            }))
        end
    end,

    --colour = ,


    pos = { x = 3, y = 1 },
    atlas = 'unik_stakes',
}