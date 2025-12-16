SMODS.Back {
    key = 'unik_mountain',
    atlas = 'unik_decks',
    pos = { x = 2, y = 0 },
    config = {
      consumables = {
        'c_unik_everest',
        'c_unik_everest',
      }
    },
    order = 15,

    loc_vars = function(self, info_queue)
      return {
        vars = {
          localize { type = 'name_text', key = 'c_unik_everest', set = 'unik_summit' },
        }
      }
    end,
    apply = function(self, back)
        G.GAME.unik_summit_rate = 2
    end
}