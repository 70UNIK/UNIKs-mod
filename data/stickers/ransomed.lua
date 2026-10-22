SMODS.Sticker{
    key="unik_ransomed",
    badge_colour=HEX("aa0000"),
    atlas = 'unik_stickers', 
    pos = { x = 5, y = 2 },
    rate = 0.0,
    no_sticker_sheet = true,
    apply = function(self, card, val)
        card.ability[self.key] = val
    end
}
--also a cosmetic sticker