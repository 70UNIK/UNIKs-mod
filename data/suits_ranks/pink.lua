SMODS.Atlas({key = 'enhancement_suits', path = 'enhancement_suits.png', px = 18, py = 18})
SMODS.Atlas({key = 'enhancement_suits_HC', path = 'enhancement_suits_HC.png', px = 18, py = 18})

SMODS.Suit{ -- Halberds
    key = 'pink',
    card_key = 'PINK',
    hidden = true,
    backup_suit = 'Hearts',

    lc_ui_atlas = 'enhancement_suits',
    hc_ui_atlas = 'enhancement_suits_HC',
    pos = { x = 0, y = 0 },
    ui_pos = { x = 0, y = 0 },

    lc_colour = G.C.UNIK_UNIK,
    hc_colour = G.C.UNIK_UNIK,

    in_pool = function(self, args)
        return true
    end
}