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

SMODS.DrawStep {
	key = "back_edition",
	order = 5,
    func = function(self)
      if self.area and self.area.config and self.area.config.type and self.area.config.type == 'deck' then
        local currentBack = not self.params.galdur_selector
					and ((Galdur and Galdur.config.use and type(self.params.galdur_back) == "table" and self.params.galdur_back) or type(
						self.params.viewed_back
					) == "table" and self.params.viewed_back or (self.params.viewed_back and G.GAME.viewed_back or G.GAME.selected_back))
				or Back(G.P_CENTERS["b_red"])

        if currentBack.effect.center.edition_back_shader then
            self.children.back:draw_shader(currentBack.effect.center.edition_back_shader, nil, self.ARGS.send_to_shader, true)
        end
      end

    end,
    conditions = { vortex = false, facing = 'back' },
} 