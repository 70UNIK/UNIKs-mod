--Start with a foundry and a deja-vu
  SMODS.Back {
    key = 'unik_steel',
    atlas = 'unik_decks',
    pos = { x = 0, y = 0 },
    config = {
      consumables = {
        'c_unik_foundry',
        'c_deja_vu',
      }
    },
    order = 15,

    loc_vars = function(self, info_queue)
      return {
        vars = {
          localize { type = 'name_text', key = 'c_unik_foundry', set = 'Spectral' },
          localize { type = 'name_text', key = 'c_deja_vu', set = 'Spectral' },
        }
      }
    end,
    edition_back_shader = 'unik_steel'
  }