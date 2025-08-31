SMODS.Joker {
	key = "unik_the_dynasty",
    atlas = "unik_poker_hand_shit",
	pos = { x = 0, y = 3 },
	config = {
		extra = {
			Xmult = 5,
			type = "unik_spectrum",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.Xmult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.Xmult) > to_big(1)) then
			if context.poker_hands ~= nil and next(context.poker_hands[card.ability.extra.type]) then
				return {
				colour = G.C.RED,
				x_mult = lenient_bignum(card.ability.extra.Xmult),
			}
			end
		end
		if context.forcetrigger then
			return {
				colour = G.C.RED,
				x_mult = lenient_bignum(card.ability.extra.Xmult),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["unik_spectrum"].played > 0 then
			return true
		end
		return false
	end,
}