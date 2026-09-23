--polychrome stake????
--Blinds may spawn with Half edition
SMODS.Stake{
    key = 'unik_blindside_steel_deck',

    applied_stakes = {'unik_blindside_shining_glitter_deck'},
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}, unlocked_stake = {mod = false}},
    
    modifiers = function()
        G.GAME.modifiers.unik_bld_boss_everywhere_big_small = true
    end,
    blindside_stake = true,
    pos = { x = 1, y = 2 },
    atlas = 'unik_stakes',
}

