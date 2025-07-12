SMODS.Joker {
    dependencies = {
		items = {
			"set_cry_cursed",
		},
	},
	key = 'unik_broken_arm',
    atlas = 'unik_cursed',
    rarity = "cry_cursed",
    no_dbl = true,
	pos = { x = 3, y = 2 },
    cost = 1,
    config = { extra = { decrease = 1, maxLevel1 = 7, level1 = 0, selfDestruct = false,prob = 1,odds = 4} },
    pools = { ["unik_boss_blind_joker"] = true},
	blueprint_compat = false,
    immutable = true,
    perishable_compat = false,
    loc_vars = function(self, info_queue, center)
        -- info_queue[#info_queue + 1] = G.P_CENTERS.bl_manacle
        local new_numerator, new_denominator = SMODS.get_probability_vars(center, center.ability.extra.prob, center.ability.extra.odds, 'unik_the_arm')
        return { 
            key = Cryptid.gameset_loc(self, { modest = "modest"}),
            vars = {center.ability.extra.decrease, center.ability.extra.maxLevel1,center.ability.extra.level1,
        new_numerator, new_denominator
    } }
	end,
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.level1 = 0
    end,
    gameset_config = {
		modest = {extra = { decrease = 1, maxLevel1 = 4, level1 = 0, selfDestruct = false,odds = 4} },
	},
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_unik_blind_start_arm'), G.C.UNIK_THE_ARM, G.C.WHITE, 1.0 )
    end,
	-- Inverse of above function.
    calculate = function(self, card, context)

        if context.cardarea == G.jokers and context.before then
            if to_big(G.GAME.hands[context.scoring_name].level) > to_big(1) and ((Card.get_gameset(card) ~= "modest") or (Card.get_gameset(card) == "modest" and SMODS.pseudorandom_probability(card, 'unik_the_arm', card.ability.extra.prob, card.ability.extra.odds, 'unik_the_arm'))) then
                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize("k_unik_arm_downgrade"),
                    colour = G.C.UNIK_THE_ARM,
                    card=card,
                })
                level_up_hand(card, context.scoring_name, nil, -1)
                --only consecutive if mainline+
                if (card.ability.extra.level1 > 0 and Card.get_gameset(card) ~= "modest") then
                    card_eval_status_text(card, "extra", nil, nil, nil, {
                        message = localize('k_reset'),
                        colour = G.C.UNIK_THE_ARM,
                        card=card,
                    })

                    card.ability.extra.level1 = 0
                end
            --increase counter every time a level 1 hand is played. always for non modest due to above, but requres level 1 hand for non modest
            elseif to_big(G.GAME.hands[context.scoring_name].level) <= to_big(1) then
                card.ability.extra.level1 = card.ability.extra.level1 + 1
                if card.ability.extra.level1 == card.ability.extra.maxLevel1 then
                    selfDestruction(card,"k_unik_arm_healed",G.C.UNIK_THE_ARM)
                    card.ability.extra.selfDestruct = true
                else
                    return {
                        message = localize({type='variable',key='a_unik_hands_1',vars={card.ability.extra.level1}}),
                        colour = G.C.UNIK_THE_ARM,
                        card=card,
                    }
                end
            end
        end
        if context.setting_blind and (G.GAME.blind and (G.GAME.blind.config.blind.name == "The Arm")) and not (G.GAME.blind.disabled) then
            selfDestruction(card,"k_unik_blind_start_arm",G.C.UNIK_THE_ARM)
            card.ability.extra.selfDestruct = true
        end
    end
}
-- if JokerDisplay then
-- 	JokerDisplay.Definitions["j_unik_broken_arm"] = {
--         text = {
--             {
--                 ref_table = "card.joker_display_values",
--                 ref_value = "level_down",
--                 retrigger_type = "mult",
--                 colour = G.C.RED,
--             },
--         },
--         reminder_text = {
--             {
--                 ref_table = "card.joker_display_values",
--                 ref_value = "level_ones",
--                 retrigger_type = "mult",
--                 colour = G.C.FILTER,
--             },	
--         },
--         extra = {
--             {
--                 {
--                     ref_table = "card.joker_display_values",
--                     ref_value = "odds",
--                     colour = G.C.GREEN,
--                     scale = 0.3,
--                 },		
-- 			},
-- 		},
--         calc_function = function(card)
--             local odds = ""
--             local levelDown = ""
--             local text, _, scoring_hand = JokerDisplay.evaluate_hand() --get poker hand
-- 			if text ~= 'Unknown' and text ~= 'NULL' then
--                 if to_big(G.GAME.hands[text].level) > to_big(1) then
--                     levelDown = "-" .. card.ability.extra.decrease .. " " .. localize("k_level_prefix")
--                 end
--             end
--             if Card.get_gameset(card) == "modest" then
--                
--             end
-- 			card.joker_display_values.level_ones = "(" .. card.ability.extra.level1 .. "/" .. card.ability.extra.maxLevel1 .. ")"
--             card.joker_display_values.level_down = levelDown
--             card.joker_display_values.odds = odds
--         end
-- 	}
-- end
