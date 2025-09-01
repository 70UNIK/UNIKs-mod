--X1.5 CHIPS
SMODS.Shader({
    key = "shining_glitter",
    path = "shining_glitter.fs",
})
--https://pixabay.com/sound-effects/search/glitter/
SMODS.Sound({
	key = "glitter",
	path = "glitter.ogg",
})
SMODS.Edition({
	key = "shining_glitter",
	order = 66666,
	weight = 3, --rare as polychrome
	shader = "shining_glitter", 
	extra_cost = 4, 
    apply_to_float = true,
    disable_base_shader = true,
    no_shadow = true,
	sound = {
		sound = "unik_glitter",
		per = 1,
		vol = 1,
	},
    config = {
		x_chips = 1.5, trigger = nil
	},
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
    loc_vars = function(self, info_queue, card)
		return { vars = { card and card.edition and card.edition.x_chips or self.config.x_chips } }
	end,
    in_shop = true,
    badge_colour = G.C.DARK_EDITION,
    calculate = function(self, card, context)
		if
			(
				context.edition -- for when on jonklers
				and context.cardarea == G.jokers -- checks if should trigger
				and card.config.trigger -- fixes double trigger
			) or (
				context.main_scoring -- for when on playing cards
				and context.cardarea == G.play
			)
		then
			return { x_chips = card and card.edition and card.edition.x_chips or self.config.x_chips } -- updated value
		end
		if context.joker_main then
			card.config.trigger = true -- context.edition triggers twice, this makes it only trigger once (only for jonklers)
		end

		if context.after then
			card.config.trigger = nil
		end
	end,
})