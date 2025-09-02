SMODS.Suit{ -- Halberds
    key = 'abstract',
    card_key = 'ABS',
    hidden = true,
    backup_suit = 'Spades',

    lc_ui_atlas = 'enhancement_suits',
    hc_ui_atlas = 'enhancement_suits_HC',
    pos = { x = 1, y = 0 },
    ui_pos = { x = 1, y = 0 },

    lc_colour = G.C.BLACK,
    hc_colour = G.C.BLACK,

    in_pool = function(self, args)
        return true
    end
}
SMODS.Rank{
    key = 'abstract',
    card_key = 'abs',
    pos = { x = 2 },
    nominal = 0,
    backup_rank = "2",
    face = false,
    hidden = true,
    in_pool = function(self, args)
        return true
    end,
}