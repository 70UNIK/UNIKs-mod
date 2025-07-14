--Any cards may be triggering; 
local above = 'gold'
local above2 = 'unik_persimmon'
if (SMODS.Mods["Bunco"] or {}).can_load then
    above = 'bunc_cyan'
    above2 = 'bunc_magenta'
end

print(above)
SMODS.Stake{ 
    key = 'unik_persimmon',

    unlocked_stake = above,
    applied_stakes = {'orange'},
    above_stake = 'orange',
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}},

    modifiers = function()
        G.GAME.modifiers.enable_triggering_in_shop = true
    end,

    colour = HEX('ec5800'),
    shiny = true,
    pos = { x = 1, y = 0 },
    sticker_pos = { x = 1, y = 0 },
    atlas = 'unik_stakes',
    sticker_atlas = 'unik_sticker_stakes'
}
SMODS.Stake:take_ownership('gold', {
    applied_stakes = {above2},
    above_stake = above2,
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}},
})