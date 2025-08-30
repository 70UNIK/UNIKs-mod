SMODS.Tag{
	atlas = 'unik_tags',
    key = 'unik_extended_empowered',
	pos = { x = 2, y = 0 },
    config = { type = "new_blind_choice" },
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_spectral_normal_1
		info_queue[#info_queue + 1] = { set = "Spectral", key = "c_soul" }
		info_queue[#info_queue + 1] = G.P_CENTERS.j_unik_foundation
		info_queue[#info_queue + 1] = { set = "Spectral", key = "c_cry_gateway" }
		return { vars = {} }
	end,

	apply = function(self, tag, context)
		if context.type == "new_blind_choice" then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep("+", G.C.SECONDARY_SET.Spectral, function()
				local key = "p_unik_extended_empowered"
				local card = Card(
					G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
					G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
					G.CARD_W * 1.27,
					G.CARD_H * 1.27,
					G.P_CARDS.empty,
					G.P_CENTERS[key],
					{ bypass_discovery_center = true, bypass_discovery_ui = true }
				)
				card.cost = 0
				card.from_tag = true
				G.FUNCS.use_card({ config = { ref_table = card } })
				if G.GAME.modifiers.cry_force_edition and not G.GAME.modifiers.cry_force_random_edition then
					card:set_edition(nil, true, true)
				elseif G.GAME.modifiers.cry_force_random_edition then
					local edition = Cryptid.poll_random_edition()
					card:set_edition(edition, true, true)
				end
				card:start_materialize()
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
	in_pool = function()
		return false
	end,
}

SMODS.Booster{
    key = "unik_extended_empowered",
	kind = "Spectral",
    atlas = "unik_cube_boosters",
	pos = { x = 0, y = 1 },
    cost = 0,
    weight = 0, 
    config = { extra = 3, choose = 1 },
    cry_digital_hallucinations = {
        colour = G.C.SECONDARY_SET.Spectral,
		loc_key = "k_plus_spectral",
		create = function()
			local ccard
			if pseudorandom(pseudoseed("diha_devil")) < 0.333 then
				ccard = create_card("Spectral", G.consumeables, nil, nil, true, true, "c_soul")
            elseif pseudorandom(pseudoseed("diha_devil")) < 0.666 then
				ccard = create_card("Joker", G.jokers, nil, nil, true,true, "j_unik_foundation")
            else
				ccard = create_card("Spectral", G.consumeables, nil, nil, true, true, "c_unik_gateway")
			end
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.consumeables:emplace(ccard)
		end,
    },
	draw_hand = true,
	update_pack = SMODS.Booster.update_pack,
	loc_vars = SMODS.Booster.loc_vars,
	ease_background_colour = function(self)
		ease_background_colour_blind(G.STATES.SPECTRAL_PACK)
	end,
	create_UIBox = function(self)
		return create_UIBox_spectral_pack()
	end,
	particles = function(self)
		G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
			timer = 0.015,
			scale = 0.1,
			initialize = true,
			lifespan = 3,
			speed = 0.2,
			padding = -1,
			attach = G.ROOM_ATTACH,
			colours = { G.C.WHITE, lighten(G.C.GOLD, 0.2) },
			fill = true,
		})
		G.booster_pack_sparkles.fade_alpha = 1
		G.booster_pack_sparkles:fade(1, 0)
	end,
	create_card = function(self, card, i)
		if
			i % 2 == 1
			and Cryptid.enabled("c_cry_gateway") == true
			and not G.GAME.used_jokers["c_cry_gateway"]
			and not next(find_joker("Showman"))
		then
			return create_card("Spectral", G.pack_cards, nil, nil, true, true, "c_cry_gateway")
		elseif not G.GAME.used_jokers["c_soul"] and not next(find_joker("Showman")) then
			return create_card("Spectral", G.pack_cards, nil, nil, true, true, "c_soul")
        elseif not G.GAME.used_jokers["j_unik_foundation"] and not next(find_joker("Showman")) then
            return create_card("Joker", G.jokers, nil, nil, true,true, "j_unik_foundation")
        else
			return create_card("Spectral", G.pack_cards, nil, nil, true, true)
		end
	end,
	group_key = "k_spectral_pack",
}

