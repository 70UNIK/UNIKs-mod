--Retrigger all held in consumeable effects (not using consumeables)
--Observatory, moonlight cookie/celestial of chaos, scratch, maybe even color cards???????
local containerrarity = 1
if MoreFluff then
    containerrarity = 2
end
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_double_container',
    atlas = 'unik_uncommon',
    pos = {
        x = 5,
        y = 1
    },
    rarity = containerrarity,
	-- Modest
    config = { 
        extra = { retriggers = 1},
        immutable = { max_retriggers = 50 },
    },
    cost = (4 + containerrarity),
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    loc_vars = function(self, info_queue, center)
        if MoreFluff then
            info_queue[#info_queue + 1] = { set = "Other", key = "unik_held_in_consumables2" }
        elseif Cryptid then
            info_queue[#info_queue + 1] = { set = "Other", key = "unik_held_in_consumables3" }
        else
            info_queue[#info_queue + 1] = { set = "Other", key = "unik_held_in_consumables" }
        end
        
		return { vars = {math.min(center.ability.extra.retriggers,center.ability.immutable.max_retriggers)} }
	end,
    in_pool = function(self, args)
        -- local hasColor = nil
        -- if MoreFluff and G.consumeables and G.consumeables.cards then
        --     for i=1, #G.consumeables.cards do
        --         if G.consumeables.cards[i].ability.set == 'Colour' then
        --             hasColor = true
        --         end
        --     end
        -- end
        if 
            next(find_joker("j_unik_moonlight_cookie")) or 
            next(find_joker("j_unik_scratch")) or 
            next(find_joker("j_mf_rainbow_joker")) or

            G.GAME.used_vouchers.v_observatory or
            MoreFluff then
			return true
		end
		return false
    end,
    calculate = function(self, card, context)
		if (context.retrigger_joker_check) and context.other_card ~= self and (context.other_context and context.other_context.other_consumeable) then
            return {
                message = localize('k_again_ex'),
                repetitions = math.min(card.ability.extra.retriggers,card.ability.immutable.max_retriggers),
                card = card
            }
        end
        --mf colour cards retriggers
        if MoreFluff and context.unik_mf_color_trigger then
            return{
                message = localize('k_again_ex'),
                repetitions = math.min(card.ability.extra.retriggers,card.ability.immutable.max_retriggers),
                card = card
            }
        end
        if context.retrigger_joker_check and context.other_card ~= self and context.other_context and context.other_context.hand_levelup_held_consume then
            return{
                message = localize('k_again_ex'),
                repetitions = math.min(card.ability.extra.retriggers,card.ability.immutable.max_retriggers),
                card = card
            }
        end
	end
}

--umm this suffers from stack overflow with 2 double containers.
if MoreFluff then
    local colorHook = trigger_colour_end_of_round
    function trigger_colour_end_of_round(_card,isTriggered)
        colorHook(_card)
        --buffer to avoid recursion.
        if not isTriggered then
            local eval = {}
            SMODS.calculate_context({unik_mf_color_trigger = true},eval)
            for i = 1, #eval do
                if eval[i].jokers then
                    
                    if eval[i].jokers.repetitions and not isTriggered then
                        for _ = 1, eval[i].jokers.repetitions do
                            card_eval_status_text(eval[i].jokers.card, 'jokers', nil, nil, nil, eval[i].jokers)
                            trigger_colour_end_of_round(_card,true)
                        end
                    end
                end
            end
        end
    end
end