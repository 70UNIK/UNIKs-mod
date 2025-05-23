--Various overrides for mainline balance purpose. Mainline should be still powerful, but not too gamebreaking outside of exotics (Within reason)
--Oil lamp: Immutable & instead adds +0.2x values
--Tropical smoothie: Immutable and instead adds +0.5x values
--Jawbreaker: Immutable and instead adds +1x values
--unregistered hypercam should be rare (put some blueprints and chads and you have almanac levels of scoring)

--OIL LUMP
SMODS.Joker:take_ownership("cry_oil_lamp", {
    immutable = true,
    rarity = 'cry_epic',
    config = { extra = { increase = 1.15 } },
    -- calculate = function(self, card, context)
	-- 	if
	-- 		(context.end_of_round and not context.repetition and not context.individual and not context.blueprint)
	-- 		or context.forcetrigger
	-- 	then
	-- 		local check = false
	-- 		for i = 1, #G.jokers.cards do
	-- 			if G.jokers.cards[i] == card then
	-- 				if i < #G.jokers.cards then
	-- 					if not Card.no(G.jokers.cards[i + 1], "immutable", true) then
	-- 						check = true
	-- 						Cryptid.with_deck_effects(G.jokers.cards[i + 1], function(cards)
	-- 							-- Cryptid.misprintize(
	-- 							-- 	cards,
	-- 							-- 	{ min = card.ability.extra.increase, max = card.ability.extra.increase },
	-- 							-- 	nil,
	-- 							-- 	true
	-- 							-- )
    --                             --LOL DEAL WITH ADDITION
    --                             Cryptid.misprintize(cards, { min = card.ability.extra.increase, max = card.ability.extra.increase}, nil, true, "+")
	-- 						end)
	-- 					end
	-- 				end
	-- 			end
	-- 		end
	-- 		if check then
	-- 			card_eval_status_text(
	-- 				card,
	-- 				"extra",
	-- 				nil,
	-- 				nil,
	-- 				nil,
	-- 				{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
	-- 			)
	-- 		end
	-- 	end
	-- end,

}, true)

--TROFICAL SMOOTHER
SMODS.Joker:take_ownership("j_cry_tropical_smoothie", {
    config = { extra = {extra = 1.4, self_destruct = false}},
    loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.extra) } }
	end,
    rarity = 'cry_epic',
    immutable = true,
    calculate = function(self, card, context)
        --too bad so sad
        if context.forcetrigger and not card.ability.extra.self_destruct then
            local check = false
			for i, v in pairs(G.jokers.cards) do
				if v ~= card then
					if not Card.no(v, "immutable", true) then
						Cryptid.with_deck_effects(v, function(cards)
                            Cryptid.misprintize(cards, { min = card.ability.extra.extra, max = card.ability.extra.extra }, nil, true)
						end)
						check = true
					end
				end
			end
            --dont try to repeat this! Oil lamp exists for a reason.
			if check then
                card.ability.extra.self_destruct = true
				-- card_eval_status_text(
				-- 	card,
				-- 	"extra",
				-- 	nil,
				-- 	nil,
				-- 	nil,
				-- 	{ message = localize(), colour = G.C.GREEN }
				-- )
                selfDestruction(card,"k_upgrade_ex",G.C.GREEN)
			end
        end
		if context.selling_self and not card.ability.extra.self_destruct and not context.repetition and not context.individual and not context.blueprint then
			local check = false
			for i, v in pairs(G.jokers.cards) do
				if v ~= card then
					if not Card.no(v, "immutable", true) then
						Cryptid.with_deck_effects(v, function(cards)
                            Cryptid.misprintize(cards, { min = card.ability.extra.extra, max = card.ability.extra.extra }, nil, true)
						end)
						check = true
					end
				end
			end
			if check then
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
				)
			end
		end
	end,
}, true)

--JAWBUSTER
SMODS.Joker:take_ownership("j_cry_jawbreaker", {
    config = { extra = {increase = 1.8,self_destruct = false} },
    loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.increase) } }
	end,
    immutable = true,
    calculate = function(self, card, context)
		if
			context.end_of_round
			and not context.individual
			and not context.repetition
			and G.GAME.blind.boss
			and not context.blueprint_card
			and not context.retrigger_joker
		then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					if i > 1 then
						if not Card.no(G.jokers.cards[i - 1], "immutable", true) then
							Cryptid.with_deck_effects(G.jokers.cards[i - 1], function(card2)
								Cryptid.misprintize(card2, { min = card.ability.extra.increase, max = card.ability.extra.increase }, nil, true)
							end)
						end
					end
					if i < #G.jokers.cards then
						if not Card.no(G.jokers.cards[i + 1], "immutable", true) then
							Cryptid.with_deck_effects(G.jokers.cards[i + 1], function(card2)
								Cryptid.misprintize(card2, { min = card.ability.extra.increase, max = card.ability.extra.increase }, nil, true)
							end)
						end
					end
				end
			end
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("tarot1")
					card.T.r = -0.2
					card:juice_up(0.3, 0.4)
					card.states.drag.is = true
					card.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.3,
						blockable = false,
						func = function()
							G.jokers:remove_card(card)
							card:remove()
							card = nil
							return true
						end,
					}))
					return true
				end,
			}))
            card.ability.extra.self_destruct = true
			return {
				message = localize("k_eaten_ex"),
				colour = G.C.FILTER,
			}
		end
		if context.forcetrigger and not card.ability.extra.self_destruct then
            card.ability.extra.self_destruct = true
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					if i > 1 then
						if not Card.no(G.jokers.cards[i - 1], "immutable", true) then
							Cryptid.with_deck_effects(G.jokers.cards[i - 1], function(card)
								Cryptid.misprintize(card2, { min = card.ability.extra.increase, max = card.ability.extra.increase }, nil, true)
							end)
						end
					end
					if i < #G.jokers.cards then
						if not Card.no(G.jokers.cards[i + 1], "immutable", true) then
							Cryptid.with_deck_effects(G.jokers.cards[i + 1], function(card)
								Cryptid.misprintize(card2, { min = card.ability.extra.increase, max = card.ability.extra.increase }, nil, true)
							end)
						end
					end
				end
			end
            selfDestruction(card,"k_eaten_ex",G.C.FILTER)
		end
	end,
}, true)

--register hypercom
SMODS.Joker:take_ownership("j_mf_unregisteredhypercam",{
    rarity = 3
}, true)

--CHUD is literally 2 brainstorms in 1
SMODS.Joker:take_ownership("j_cry_chad",{
    rarity = 'cry_epic'
}, true)
--canfas
SMODS.Joker:take_ownership("j_cry_canvas",{
    rarity = 4
}, true)
SMODS.Joker:take_ownership("j_cry_demicolon",{
    rarity = 4
}, true)

