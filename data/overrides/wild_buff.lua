--wilds are now immune to debuffs


local debuffCard = Card.set_debuff
function Card:set_debuff(should_debuff)
    if (self.ability and self.ability.extra.shielded or SMODS.has_enhancement(self,'m_wild')) and not self.ability.unik_ultradebuffed  then
        if self.debuff then
            self.debuff = false
            card_eval_status_text(self, "extra", nil, nil, nil, { message = localize("k_nope_ex"),delay = 0.2})
            if self.area == G.jokers then self:add_to_deck(true) end
        end
        return
    else
        debuffCard(self,should_debuff)
    end
end

local debuffer = SMODS.debuff_card
function SMODS.debuff_card(card, debuff, source)
    if (card.ability and card.ability.extra.shielded or SMODS.has_enhancement(card,'m_wild')) and not card.ability.unik_ultradebuffed   then
        if card.debuff then
            card.debuff = false
            card_eval_status_text(self, "extra", nil, nil, nil, { message = localize("k_nope_ex"),delay = 0.2})
            if card.area == G.jokers then card:add_to_deck(true) end
        end
        return
    else
        debuffer(card,debuff,source)
    end
end
