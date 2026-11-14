UNIK.menu_cards = function()

	-- local card = Card(
	-- 		G.title_top.T.x,
	-- 		G.title_top.T.y,
	-- 		G.CARD_W,
	-- 		G.CARD_H,
	-- 		G.P_CARDS.empty,
	-- 		G.P_CENTERS.m_unik_pink,
	-- 		{ bypass_discovery_center = true }
	-- 	)
	-- card:set_edition(G.P_CENTERS.e_unik_shining_glitter and 'e_unik_shining_glitter' or 'e_polychrome',true,true)
	return {
		{ key  = 'm_unik_pink',edition = 'e_unik_shining_glitter',silent = true}
	}
end

local oldfunc = Game.main_menu
	Game.main_menu = function(change_context)
		local ret = oldfunc(change_context)

		G.SPLASH_BACK:define_draw_steps({
			{
				shader = "splash",
				send = {
					{ name = "time", ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
					{ name = "vort_speed", val = 0.4 },
					{ name = "colour_1", ref_table = G.C, ref_value = "UNIK_ANCIENT" },
					{ name = "colour_2", ref_table = G.C, ref_value = "UNIK_UNIK" },
				},
			},
		})
		
		if (SMODS.Mods and SMODS.Mods.Talisman) or (SMODS.Mods.Talisman and SMODS.Mods.Talisman.can_load) then
			print("WARNING: TALISMAN, INSTEAD OF CDATAMAN HAS BEEN LOADED. THERE MAY BE UNEXPECTED COMPARISON ERRORS")
		end
		return ret
	end