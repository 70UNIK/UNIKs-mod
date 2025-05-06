SMODS.Sticker{
    key="unik_impounded",
    badge_colour=HEX("aa0000"),
    atlas = 'unik_stickers', 
    pos = { x = 0, y = 1 },
    rate = 0.0,
    no_sticker_sheet = true,
    apply = function(self, card, val)
        card.ability[self.key] = val
        card.ability.eternal = true
        card.ability.rental = true
        SMODS.debuff_card(card,true,"unik_impounded")
    end
}
-- This is a consmetic sticker, as it relies on specific functionality 