--Retrigger all held in consumeable effects (not using consumeables)
--Observatory, moonlight cookie/celestial of chaos, scratch, maybe even color cards???????
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_double_container',
    atlas = 'placeholders',
    rarity = 2,
	pos = { x = 1, y = 0 },
	-- Modest
    config = { 
        extra = { retriggers = 1},
        immutable = { max_retriggers = 50 },
    },
    cost = 5,
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    loc_vars = function(self, info_queue, center)
		return { vars = {math.min(center.ability.extra.retriggers,center.ability.immutable.max_retriggers)} }
	end,
    in_pool = function(self, args)
        local hasColor = nil
        if MoreFluff and G.consumeables and G.consumeables.cards then
            for i=1, #G.consumeables.cards do
                if G.consumeables.cards[i].ability.set == 'Colour' then
                    hasColor = true
                end
            end
        end
        if 
            #SMODS.find_card("j_unik_moonlight_cookie") > 0 or 
            #SMODS.find_card("j_unik_scratch") > 0 or 
            #SMODS.find_card("j_mf_rainbow_joker") or

            G.GAME.used_vouchers.v_observatory or
            hasColor then
			return true
		end
		return false
    end,
    calculate = function(self, card, context)
		if context.retrigger_joker_check and context.other_card ~= self and context.other_context.other_consumeable then
            return {
                message = localize('k_again_ex'),
                repetitions = math.min(card.ability.extra.retriggers,card.ability.immutable.max_retriggers),
                card = card
            }
        end
        --mf colour cards
        if MoreFluff and context.end_of_round and context.cardarea == G.jokers and context.other_card ~= self then
            
            for i=1, #G.consumeables.cards do
                if G.consumeables.cards[i].ability.set == 'Colour' then
                    for j=1, math.min(card.ability.extra.retriggers,card.ability.immutable.max_retriggers) do
                        card_eval_status_text(card, "extra", nil, nil, nil, {
                            message = localize('k_again_ex'),
                            card = card,
                        })
                        trigger_colour_end_of_round(G.consumeables.cards[i])    
                    end
                    
                end            
            end
            return{

            }
        end
	end
}