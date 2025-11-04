--cannot be debuffed, flipped, forcibly selected or recieve detrimental stickers (except eternal) or editions
--is overriden by ultradebuffed

SMODS.Sticker{
    key="unik_shielded",
    badge_colour=HEX("6bff92"),
    atlas = 'unik_stickers', 
    pos = { x = 1, y = 2 },
    rate = 0.0,
    no_sticker_sheet = true,
}

local flipper = Card.flip
function Card:flip()
    if (self.area == G.hand or self.area == G.jokers or self.area == G.consumeables) and self.ability and self.ability.unik_shielded and (not self.edition or (self.edition and not self.edition.cry_double_sided)) then
        return
    end
    flipper(self)
end

local removeHighlight = CardArea.remove_from_highlighted
function CardArea:remove_from_highlighted(card, force)
    if card.ability and card.ability.unik_shielded then
        card.ability.forced_selection = false
    end
    removeHighlight(self,card,force)
end