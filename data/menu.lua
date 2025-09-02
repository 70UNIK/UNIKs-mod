local oldfunc = Game.main_menu
	Game.main_menu = function(change_context)
		local ret = oldfunc(change_context)
		-- adds a Cryptid spectral to the main menu
		local newcard = Card(
			G.title_top.T.x,
			G.title_top.T.y,
			G.CARD_W,
			G.CARD_H,
			G.P_CARDS.empty,
			G.P_CENTERS.m_unik_pink,
			{ bypass_discovery_center = true }
		)
        newcard:set_edition(G.P_CENTERS.e_unik_shining_glitter and 'e_unik_shining_glitter' or 'e_polychrome',true,true)
		-- recenter the title
		G.title_top.T.w = G.title_top.T.w * 1.7675
		G.title_top.T.x = G.title_top.T.x - 0.8
		G.title_top:emplace(newcard)
		-- make the card look the same way as the title screen Ace of Spades
		newcard.T.w = newcard.T.w * 1.1 * 1.2
		newcard.T.h = newcard.T.h * 1.1 * 1.2
		newcard.no_ui = true
		newcard.states.visible = false

		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0,
			blockable = false,
			blocking = false,
			func = function()
				if change_context == "splash" then
					newcard.states.visible = true
					newcard:start_materialize({ G.C.WHITE, G.C.WHITE }, true, 2.5)
				else
					newcard.states.visible = true
					newcard:start_materialize({ G.C.WHITE, G.C.WHITE }, nil, 1.2)
				end
				return true
			end,
		}))
		return ret
	end