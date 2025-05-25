
--3x mult, decays every second
--resets on blind start and defeat
--TODO: Dynamic text that will dynamically show the current mult even when hovering over
SMODS.Joker {
	
	-- How the code refers to the joker.
	key = 'unik_no_standing_zone',
    atlas = 'unik_uncommon',
    rarity = 2,
	pos = { x = 0, y = 1 },
    cost = 7,
	blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = true,
	demicoloncompat = true,
    config = { extra = {x_mult = 3.0, x_mult_mod = 0.07,x_mult_initial = 3.0,selfDestruction = false,message_produced = false,in_scoring = false} },
	loc_vars = function(self, info_queue, center)
		if Card.get_gameset(card) ~= "modest" then
			info_queue[#info_queue + 1] = G.P_CENTERS.j_unik_impounded
		end
		return { 
			key = Cryptid.gameset_loc(self, { modest = "modest"}),
			vars = {center.ability.extra.x_mult,center.ability.extra.x_mult_mod,center.ability.extra.x_mult_initial},
    }
	end,
	gameset_config = {
		modest = { extra = {x_mult = 2.5, x_mult_mod = 0.04,x_mult_initial = 2.5,selfDestruction = false,message_produced = false,in_scoring = false} },
	},
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.x_mult = card.ability.extra.x_mult_initial
    end,
    update = function(self,card,dt)
        --update the dynamic text
        -- unik_dynTextShit[1] = tostring(math.floor((card.ability.extra.x_mult)*100)/100)
        -- card.UIBox:recalculate()
		if card.added_to_deck and card.ability.extra.in_scoring == false then
			card.ability.extra.x_mult = card.ability.extra.x_mult - (card.ability.extra.x_mult_mod * dt/G.SETTINGS.GAMESPEED)
			if card.ability.extra.x_mult <= 1 and card.ability.extra.selfDestruction == false then
				card.ability.extra.selfDestruction = true
				selfDestruction(card,"k_unik_no_standing_towed",G.C.BLACK)
				if Card.get_gameset(card) ~= "modest" then
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.8,
						func = function()
								local card2 = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_unik_impounded")
								card2:add_to_deck()
								G.jokers:emplace(card2)
								card2:start_materialize()
							return true
						end
					}))
				end
			end
			local roundedXmult = math.floor(card.ability.extra.x_mult*100)/100
			--Popup alerts
			if 
			(
			(roundedXmult == 3.0 and roundedXmult ~= card.ability.extra.x_mult_initial) or 
			roundedXmult == 2.5 or 
			roundedXmult == 2 or
			roundedXmult == 1.75 or
			roundedXmult == 1.5 or
			roundedXmult == 1.4 or
			roundedXmult == 1.3 or
			roundedXmult == 1.2 or
			roundedXmult == 1.1) and card.ability.extra.message_produced == false
			then
				card.ability.extra.message_produced = true
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize({ type = "variable", key = "a_xmult", vars = { roundedXmult } }),
					card = card,
					colour = G.C.MULT,
				})
				G.E_MANAGER:add_event(Event({
					trigger='after',
					delay=0.3,
					func = function()
						card.ability.extra.message_produced = false
						return true
					end
				}))
			end
		end
    end,
    calculate = function(self, card, context)
        --calculate Xmult
		if (context.joker_main and (to_big(card.ability.extra.x_mult) > to_big(1))) then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
				Xmult_mod = card.ability.extra.x_mult,
			}
		end
		if context.forcetrigger then
			card.ability.extra.selfDestruction = true
			selfDestruction(card,"k_unik_no_standing_towed",G.C.BLACK)
			if Card.get_gameset(card) ~= "modest" then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.8,
					func = function()
							local card2 = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_unik_impounded")
							card2:add_to_deck()
							G.jokers:emplace(card2)
							card2:start_materialize()
						return true
					end
				}))
			end
		end
		--pause timer if scoring (to ease pain in lack of control in scoring and to avoid talisman animation exploit)
		if context.before and not context.blueprint_card
		and not context.retrigger_joker then
			card.ability.extra.in_scoring = true
			--return true
		end
		if context.after and not context.blueprint_card
		and not context.retrigger_joker then
			G.E_MANAGER:add_event(Event({
				trigger='after',
				delay=0.3,
				func = function()
					card.ability.extra.in_scoring = false
					return true
				end
			}))
			--return true
		end
        --reset to 3x
        if
            (context.end_of_round)
            and not context.individual
            and not context.repetition
            and not context.blueprint_card
            and not context.retrigger_joker
        then
            card.ability.extra.x_mult = card.ability.extra.x_mult_initial
            return {
				message = localize("k_reset"),
				card = card,
				colour = G.C.MULT,
            }
        end
		if (context.setting_blind)
		and not context.individual
		and not context.repetition
		and not context.blueprint_card
		and not context.retrigger_joker
		then
            card.ability.extra.x_mult = card.ability.extra.x_mult_initial
            return {
				message = localize("k_reset"),
				card = card,
				colour = G.C.MULT,
            }
		end
		--also impound if sold in blind
		if (G.GAME.blind and G.GAME.blind.in_blind) and context.selling_self and not context.repetition and not context.blueprint and card.ability.extra.selfDestruction == false then
			card.ability.extra.selfDestruction = true
			if Card.get_gameset(card) ~= "modest" then
				selfDestruction(card,"k_unik_no_standing_towed",G.C.BLACK)
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.8,
					func = function()
							local card2 = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_unik_impounded")
							card2:add_to_deck()
							G.jokers:emplace(card2)
							card2:start_materialize()
						return true
					end
				}))
			end
        end
    end,
}
--Simple EChips display
if JokerDisplay then
	JokerDisplay.Definitions["j_unik_no_standing_zone"] = {
		text = {
			{
				border_nodes = {
					{ text = "X" ,scale = 0.6},
					{
						ref_table = "card.ability.extra",
						ref_value = "x_mult",
						retrigger_type = "exp",
						scale = 0.6,
					},
				},
				border_colour = G.C.MULT,
			},
		},
		reminder_text = {
			{
				ref_table = "card.joker_display_values",
				ref_value = "warning",
				colour = G.C.RED,
			},		
		},
		calc_function = function(card)
			local warning = ""
			if card.ability.extra.x_mult < (1 + card.ability.extra.x_mult_mod*15) and card.ability.extra.x_mult > (1 + card.ability.extra.x_mult_mod*7.5) then
				if math.ceil(card.ability.extra.x_mult*10) % 2 == 0 then
					warning = localize('k_unik_hurry_up')
				end
			elseif card.ability.extra.x_mult <= (1 + card.ability.extra.x_mult_mod*7.5) then
				if math.ceil(card.ability.extra.x_mult*20) % 2 == 0 then
					warning = localize('k_unik_hurry_up2')
				end
			end
			card.joker_display_values.warning = warning
		end
	}
end
