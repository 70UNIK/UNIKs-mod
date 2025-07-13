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
		mult = -3,
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
	get_weight = function(self)
		if G.GAME.unik_bad_editions_everywhere then
			return G.GAME.edition_rate * 4
		else
			return 0
		end
	end,
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
generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		if not full_UI_table.name then
			full_UI_table.name = localize({ type = "name", set = self.set, key = self.key, nodes = full_UI_table.name })
		end
		local r_mults = {}
		for i = self.config.min_mult, self.config.max_mult do
			r_mults[#r_mults + 1] = tostring(i)
		end
		local loc_mult = " " .. (localize("k_mult")) .. " "
		local r_chips = {}
		for i = self.config.min_chips, self.config.max_chips do
			r_chips[#r_chips + 1] = tostring(i)
		end
		local r_cash = {}
		for i = self.config.min_dollars, self.config.max_dollars do
			r_cash[#r_cash + 1] = tostring(i)
		end
		local loc_chips = " Chips "
		local loc_cash = " AUD"
		local loc_cash2 = "    "
		mult_ui = {
			{ n = G.UIT.T, config = { text = "  ", colour = G.C.MULT, scale = 0.32 } },
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = r_mults,
						colours = { G.C.MULT },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.5,
						scale = 0.32,
						min_cycle_time = 0,
					}),
				},
			},
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = {
							{ string = "rand()", colour = G.C.JOKER_GREY },
							{
								string = "#@"
									.. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.id or 11)
									.. (
										G.deck
											and G.deck.cards[1]
											and G.deck.cards[#G.deck.cards].base.suit
											and G.deck.cards[#G.deck.cards].base.suit:sub(1, 1)
										or "D"
									),
								colour = G.C.RED,
							},
							loc_mult,
							loc_mult,
							loc_mult,
							loc_mult,
							loc_mult,
							loc_mult,
							loc_mult,
							loc_mult,
							loc_mult,
							loc_mult,
							loc_mult,
							loc_mult,
							loc_mult,
						},
						colours = { G.C.UI.TEXT_DARK },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.2011,
						scale = 0.32,
						min_cycle_time = 0,
					}),
				},
			},
		}
		chip_ui = {
			{ n = G.UIT.T, config = { text = "  ", colour = G.C.CHIPS, scale = 0.32 } },
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = r_chips,
						colours = { G.C.CHIPS },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.5,
						scale = 0.32,
						min_cycle_time = 0,
					}),
				},
			},
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = {
							{ string = "rand()", colour = G.C.JOKER_GREY },
							{
								string = "@#"
									.. (G.deck and G.deck.cards[1] and G.deck.cards[1].base.suit and G.deck.cards[1].base.suit:sub(
										2,
										2
									) or "m")
									.. (G.deck and G.deck.cards[1] and G.deck.cards[1].base.id or 7),
								colour = G.C.BLUE,
							},
							loc_chips,
							loc_chips,
							loc_chips,
							loc_chips,
							loc_chips,
							loc_chips,
							loc_chips,
							loc_chips,
							loc_chips,
							loc_chips,
							loc_chips,
							loc_chips,
							loc_chips,
						},
						colours = { G.C.UI.TEXT_DARK },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.2011,
						scale = 0.32,
						min_cycle_time = 0,
					}),
				},
			},
		}
		cash_ui = {
			{ n = G.UIT.T, config = { text = "  $", colour = G.C.GOLD, scale = 0.32 } },
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = r_cash,
						colours = { G.C.GOLD },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.5,
						scale = 0.32,
						min_cycle_time = 0,
					}),
				},
			},
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = {
							{ string = "rand()", colour = G.C.JOKER_GREY },
							{
								string = "@#"
									.. (G.deck and G.deck.cards[1] and G.deck.cards[1].base.suit and G.deck.cards[1].base.suit:sub(
										2,
										2
									) or "m")
									.. (G.deck and G.deck.cards[1] and G.deck.cards[1].base.id or 7),
								colour = G.C.GOLD,
							},
							loc_cash,
							loc_cash2,
							loc_cash2,
							loc_cash2,
							loc_cash,
							loc_cash2,
							loc_cash2,
							loc_cash2,
							loc_cash,
							loc_cash2,
							loc_cash,
							loc_cash2,
						},
						colours = { G.C.UI.TEXT_DARK },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.2011,
						scale = 0.32,
						min_cycle_time = 0,
					}),
				},
			},
		}
		desc_nodes[#desc_nodes + 1] = mult_ui
		desc_nodes[#desc_nodes + 1] = chip_ui
		desc_nodes[#desc_nodes + 1] = cash_ui
	end,
})