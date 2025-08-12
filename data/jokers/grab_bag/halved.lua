--The halved. X4 mult if 3 or less cards are played.
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_halved',
    atlas = 'unik_grab_bag_jokers',
    pos = { x = 4, y = 0 },
    rarity = "gb_boss",
	-- Modest
    config = { extra = { Xmult = 4}, immutable = {card_limit = 3}},
    cost = 7,
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	demicoloncompat = true,
    discovered = true,
    unlocked = true,
    pixel_size = { w = 71, h = 46 },
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.Xmult, center.ability.immutable.card_limit} }
	end,
    calculate = function(self, card, context)
		if context.joker_main then
			if #context.full_hand <= card.ability.immutable.card_limit then
                return {
                    x_mult = card.ability.extra.Xmult,
                    colour = G.C.MULT,
                }
			end
		end
		if context.forcetrigger then
			return {
                x_mult = card.ability.extra.Xmult,
                colour = G.C.MULT,
            }
		end
	end,
    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_unik_halved")
    end,
    set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("GrabBag")[1] }, badges)
    end,
}