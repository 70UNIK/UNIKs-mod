--Consumeable exclusive sticker; Immediately uses consumeable when possible (left to right)
--If conditions for use are avaliable and its in consumeable slot, the consumeable will trigger. Lartceps will always have this sticker, so reserving it will not save you. Otherwise is cosmetic
SMODS.Sticker{
    key="unik_triggering",
    badge_colour=HEX("aa0000"),
    atlas = 'unik_stickers', 
    pos = { x = 0, y = 1 },
    rate = 0.0,
    apply = function(self, card, val)
        card.ability[self.key] = val
        card.ability.eternal = true
        card.ability.rental = true
        SMODS.debuff_card(card,true,"unik_impounded")
    end
}