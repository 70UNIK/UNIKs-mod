--fuzzy:
-- -10 - 0 Mult, -50 - 0 Chips, -$0 - -$4
--Sound is literally from yoshis island
SMODS.Sound({
	key = "fuzzy",
	path = "fuzzy.ogg",
})
SMODS.Shader({
    key = "fuzzy",
    path = "fuzzy.fs",
})
local fuzzy_stats = {
	min = {
		mult = -1,
		chips = -50,
        dollars = -1,
	},
	max = {
		mult = 0,
		chips = 0,
        dollars = 0,
	},
}
SMODS.Edition({
	key = "fuzzy",
	order = 66666,
	weight = 0, -- should not appear normally in stores as its a detrimental one
	shader = "fuzzy", --placeholder for now until I program one. It should have negative shine, but with a polychromesque shine from normal to overlay to a bit of negative, just to show its the opposite
	extra_cost = -4, --Its a detrimental edition, hence lower cost
    apply_to_float = true,
    disable_base_shader = true,
    no_shadow = true,
	sound = {
		sound = "unik_fuzzy",
		per = 1,
		vol = 1,
	},
    -- loc_txt = {
	-- 	name = 'Positive',
    --     label = 'Positive',
	-- 	text = {
	-- 		"{C:red}#1#{} #2#"
	-- 	}
	-- },
    config = {
		min_mult = fuzzy_stats.min.mult,
		max_mult = fuzzy_stats.max.mult,
		min_chips = fuzzy_stats.min.chips,
		max_chips = fuzzy_stats.max.chips,
		min_dollars = fuzzy_stats.min.dollars,
		max_dollars = fuzzy_stats.max.dollars,
		trigger = nil,
	},
    -- loc_txt = {
	-- 	name = 'Positive',
    --     label = 'Positive',
	-- 	text = {
	-- 		"{C:red}#1#{} #2#"
	-- 	}
	-- },
    in_shop = false,
    badge_colour = G.C.UNIK_SHITTY_EDITION,
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
			return {
				mult = pseudorandom("unik_fuzzy_mult", self.config.min_mult, self.config.max_mult),
				chips = pseudorandom("unik_fuzzy_chips", self.config.min_chips, self.config.max_chips),
                dollars = pseudorandom("unik_fuzzy_dollars", self.config.min_dollars, self.config.max_dollars),
			} -- updated value
		end
		if context.joker_main then
			card.config.trigger = true -- context.edition triggers twice, this makes it only trigger once (only for jonklers)
		end

		if context.after then
			card.config.trigger = nil
		end
	end,
})