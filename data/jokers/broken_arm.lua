SMODS.Joker {
	key = 'unik_broken_arm',
    atlas = 'placeholders',
    rarity = "cry_cursed",
	pos = { x = 3, y = 1 },
    cost = 1,
    config = { extra = { decrease = 1, maxLevel1 = 7, level1 = 0, selfDestruct = false} },
    pools = { ["unik_boss_blind_joker"] = true},
	blueprint_compat = false,
    perishable_compat = false,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.bl_manacle
        return { vars = {center.ability.extra.decrease, center.ability.extra.maxLevel1,center.ability.extra.level1} }
	end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_unik_blind_start_arm'), G.C.UNIK_THE_ARM, G.C.WHITE, 1.0 )
    end,
	-- Inverse of above function.
    calculate = function(self, card, context)

        if context.cardarea == G.jokers and context.before then
            if to_big(G.GAME.hands[context.scoring_name].level) > to_big(1) then
                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize("k_unik_arm_downgrade"),
                    colour = G.C.UNIK_THE_ARM,
                    card=card,
                })
                level_up_hand(card, context.scoring_name, nil, -1)
                if (card.ability.extra.level1 > 0) then
                    card_eval_status_text(card, "extra", nil, nil, nil, {
                        message = localize('k_reset'),
                        colour = G.C.UNIK_THE_ARM,
                        card=card,
                    })

                    card.ability.extra.level1 = 0
                end

            else
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

