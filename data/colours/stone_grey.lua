  SMODS.Consumable({
    object_type = "Consumable",
    set = "Colour",
    key = "stone_grey",
    pos = { x = 2, y = 0 },
    config = {
      val = 0,
      partial_rounds = 0,
      upgrade_rounds = 50,
    },
    cost = 4,
    hidden = true,
    atlas = "unik_colours",
    unlocked = true,
    discovered = true,
    display_size = { w = 71, h = 87 },
    pixel_size = { w = 71, h = 87 },
    can_use = function(self, card)
        return card.ability.val >= 1 and #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers
    end,
    use = function(self, card, area, copier)
        if card.ability.val >= 1 then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('timpani')
                local card2 = create_card("Joker", G.jokers, nil, "unik_ancient", nil, nil, nil, "unik_foundation_color")
                card2:add_to_deck()
                G.jokers:emplace(card2)
                card2:start_materialize()
                card:juice_up(0.3, 0.5)
            return true end }))
        end
    end,
    loc_vars = function(self, info_queue, card)
        local part = card.ability.partial_rounds
        if card.ability.val >= 1 then
            part = 0
        end
      local val, max = progressbar(part, card.ability.upgrade_rounds)

      return { vars = {math.min(card.ability.val,1), val, max, card.ability.upgrade_rounds} }
    end,
    set_badges = function (self, card, badges)
      SMODS.create_mod_badges({ mod = MoreFluff }, badges)
    end,
  })
  