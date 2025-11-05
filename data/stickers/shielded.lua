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
    if (self.area == G.hand or self.area == G.jokers or self.area == G.consumeables) and self.ability and self.ability.unik_shielded then
        return
    else
        flipper(self)
    end
    
end

local removeHighlight = CardArea.remove_from_highlighted
function CardArea:remove_from_highlighted(card, force)
    if card.ability and card.ability.unik_shielded then
        card.ability.forced_selection = false
    end
    removeHighlight(self,card,force)
end


local editionSetter = Card.set_edition
function Card:set_edition(edition, immediate, silent, delay)
    local old_edition = self.edition and self.edition.key or "e_base"
    editionSetter(self,edition, immediate, silent, delay)
    if (self.area) and self.ability and self.ability.unik_shielded and (not old_edition or (self and self.edition and self.edition.key ~= old_edition) or old_edition == "e_base") then
        -- print(self.edition.key .. " " .. old_edition)
        if (self.edition and isDetrimentalEdition2(self.edition.key)) or isDetrimentalEdition(self) then
            print("Override edition")
            editionSetter(self,old_edition, immediate, silent, delay)
            card_eval_status_text(self, "extra", nil, nil, nil, { message = localize("k_nope_ex"),delay = 0.2,colour = HEX("6bff92")})
        end

    end
end