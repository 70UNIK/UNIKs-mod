--Baseless: If played, will reset foundation.
--This only exists to simplify the functionality of foundation as well as help players know what types of cards NOT to play.
--otherwise does nothing
SMODS.Sticker{
    key="unik_baseless",
    badge_colour=HEX("555555"),
    atlas = 'unik_stickers', 
    pos = { x = 0, y = 2 },
    rate = 0.0,
    loc_vars = function(self, info_queue, card)

        if card.ability.set == "Default" or card.ability.set == "Enhanced" or (self.config and (self.config.type == 'hand' or self.config.type == 'play' or self.config.type == 'discard')) then
            return { key = "unik_baseless_playing_card"}
		else
            return { key = "unik_baseless" }
		end
	end,
}