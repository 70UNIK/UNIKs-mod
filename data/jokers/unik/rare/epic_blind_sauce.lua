
--EPIC
function ForceEpicBlind()
    G.GAME.unik_force_epic_plus = G.GAME.unik_force_epic_plus or 0
    G.GAME.unik_force_epic_plus = G.GAME.unik_force_epic_plus + 1
    if G.GAME.round_resets.blind_states.Small == "Upcoming" then
        if G.GAME.round_resets.cookie_increment and G.GAME.round_resets.cookie_increment.Small then
            G.GAME.round_resets.cookie_increment.Small = nil
        end
        G.GAME.round_resets.blind_choices.Small = get_new_boss()
        
    elseif G.GAME.round_resets.blind_states.Big == "Upcoming" then
        if G.GAME.round_resets.cookie_increment and G.GAME.round_resets.cookie_increment.Big then
            G.GAME.round_resets.cookie_increment.Big = nil
        end
        G.GAME.round_resets.blind_choices.Big = get_new_boss()
    elseif G.GAME.round_resets.blind_states.Boss == "Upcoming" then 
        if G.GAME.round_resets.cookie_increment and G.GAME.round_resets.cookie_increment.Boss then
            G.GAME.round_resets.cookie_increment.Boss = nil
        end
        G.GAME.round_resets.blind_choices.Boss = get_new_boss()
    else
        
    end
end
SMODS.Joker {
    key = 'unik_epic_blind_sauce',
    atlas = 'unik_epic',
    rarity = 3,
	pos = { x = 0, y = 1 },
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = false,
    demicoloncompat = true,
    config = { extra = { EEmult = 1,destroyed = false,triggers = 5,Emult = 1,trigger_mod = 5, Mult = 100, Chips = 50}, immutable = {base_emult = 1.0} },
    loc_vars = function(self, info_queue, center)
        local key = "j_unik_epic_blind_sauce"
        if not unik_config.unik_legendary_blinds then
            key = "j_unik_epic_blind_sauce_no_epic"
            return { key = key, vars = {center.ability.extra.Mult,center.ability.extra.Chips,center.ability.extra.Emult + center.ability.immutable.base_emult} }
        else
             return { key = key, vars = {center.ability.extra.Mult,center.ability.extra.Chips,center.ability.extra.Emult + center.ability.immutable.base_emult} }
        end
        
		
	end,
    calculate = function(self, card, context)
        --dont try to force trigger it. It will self destruct and guarantee an epic blind.
        if context.forcetrigger and not card.ability.extra.destroyed then
            card.ability.extra.destroyed = true
            selfDestruction(card,"k_drank_ex",G.C.UNIK_VOID_COLOR) 
            ForceEpicBlind()
            return {
                
            }
        end
        if context.after and SMODS.last_hand_oneshot and not context.blueprint then
            card.ability.extra.destroyed = true
            selfDestruction(card,"k_drank_ex",G.C.UNIK_VOID_COLOR)
            ForceEpicBlind()
        end
        if context.joker_main and not card.ability.extra.destroyed then
            
            -- if (context.blueprint_card or context.retrigger_joker or context.repetition) and not card.ability.extra.destroyed then
            --     card.ability.extra.destroyed = true
            --     selfDestruction(card,"k_drank_ex",G.C.UNIK_VOID_COLOR)
            --     ForceEpicBlind()
            -- end
            if not card.ability.extra.destroyed then
                -- if not (context.blueprint_card or context.retrigger_joker or context.repetition) then
                --     card.ability.extra.triggers = card.ability.extra.triggers - 1
                -- end
                return {
                        mult = card.ability.extra.Mult,
                        chips = card.ability.extra.Chips,
                        e_mult = card.ability.extra.Emult + card.ability.immutable.base_emult,
                        -- colour = G.C.DARK_EDITION,
                    } 
            end
        end
        -- if context.end_of_round and context.cardarea == G.jokers and not card.ability.extra.destroyed then
		-- 	if card.ability.extra.triggers > 0 then
                
        --     end
		-- end
        -- if context.setting_blind then
		-- 	card.ability.extra.triggers = card.ability.extra.trigger_mod
		-- end
    end
}