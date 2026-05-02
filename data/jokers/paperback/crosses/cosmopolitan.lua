--the next 5 scored crosses will permanently gain +1 retrigger (only applies once per card)
SMODS.Joker {
  key = "unik_cosmopolitan",
  config = {
    extra = {
      suit = "unik_Crosses",
      amount = 1,
      remaining = 5,
      upgrade = "perma_repetitions",
      blacklist = "cosmopolitan_blacklist"
    }
  },
  rarity = 3,
  pos = { x = 0, y = 3 },
  atlas = "unik_rare",
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
		return UNIK.suit_in_deck('unik_Crosses') 
	end,
  calculate = PB_UTIL.suit_drink_calculate,

  loc_vars = PB_UTIL.suit_drink_loc_vars,
    set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("paperback")[1] }, badges)
    end,
    }