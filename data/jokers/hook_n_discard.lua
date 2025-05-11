SMODS.Joker {
    dependencies = {
		items = {
			"set_cry_cursed",
		},
	},
	key = 'unik_hook_n_discard',
    atlas = 'unik_cursed',
    rarity = "cry_cursed",
	pos = { x = 1, y = 2 },
    cost = 1,
    config = { extra = { min_discards = 12, discarded_cards = 2, current_discards = 0} },
    pools = { ["unik_boss_blind_joker"] = true},
	blueprint_compat = false,
    perishable_compat = false,
    eternal_compat = false,
    unique = true,
    experimental = true,
    no_dbl = true,
    immutable = true,
    gameset_config = {
		modest = {extra = { min_discards = 6, discarded_cards = 2, current_discards = 0} },
	},
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.min_discards, center.ability.extra.discarded_cards, center.ability.extra.current_discards} }
	end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_unik_blind_start_hook'), G.C.UNIK_THE_HOOK, G.C.WHITE, 1.0 )
    end,
    add_to_deck = function(self, card, from_debuff)
        --avoid creating multiple hooks to avoid multiple hook bug
        if G.jokers and G.jokers.cards then
            for i,v in pairs(G.jokers.cards) do
                if v.config.center.key == "j_unik_hook_n_discard" then
                    selfDestruction(card,"k_unik_weapon_destroyed",G.C.UNIK_THE_HOOK)
                    local card2 = create_card("Joker", G.jokers, nil, "cry_cursed", nil, nil, nil, "unik_hook_replacement")
                    card2:add_to_deck() --This causes problems. Why?
                    G.jokers:emplace(card2)
                end
            end
        end
    end,
    calculate = function(self, card, context)
        --check discards
        if context.discard and context.other_card == context.full_hand[#context.full_hand] then
            if #context.full_hand == 2 then
                card.ability.extra.current_discards = card.ability.extra.current_discards + 1
                if to_big(card.ability.extra.current_discards) >= to_big(card.ability.extra.min_discards) then
                    selfDestruction(card,"k_unik_weapon_destroyed",G.C.UNIK_THE_HOOK)
                    --return true
                else
                    return {
                        message = localize({type='variable',key='a_unik_discards_1',vars={card.ability.extra.current_discards}}),
                        colour = G.C.UNIK_THE_HOOK,
                        card = card,
                    }
                end

            elseif to_big(card.ability.extra.current_discards) > to_big(0) then
                card.ability.extra.current_discards = 0
                return {
                    message = localize('k_reset'),
                    colour = G.C.UNIK_THE_HOOK,
                }
            end
        end
        --self destruct during the hook
        if context.setting_blind and (G.GAME.blind and (G.GAME.blind.config.blind.name == "The Hook")) and not (G.GAME.blind.disabled) then
            selfDestruction(card,"k_unik_blind_start_hook",G.C.UNIK_THE_HOOK)
        end
    end
}
if JokerDisplay then
	JokerDisplay.Definitions["j_unik_hook_n_discard"] = {
		text = {
			{ ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.FILTER},
		},
        reminder_text = {
			{
				ref_table = "card.joker_display_values",
				ref_value = "stuff",
				colour = G.C.UI.TEXT_INACTIVE,
			},		
		},
        calc_function = function(card)
            card.joker_display_values.localized_text = "(" .. card.ability.extra.current_discards .. "/" .. card.ability.extra.min_discards .. ")"
            card.joker_display_values.stuff = "(2x" .. localize("k_unik_cards") ..")"
        end
	}
end
--Hook does not work as it will select cards to discard DURING play! Joker context before does not work as it wont discard them!
-- local pcfh2 = G.FUNCS.play_cards_from_highlighted
-- function G.FUNCS.play_cards_from_highlighted(e)
-- 	G.GAME.before_play_buffer = true
--     if G.jokers then
--         for _, v in pairs(G.jokers.cards) do
--             if v.ability.name == "j_unik_hook_n_discard" then
--                 --taken from the hook
--                 G.E_MANAGER:add_event(Event({ 
--                     trigger = 'immediate',
--                     func = function()
--                     local any_selected = nil
--                     local _cards = {}
--                     for k, v in ipairs(G.hand.cards) do
--                         _cards[#_cards+1] = v
--                     end
--                     for i = 1, 2 do
--                         if G.hand.cards[i] then 
--                             local selected_card, card_key = pseudorandom_element(_cards, pseudoseed('hook'))
--                             G.hand:add_to_highlighted(selected_card, true)
--                             table.remove(_cards, card_key)
--                             any_selected = true
--                             play_sound('card1', 1)
--                         end
--                     end
--                     if any_selected then G.FUNCS.discard_cards_from_highlighted(nil, true) end
--                     if any_selected then
--                         v:juice_up(0.8, 0.8)
--                     end
--                 return true end })) 
--                 card_eval_status_text(v, "extra", nil, nil, nil, {
--                     message = localize("k_unik_hooked"),
--                     colour = G.C.UNIK_THE_HOOK,
--                     card=v,
--                 })
--             end
--         end
--     end
-- 	pcfh2(e)
-- 	G.GAME.before_play_buffer = nil
-- end