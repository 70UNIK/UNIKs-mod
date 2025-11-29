--start with 13 spades, 13 hearts, 13 noughts and 13 crosses
SMODS.Back {
    key = 'unik_tic_tac_toe',
    atlas = 'placeholders',
    pos = { x = 4, y = 2 },
    order = 15,

    loc_vars = function(self, info_queue, card)
      return {
        vars = {
            localize("Spades","suits_plural"),localize("Hearts","suits_plural"),localize("unik_Noughts","suits_plural"),localize("unik_Crosses","suits_plural")
        }
      }
    end,
    has_noughts = true,
    has_crosses = true,
    apply = function(self)
        G.E_MANAGER:add_event(Event({func = function()
			local keys_to_remove = {}
			for k, v in pairs(G.playing_cards) do
				if v.base.suit == 'Clubs' or v.base.suit == 'Diamonds' then
					table.insert(keys_to_remove, v)
				end
			end
			for i = 1, #keys_to_remove do
				keys_to_remove[i]:remove()
			end
			G.GAME.starting_deck_size = #G.playing_cards
        return true end }))
    end,
}