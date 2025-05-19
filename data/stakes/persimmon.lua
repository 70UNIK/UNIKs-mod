--Any cards may be triggering; 
SMODS.Stake{ 
    key = 'unik_persimmon',

    unlocked_stake = 'gold',
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
    applied_stakes = {'unik_persimmon'},
    above_stake = 'unik_persimmon'
})