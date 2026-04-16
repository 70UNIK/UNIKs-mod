--polychrome stake????
--Blinds may spawn with Half edition
SMODS.Stake{
    key = 'unik_blindside_polychrome_deck',

    applied_stakes = {'unik_blindside_mountain_deck'},
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}, unlocked_stake = {mod = false}},
    
    modifiers = function()
        G.GAME.modifiers.unik_bld_add_fuzzy = true
    end,

    unik_shader = 'polychrome',
    pos = { x = 2, y = 1 },
    atlas = 'unik_stakes',
}