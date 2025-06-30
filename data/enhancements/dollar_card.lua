SMODS.Enhancement {
	atlas = 'unik_enhancements',
	pos = {x = 1, y = 0},
	key = 'unik_dollar',
    config = { extra = { money = 2} },
    weight = 0,
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.money}
        }
    end,
	calculate = function(self, card, context, effect)
		if context.cardarea == G.play and context.main_scoring then
            return {
                p_dollars = card.ability.extra.money,
                card = card,
            }
		end
	end,
    draw = function(self, card, layer)
      local notilt = nil
      if card.area and card.area.config.type == "deck" then
        notilt = true
      end
      -- card.children.center:draw_shader(
      --   "negative",
      --   nil,
      --   card.ARGS.send_to_shader,
      --   notilt,
      --   card.children.center
      -- )
      card.children.center:draw_shader(
        "voucher",
        nil,
        card.ARGS.send_to_shader,
        notilt,
        card.children.center
      )
    end,
}