--tic tac toe stake?????
--Double the rate of spawning Legendary Jokers
SMODS.Stake{
    key = 'unik_blindside_tic_tac_toe_deck',

    applied_stakes = {'unik_blindside_endless_deck'},
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}, unlocked_stake = {mod = false}},
    
    modifiers = function()
        G.GAME.unik_vice_squeeze = G.GAME.unik_vice_squeeze * 2
    end,

    --colour = ,


    pos = { x = 0, y = 2 },
    atlas = 'unik_stakes',
}