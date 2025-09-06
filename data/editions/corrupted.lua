--NEW! Corrupted:
---10 Mult, X0.5 Mult

SMODS.Shader({
    key = "corrupted",
    path = "corrupted.fs",
})
SMODS.Sound({
	key = "pibby_glitch",
	path = "pibby_glitch.ogg",
})
SMODS.Edition({
	key = "corrupted",
	order = 66666,
	weight = 0, -- should not appear normally in stores as its a detrimental one
	shader = "corrupted", --placeholder for now until I program one. It should have negative shine, but with a polychromesque shine from normal to overlay to a bit of negative, just to show its the opposite
	extra_cost = -5, --Its a detrimental edition, hence lower cost
    apply_to_float = true,
    disable_base_shader = true,
	detrimental = true,
	sound = {
		sound = "unik_pibby_glitch",
		per = 1,
		vol = 2,
	},
	get_weight = function(self)
		if G.GAME.unik_bad_editions_everywhere then
			return G.GAME.edition_rate * 4
		else
			return 0
		end
	end,
	config = {
		emult = 0.9,
		echips = 0.9, trigger = nil
	},
    in_shop = false,
    badge_colour = G.C.UNIK_SHITTY_EDITION,
	loc_vars = function(self, info_queue, card)
	return {vars = {
			self.config.emult,
			self.config.echips
		}, }
	end,
	calculate = function(self, card, context)
		if
			(
				context.edition -- for when on jonklers
				and context.cardarea == G.jokers -- checks if should trigger
				and card.config.trigger -- fixes double trigger
			) or (
				context.main_scoring -- for when on playing cards
				and (context.cardarea == G.play or context.cardarea == G.hand)
			)
		then
			return {
				e_mult = self.config.emult,
				e_chips = self.config.echips,
			}
		end
		if context.joker_main then
			card.config.trigger = true -- context.edition triggers twice, this makes it only trigger once (only for jonklers)
		end

		if context.after then
			card.config.trigger = nil
		end
	end,
})
