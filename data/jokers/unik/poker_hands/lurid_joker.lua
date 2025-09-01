SMODS.Joker {
    key = "unik_lurid_joker",
    config = {extra ={
      t_chips = 80,
      type = 'unik_spectrum'
    }},
    rarity = 1,
    pos = { x = 0, y = 2 },
    effect = "Cry Type Chips",
    atlas = "unik_poker_hand_shit",
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = true,
    loc_vars = function(self, info_queue, card)
      return {
        vars = {
          card.ability.extra.t_chips,
          localize(card.ability.extra.type, 'poker_hands')
        }
      }
    end,
    calculate = function(self, card, context)
		if
			(context.joker_main and context.poker_hands and next(context.poker_hands[card.ability.extra.type]))
			or context.forcetrigger
		then
			return {
				colour = G.C.BLUE,
				chips = lenient_bignum(card.ability.extra.t_chips),
			}
		end
	end,
    in_pool = function(self)
		if UNIK.spectrum_played() then
			return true
		end
		return false
	end,
}