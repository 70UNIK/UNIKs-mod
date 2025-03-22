--Strips cards of enhancements after played hand
SMODS.Joker {
    dependencies = {
		items = {
			"set_cry_cursed",
		},
	},
	key = 'unik_vampiric_hammer',
    atlas = 'placeholders',
    rarity = "cry_cursed",
	pos = { x = 3, y = 1 },
    cost = 1,
    --will not be changed in modest
    config = { extra = { selfDestruct = false,min_enhanced_cards = 2, enhanced_cards = 1} },
    pools = { ["unik_boss_blind_joker"] = true},
	blueprint_compat = false,
    perishable_compat = false,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.bl_manacle
        return { vars = {center.ability.extra.min_enhanced_cards, center.ability.extra.enhanced_cards} }
	end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_unik_blind_start_orta_hammer'), G.C.UNIK_ORTA_THE_HAMMER, G.C.WHITE, 1.0 )
    end,
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.enhanced_cards = 0
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if v.config.center ~= G.P_CENTERS.c_base then
                    card.ability.extra.enhanced_cards =  card.ability.extra.enhanced_cards + 1 
                end
            end
            if card.ability.extra.enhanced_cards == 0 and card.ability.extra.selfDestruct == false then
                selfDestruction(card,"k_unik_weapon_destroyed",G.C.UNIK_ORTA_THE_HAMMER)
                card.ability.extra.selfDestruct = true
            else
                card.ability.extra.min_enhanced_cards = math.ceil(card.ability.extra.enhanced_cards/2.0)
            end
        end
    end,
    update = function(self,card,dt)
        if G.playing_cards and card.added_to_deck then
            card.ability.extra.enhanced_cards = 0
            for k, v in pairs(G.playing_cards) do
                if v.config.center ~= G.P_CENTERS.c_base then
                    card.ability.extra.enhanced_cards =  card.ability.extra.enhanced_cards + 1 
                end
            end
            if card.ability.extra.enhanced_cards <  card.ability.extra.min_enhanced_cards and card.ability.extra.selfDestruct == false then
                selfDestruction(card,"k_unik_weapon_destroyed",G.C.UNIK_ORTA_THE_HAMMER)
                card.ability.extra.selfDestruct = true
            end
        end
    end,
    calculate = function(self, card, context)
        if context.final_scoring_step then
            for k, v in ipairs(G.play.cards) do
                if v.ability.set == 'Enhanced' then 
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.7, func = function()
                        v:set_ability(G.P_CENTERS.c_base)
                        return true
                    end}))
                    card_eval_status_text(v, 'extra', nil, nil, nil, {message = localize('k_unik_orta_hammer_stripped'),colour = G.C.UNIK_ORTA_THE_HAMMER})
                end
            end
        end
        --only in ortalab
        if context.setting_blind and (G.GAME.blind and (G.GAME.blind.config.blind.key  == "bl_ortalab_hammer")) and not (G.GAME.blind.disabled) then
            selfDestruction(card,"k_unik_blind_start_orta_hammer",G.C.UNIK_ORTA_THE_HAMMER)
            card.ability.extra.selfDestruct = true
        end
    end
}

