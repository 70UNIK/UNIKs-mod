SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_711',
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { spawn = false, hasAce = false, has7 = false,shaking = false} },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	-- loc_vars = function(self, info_queue, card)
	-- 	return { vars = { card.ability.extra.mult } }
	-- end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- loc_txt = {set = 'Joker', key = 'j_unik_711'},
	-- Which atlas key to pull from.
	-- In cryptid, I think this should be uncapped; found myself not using it when I use up all my joker slots
	atlas = 'unik_uncommon',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 0 },
	-- Cost of card in shop.
	cost = 7,
	blueprint_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	eternal_compat = true,
	loc_vars = function(self, info_queue, center)
		
		info_queue[#info_queue + 1] = { set = "Other", key = "food_jokers" }
		return {
			key = Cryptid.gameset_loc(self, {modest = "modest" }), 
		}
	end,
	pools = {["unik_copyrighted"] = true ,["unik_seven"] = true },
    add_to_deck = function(self, card, context)
		--only shake if a blind has started
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.GAME.blind.in_blind then
					card.ability.extra.spawn = true
					card.ability.extra.shaking = true
					--Do not spam the shake
					local eval = function(card)
						return card.ability.extra.spawn == true
					end
					juice_card_until(card, eval, true)
				end
				return true
			end
		}))
	end,
	load = function(self, card, card_table, other_card)
		--Do not spam the shake
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.GAME.blind.in_blind then
					card.ability.extra.shaking = true
					--Do not spam the shake
					local eval = function(card)
						return card.ability.extra.spawn == true
					end
					juice_card_until(card, eval, true)
				end
				return true
			end
		}))
	end,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
    calculate = function(self, card, context)

		if context.forcetrigger then
			G.E_MANAGER:add_event(Event({
				func = function()
					card:juice_up(0.3, 0.4)
					--This will need to be updated when refactor branch is complete.
					
					-- local card2 = create_card("Joker", G.jokers, nil, nil, nil, nil, Cryptid.get_food("711"))

					
					local card2 = create_card("Food", G.jokers, nil, nil, nil, nil, nil, "711")
					card2:add_to_deck()
					G.jokers:emplace(card2)
					card2:start_materialize()
					return true
				end
			}))
			return{
				message = localize("k_unik_711"),
				colour = HEX("008161"),
			}
        end
		-- After checking cards, create a food joker if conditions are met
		if context.joker_main then
			--if card.ability.extra.hasAce == true and not (context.blueprint_card or self).getting_sliced and card.ability.extra.has7 == true and card.ability.extra.spawn == true and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
			if card.ability.extra.hasAce == true and not (context.blueprint_card or self).getting_sliced and card.ability.extra.has7 == true and card.ability.extra.spawn == true 
			and (Card.get_gameset(card) ~= "modest" or (#G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit and Card.get_gameset(card) == "modest"))
			then
				-- Create a Food Joker according to Cryptid.
				local jokers_to_create = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
				G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
				G.E_MANAGER:add_event(Event({
					func = function()
						card:juice_up(0.3, 0.4)
						--This will need to be updated when refactor branch is complete.
						
						-- local card2 = create_card("Joker", G.jokers, nil, nil, nil, nil, Cryptid.get_food("711"))

						if (jokers_to_create > 0 or Card.get_gameset(card) ~= "modest")then
							local card2 = create_card("Food", G.jokers, nil, nil, nil, nil, nil, "711")
							card2:add_to_deck()
							G.jokers:emplace(card2)
							card2:start_materialize()
							G.GAME.joker_buffer = 0
							--If it can spawn, it should not spawn again (blueprint for instance, if you have 2 blueprints, and the blueprint does it first, then it should count as "created")
							card.ability.extra.spawn = false
						end
						return true
					end
				}))
				if not context.blueprint then
					card.ability.extra.spawn = false
				end
				return{
					message = localize("k_unik_711"),
					colour = HEX("008161"),
				}
			end
			--Reset variables to repeat in case an attempt fails; should not carry over to the next hand
			card.ability.extra.hasAce = false
			card.ability.extra.has7 = false
		end
		--Reset when blind starts or
		if context.setting_blind then
			if card.ability.extra.shaking == false then
				card.ability.extra.hasAce = false
				card.ability.extra.has7 = false
				card.ability.extra.spawn = true
				card.ability.extra.shaking = true
				--Do not spam the shake
				local eval = function(card)
					return card.ability.extra.spawn == true
				end
				juice_card_until(card, eval, true)
			end
		end
		

		-- After round ends, stop shake if not triggered
		if context.end_of_round and context.cardarea == G.jokers then
			card.ability.extra.shaking = false
			card.ability.extra.spawn = false
		end
		--If the card can spawn, it should shake continuously. Otherwise it should not shake
        -- Activate at start of round

		if context.individual and context.cardarea == G.play then
			-- :get_id tests for the rank of the card. Other than 2-10, Jack is 11, Queen is 12, King is 13, and Ace is 14.
			if context.other_card:get_id() == 14 then
                card.ability.extra.hasAce = true
            end
            if context.other_card:get_id() == 7 then
                card.ability.extra.has7 = true
			end
		end

	end
}
if JokerDisplay then
	JokerDisplay.Definitions["j_unik_711"] = {
		text = {
			{
				ref_table = "card.joker_display_values",
				ref_value = "active",
				colour = G.C.FILTER,
			},		
		},
		reminder_text = {
			{
				ref_table = "card.joker_display_values",
				ref_value = "localized_text_cards",
				scale = 0.3,
				colour = G.C.UI.TEXT_INACTIVE,
			},		
		},
        calc_function = function(card)
			card.joker_display_values.active = ((card.ability.extra.spawn) and localize("jdis_active") or localize("jdis_inactive"))
            card.joker_display_values.localized_text_cards = "(" .. localize("Ace", "ranks") .. "+7)"
        end
	}
end
