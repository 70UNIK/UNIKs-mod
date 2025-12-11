--Add Steel to a selected playing card, but with a 2 in 3 chance to add 2 playing cards.
SMODS.Consumable{
    set = "Spectral",
	key = "unik_prism",
	pos = { x = 1, y = 0 },
	cost = 4,
	atlas = "unik_spectrals",
	order = 90,
    config = {
		max_highlighted = 1, extra= {cards_added = 3}
	},
	can_use = function(self, card)
		if card.area ~= G.hand then
			local check = true
			if #G.hand.highlighted > card.ability.max_highlighted then
				check = nil
			end
			if #G.hand.highlighted < 1 then
				check = nil
			end
			for index, card in ipairs(G.hand.highlighted) do
				if G.hand.highlighted[index].edition and G.hand.highlighted[index].edition.polychrome then
					check = nil
				end
			end
			return G.hand and (#G.hand.highlighted <= card.ability.max_highlighted) and check
		else
			local idx = 1
			local check = true
			for index, card in ipairs(G.hand.highlighted) do
				if G.hand.highlighted[index].edition and not G.hand.highlighted[index] == card and G.hand.highlighted[index].edition.polychrome then
					check = nil
				end
			end
			return G.hand and (#G.hand.highlighted <= (card.ability.max_highlighted + 1)) and check
		end
	end,
	loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.polychrome) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
		end
		return { vars = {center.ability.max_highlighted, center.ability.extra.cards_added } }
	end,
	use = function(self, card, area, copier)
				local used_consumable = copier or card
		for i = 1, #G.hand.highlighted do
			local highlighted = G.hand.highlighted[i]
			if highlighted ~= card then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						highlighted:juice_up(0.3, 0.5)
						return true
					end,
				}))
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.1,
					func = function()
						if highlighted then
							highlighted:set_edition({ polychrome = true })
						end
						return true
					end,
				}))
				delay(0.5)
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						G.hand:unhighlight_all()

						G.E_MANAGER:add_event(Event({
							func = function()
								local cards = {}
								for i = 1, card.ability.extra.cards_added do
									-- cards[i] = true
									-- local suit_list = {}
									-- for i = #SMODS.Suit.obj_buffer, 1, -1 do
									-- 	suit_list[#suit_list + 1] = SMODS.Suit.obj_buffer[i]
									-- end
									-- local numbers = {}
									-- for _RELEASE_MODE, v in ipairs(SMODS.Rank.obj_buffer) do
									-- 	local r = SMODS.Ranks[v]
									-- 	table.insert(numbers, r.card_key)
									-- end
									-- local _suit, _rank =
									-- 	SMODS.Suits[pseudorandom_element(suit_list, pseudoseed("prism_create"))].card_key,
									-- 	pseudorandom_element(numbers, pseudoseed("prism_create"))
									local card2 = create_playing_card({
										front = pseudorandom_element(G.P_CARDS, pseudoseed('prism_create2')),
										center = G.P_CENTERS.c_base,
									}, G.hand, nil, i ~= 1, { G.C.SECONDARY_SET.Spectral })
									cards[#cards+1] = card2
								end
								playing_card_joker_effects(cards)
								return true
							end,
						}))
						return true
					end,
				}))
			end
		end
	end,
}