--jokers may be disposable (50% chance to replace perishing)
local nextStake = 'cry_ruby'
if (SMODS.Mods["Buffoonery"] or {}).can_load then
    nextStake = 'buf_palladium'
end
SMODS.Stake{ 
    key = 'unik_shitty',

    unlocked_stake =  nextStake ,
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

if not (SMODS.Mods["Buffoonery"] or {}).can_load then
    SMODS.Stake:take_ownership('stake_cry_ruby', {
        applied_stakes = { "unik_shitty" },
        above_stake = "unik_shitty",
        prefix_config = { above_stake = {mod = false}, applied_stakes = {mod = false} },
    })
end