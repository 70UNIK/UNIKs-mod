SMODS.Joker {
  key = "unik_midori_sour",
  config = {
    extra = {
      suit = "unik_Noughts",
      amount = 1,
      remaining = 5,
      upgrade = "perma_rescores",
      blacklist = "midori_sour_blacklist"
    }
  },
  rarity = 3,
  pos = { x = 11, y = 3 },
  atlas = "unik_normal_jokers",
  cost = 8,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = false,
  perishable_compat = false,
  soul_pos = nil,
  pools = {
    Food = true
  },
  paperback = {
    suit_drink = true
  },

  in_pool = function(self)
		return UNIK.suit_in_deck('unik_Noughts') 
	end,
  calculate = PB_UTIL.suit_drink_calculate,

  loc_vars = function(self,info_queue,card)
    info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
     return {
        vars = {
          card.ability.extra.remaining,
          localize(card.ability.extra.suit, 'suits_plural'),
          card.ability.extra.amount,
          colours = { G.C.SUITS[card.ability.extra.suit] }
        },
    }
  end,
    set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("paperback")[1] }, badges)
    end,
    }
--the next 5 scored noughts will permanently gain +1 rescore (only applies once per card), rare