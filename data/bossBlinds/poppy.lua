--Used to prevent hand from scorng if exceeding 2.5x requirements, 
--now it's a conditional version of The Tax, where hands exceeding 2.5x reqs get their score multiplied by 0.05x, meaning its possible to brute force if scoring really high.
SMODS.Blind{

    key = 'unik_the_poppy',
    config = {},
	boss = {
		min = 1,
	},
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 6},
    boss_colour= HEX("ff4a64"),
    dollars = 5 ,
    mult = 2,
	loc_vars = function(self, info_queue, card)
		return { vars = { 2.5 * get_blind_amount(G.GAME.round_resets.ante) * 2 * G.GAME.starting_params.ante_scaling } } -- no bignum?
	end,
	collection_loc_vars = function(self)
		return { vars = { localize("k_unik_poppy_placeholder") } }
	end,
	death_message="special_lose_unik_tall_poppy_syndrome",
	set_blind = function(self)
		SMODS.set_scoring_calculation("unik_poppy")
		--G.GAME.unik_poppy_ceil = true
	end,
	disable = function(self)
		SMODS.set_scoring_calculation("multiply")
		--G.GAME.unik_poppy_ceil = nil
	end,
	defeat = function(self, silent)
		SMODS.set_scoring_calculation("multiply")
	end,
}


--stolen from the tax
SMODS.Scoring_Calculation({
	key = 'unik_poppy',
	func = function(self, chips, mult, flames)
		if to_big(chips * mult) > to_big(2.5 * G.GAME.blind.chips) then
			return (chips * mult)*0.03
		end
		return chips * mult
	end,
	replace_ui = function(self)
		local aaa = 0.03
		local zzz = (2.5 * G.GAME.blind.chips) 
		local bbb = localize({ type = "variable", key = "poppy_hand", vars = { aaa,zzz } })[1]
		-- rebuild the ui to change colours and add text and stuff
		-- SMODS made some stuff for this so that's kinda convienient ig
		return {
			n = G.UIT.R,
			config = { minh = 1.2, align = "cm" },
			nodes = {
				{
					n = G.UIT.C,
					config = { align = "cm" },
					nodes = {
						{
							n = G.UIT.R,
							config = { align = "cm", minh = 1, padding = 0.1 },
							nodes = {
								-- Chips box
								{
									n = G.UIT.C,
									config = { align = "cm", id = "hand_chips_container" },
									nodes = {
										SMODS.GUI.score_container({
											type = "chips",
											text = "chip_text",
											align = "cr",
											colour = G.C.CHIPS,
										}),
									},
								},
								-- Operator thingy (Stays the same)
								SMODS.GUI.operator(0.4),
								-- Mult box
								{
									n = G.UIT.C,
									config = { align = "cm", id = "hand_mult_container" },
									nodes = {
										SMODS.GUI.score_container({
											type = "mult",
											colour = G.C.MULT,
										}),
									},
								},
							},
						},
						-- Text
						{
							n = G.UIT.R,
							config = { align = "cm" },
							nodes = {
								{
									n = G.UIT.T,
									config = { text = bbb, scale = 0.25, colour = G.C.IMPORTANT },
								},
							},
						},
					},
				},
			},
		}
	end,
})
