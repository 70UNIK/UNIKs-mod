--^^1.2 Mult. If copied, retriggered or blind defeated in 1 hand, self destructs and the next blind becomes an epic blind.
--EPIC
function ForceEpicBlind()
    G.GAME.unik_force_epic_plus = G.GAME.unik_force_epic_plus or 0
    G.GAME.unik_force_epic_plus = G.GAME.unik_force_epic_plus + 1
    if G.GAME.round_resets.blind_states.Small == "Upcoming" then
        G.GAME.round_resets.blind_choices.Small = get_new_boss()
    elseif G.GAME.round_resets.blind_states.Big == "Upcoming" then
        G.GAME.round_resets.blind_choices.Big = get_new_boss()
    elseif G.GAME.round_resets.blind_states.Boss == "Upcoming" then 
        G.GAME.round_resets.blind_choices.Boss = get_new_boss()
    end
end
SMODS.Joker {
    key = 'unik_epic_blind_sauce',
    atlas = 'unik_epic',
    rarity = 'cry_epic',
	pos = { x = 0, y = 1 },
    cost = 10,
    blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = true,
    demicoloncompat = true,
    immutable = true,
    config = { extra = { EEmult = 1.1,destroyed = false,triggers = 2} },
    loc_vars = function(self, info_queue, center)
        local key = "j_unik_epic_blind_sauce"
        if not unik_config.unik_legendary_blinds then
            key = "j_unik_epic_blind_sauce_no_epic"
            center.ability.extra.EEmult = 2
        else
            center.ability.extra.EEmult = 1.1
        end
        
		return { key = key, vars = {center.ability.extra.EEmult} }
	end,
    --Only spawn if you have at least 1 king of spades in deck
    calculate = function(self, card, context)
        --dont try to force trigger it. It will self destruct and guarantee an epic blind.
        if context.forcetrigger and not card.ability.extra.destroyed then
            card.ability.extra.destroyed = true
            selfDestruction(card,"k_drank_ex",G.C.UNIK_VOID_COLOR) 
            ForceEpicBlind()
        end
        if context.final_scoring_step and not card.ability.extra.destroyed then
            
            if (context.blueprint_card or context.retrigger_joker or context.repetition) and not card.ability.extra.destroyed then
                card.ability.extra.destroyed = true
                selfDestruction(card,"k_drank_ex",G.C.UNIK_VOID_COLOR)
                ForceEpicBlind()
            end
            if not card.ability.extra.destroyed then
                if not (context.blueprint_card or context.retrigger_joker or context.repetition) then
                    card.ability.extra.triggers = card.ability.extra.triggers - 1
                end
                if not unik_config.unik_legendary_blinds then
                    return {
                        message = localize({
                            type = "variable",
                            key = "a_powmult",
                            vars = {
                                number_format(card.ability.extra.EEmult),
                            },
                        }),
                        Emult_mod = card.ability.extra.EEmult,
                        colour = G.C.DARK_EDITION,
                    }
                else
                    return {
                        message = localize({
                            type = "variable",
                            key = "a_EEmult",
                            vars = {
                                number_format(card.ability.extra.EEmult),
                            },
                        }),
                        EEmult_mod = card.ability.extra.EEmult,
                        colour = G.C.DARK_EDITION,
                    }
                end   
            end
        end
        if context.end_of_round and context.cardarea == G.jokers and not card.ability.extra.destroyed then
			if card.ability.extra.triggers > 0 then
                card.ability.extra.destroyed = true
                selfDestruction(card,"k_drank_ex",G.C.UNIK_VOID_COLOR)
                ForceEpicBlind()
            end
		end
        if context.setting_blind then
			card.ability.extra.triggers = 2
		end
    end
}