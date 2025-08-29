-- Pool used by drab dumpster
SMODS.ObjectType({
	key = "unik_garbage_jokers",
	default = "j_seance",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		-- insert base game food jokers
		self:inject_card(G.P_CENTERS.j_seance)
		self:inject_card(G.P_CENTERS.j_obelisk)
		self:inject_card(G.P_CENTERS.j_8_ball)
		self:inject_card(G.P_CENTERS.j_superposition)
        self:inject_card(G.P_CENTERS.j_ring_master)
        self:inject_card(G.P_CENTERS.j_loyalty_card)
        self:inject_card(G.P_CENTERS.j_hit_the_road)
	end,
})