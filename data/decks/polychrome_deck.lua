--Start with a special spectral ("Prism"), that guarantees a polychrome card. This card can never spawn anywhere else.
--also start with deja vu
  SMODS.Back {
    key = 'unik_polychrome',
    atlas = 'unik_decks',
    pos = { x = 1, y = 0 },
    config = {
      consumables = {
        'c_unik_prism',
        'c_deja_vu',
      }
    },
    order = 15,
    loc_vars = function(self, info_queue)
      return {
        vars = {
          localize { type = 'name_text', key = 'c_unik_prism', set = 'Spectral' },
          localize { type = 'name_text', key = 'c_deja_vu', set = 'Spectral' },
        }
      }
    end,
    edition_back_shader = 'polychrome'
  }