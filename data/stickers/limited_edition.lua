--Strips edition after 5 rounds.
SMODS.Sticker{
    key="unik_limited_edition",
    badge_colour=HEX("9834eb"),
    atlas = 'unik_stickers', 
    pos = { x = 0, y = 2 },
    rate = 0.0,
    no_sticker_sheet = true,
    loc_vars = function(self, info_queue, card)
        G.GAME.unik_limited_edition_rounds = G.GAME.unik_limited_edition_rounds or 5
        local tally = G.GAME.unik_limited_edition_rounds or 5
        if card and card.ability and card.ability.limited_edition_tally then
            tally = card.ability.limited_edition_tally
        end
        
        return { vars = { G.GAME.unik_limited_edition_rounds or 5, tally  } }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval then -- perishable is calculated seperately across G.playing_cards i believe
			card:calculate_limited_edition()
		end
	end,
}
function Card:calculate_limited_edition()
    if not self.edition then
        self.ability.unik_limited_edition = nil;
        self.ability.limited_edition_tally = nil;
    else
        if self.ability.unik_limited_edition and not self.ability.limited_edition_tally then self.ability.limited_edition_tally = G.GAME.unik_limited_edition_rounds end
        if self.ability.unik_limited_edition then
            if self.ability.limited_edition_tally == 1 then
                self.ability.limited_edition_tally = 0
                self:set_edition(nil, true);
                self.ability.unik_limited_edition = nil;
                self.ability.limited_edition_tally = nil;
                card_eval_status_text(self, "jokers", nil, nil, nil, {
                    message = localize("k_unik_orta_hammer_stripped"),
                    delay = 0.25 ,
                    colour = HEX("9834eb"),
                })
            else
                self.ability.limited_edition_tally =  self.ability.limited_edition_tally or G.GAME.unik_limited_edition_rounds 
                self.ability.limited_edition_tally = self.ability.limited_edition_tally - 1
                card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_remaining',vars={self.ability.limited_edition_tally}},colour = HEX("9834eb"), delay = 0.45})
            end
        end
        
    end
    
end