SMODS.Sticker{
    key="unik_claw_mark",
    badge_colour=HEX("512219"),
    atlas = 'unik_stickers', 
    pos = { x = 0, y = 4 },
    rate = 0.0,
    no_sticker_sheet = true,
    loc_vars = function(self, info_queue, card)
        local tally = 2
        if card and card.ability and card.ability.unik_claw_counter then
            tally = card.ability.unik_claw_counter
        end
        
        return { vars = { tally  } }
	end,
}