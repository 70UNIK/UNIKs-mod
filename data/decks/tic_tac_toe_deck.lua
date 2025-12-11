--start with 13 spades, 13 hearts, 13 noughts and 13 crosses
SMODS.Back {
    key = 'unik_tic_tac_toe',
    atlas = 'unik_decks',
    pos = { x = 2, y = 1 },
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
G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    if v.base.suit == 'Clubs' then 
                        v:change_suit('unik_Crosses')
                    end
                    if v.base.suit == 'Diamonds' then 
                        v:change_suit('unik_Noughts')
                    end
                end
            return true
            end
        }))
    end,
}