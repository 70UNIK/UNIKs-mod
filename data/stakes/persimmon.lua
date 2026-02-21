local prev_stake = 'orange'
if next(SMODS.find_mod("Bunco")) then
    prev_stake = 'bunc_magenta'
end
SMODS.Stake{ 
    key = 'unik_persimmon',
    order = 1,
    applied_stakes = {'unik_shitty'},
    above_stake = 'unik_shitty',
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