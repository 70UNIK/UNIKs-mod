--debuffed for 3 rounds, becomes negative after 3 rounds
SMODS.Sticker{
    key="unik_impounded_blindside",
    badge_colour=HEX("ff9947"),
    atlas = 'unik_stickers', 
    pos = { x = 5, y = 1 },
    rate = 0.0,
    no_sticker_sheet = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        G.GAME.unik_impounded_rounds = G.GAME.unik_impounded_rounds or 3
        local tally = G.GAME.unik_impounded_rounds or 3
        if card and card.ability and card.ability.unik_impound_tally then
            tally = card.ability.unik_impound_tally
        end
        
        return { vars = { G.GAME.unik_impounded_rounds or 3, tally  } }
	end,
	-- calculate = function(self, card, context)
	-- 	if context.end_of_round and context.main_eval then -- perishable is calculated seperately across G.playing_cards i believe
    --         card:calculate_impounded()
	-- 	end
	-- end,
}
function Card:calculate_impounded()
    if self.ability.unik_impounded_blindside then
        G.GAME.unik_impounded_rounds = G.GAME.unik_impounded_rounds or 3
        self.ability.unik_impound_tally = self.ability.unik_impound_tally or G.GAME.unik_impounded_rounds
        if self.ability.unik_impounded_blindside and not self.ability.unik_impound_tally then self.ability.unik_impound_tally = G.GAME.unik_impounded_rounds end
        if self.ability.unik_impound_tally <= 1 or self.ability.consumeable then
            self.ability.unik_impound_tally = 0
            self.ability.unik_impounded_blindside = nil
            self:set_debuff(false)
            self.debuff = nil
            self:set_edition({ negative = true })
        else
            self.ability.unik_impound_tally = self.ability.unik_impound_tally - 1
            card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_remaining',vars={self.ability.unik_impound_tally}},colour = HEX("ff9947"), delay = 0.5})
        end
    else
        self.ability.unik_impound_tally = nil
    end
end