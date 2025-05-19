--jokers may be disposable (50% chance to replace perishing)
SMODS.Stake{ 
    key = 'unik_shitty',

    unlocked_stake = 'cry_pink',
    applied_stakes = {'gold'},
    above_stake = 'gold',
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}},

    modifiers = function()
        G.GAME.modifiers.enable_disposable_in_shop = true
    end,

    colour = HEX('4e4d25'),

    pos = { x = 0, y = 0 },
    sticker_pos = { x = 0, y = 0 },
    atlas = 'unik_stakes',
    sticker_atlas = 'unik_sticker_stakes'
}

SMODS.Stake:take_ownership('cry_pink', {
    applied_stakes = { "unik_shitty" },
    above_stake = "unik_shitty",
    prefix_config = { above_stake = {mod = false}, applied_stakes = {mod = false} },
})