--greed stake???
--lose $1 per hand or discard remaining after round
SMODS.Stake{
    key = 'unik_blindside_greed_deck',

    applied_stakes = {'bld_ghost_deck'},
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}, unlocked_stake = {mod = false}},
    
    modifiers = function()
        G.E_MANAGER:add_event(Event({func = function()
                    G.GAME.modifiers.money_per_hand =  G.GAME.modifiers.money_per_hand or 1
        G.GAME.modifiers.money_per_hand = G.GAME.modifiers.money_per_hand - 1
        G.GAME.modifiers.money_per_discard =  G.GAME.modifiers.money_per_discard or 0
        G.GAME.modifiers.money_per_discard = G.GAME.modifiers.money_per_discard - 1
        return true end }))

    end,

    --colour = ,


    pos = { x = 0, y = 1 },
    atlas = 'unik_stakes',
}