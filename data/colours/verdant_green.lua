--create a negative awakening every 8 rounds. Supercedes stone grey.
SMODS.Consumable({
    object_type = "Consumable",
    set = "Colour",
    key = "lily_green",
    pos = { x = 1, y = 1 },
    config = {
      val = 0,
      partial_rounds = 0,
      upgrade_rounds = 7,
    },
    hidden = true,
    cost = 4,
    atlas = "unik_colours",
    unlocked = true,
    discovered = true,
    display_size = { w = 71, h = 87 },
    pixel_size = { w = 71, h = 87 },
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
      for i = 1, card.ability.val do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
          play_sound('timpani')
          local n_card = create_card(nil,G.consumeables, nil, nil, nil, nil, 'c_unik_gateway', '666666666666666666')
          n_card:add_to_deck()
          n_card:set_edition({negative = true}, true)
          G.consumeables:emplace(n_card)
          card:juice_up(0.3, 0.5)
          return true end }))
      end
      delay(0.6)
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Spectral", key = "c_unik_gateway", vars = {3} }
        local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
        return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
    end,
    set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = MoreFluff }, badges)
    end,
})