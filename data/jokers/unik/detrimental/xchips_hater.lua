--XCHIPS IS NOT VANILLA! - if an exchips joker+ is triggered, it is destroyed instead of scoring. self destructs if no xchips triggers occur for the next 6 consecutive rounds.
SMODS.Joker {
    key = 'unik_xchips_hater',
    atlas = 'unik_cursed',
    rarity = 'unik_detrimental',
	no_dbl = true,
	pos = { x = 2, y = 3 },
    cost = 0,
	blueprint_compat = false,
    perishable_compat = false,
	eternal_compat = false,
    immutable = true,
    config = { extra = {rounds = 0,round_limit = 6,xchips_triggered = false} },
    loc_vars = function(self, info_queue, center)
        return { 
            vars = { center.ability.extra.round_limit,center.ability.extra.rounds } }
    end,
    calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers and not context.repetition and not context.blueprint then
            if not card.ability.extra.xchips_triggered then
                card.ability.extra.rounds = card.ability.extra.rounds + 1
            else
                card.ability.extra.xchips_triggered = false
            end
            
            if card.ability.extra.rounds > card.ability.extra.round_limit then
                selfDestruction(card,"k_extinct_ex",G.C.BLACK)
            elseif not card.ability.extra.xchips_triggered then
                return{
                    message = card.ability.extra.rounds .. "/" .. card.ability.extra.round_limit,
                    colour = G.C.RED,
                }
            end
        end
        if context.destroy_card and context.destroy_card.ability.fuck_xchips then
            context.destroy_card.gore_6_destruction = true
            card.ability.extra.xchips_triggered = true
			return { 
                remove = true,
            }
		end
        if context.post_trigger and context.other_ret and context.other_card then
            if context.other_ret.jokers and not context.other_card.ability.gored6 then
                if context.other_ret.jokers.x_chips or context.other_ret.jokers.e_chips or context.other_ret.jokers.ee_chips or context.other_ret.jokers.eee_chips or context.other_ret.jokers.hyper_chips then
                    if context.cardarea == G.jokers then
                        card.ability.extra.xchips_triggered = true
                        context.other_card.ability.gored6 = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.jokers:remove_card(context.other_card)
                                context.other_card:gore6_break()
                                
                                card:juice_up(2, 0.5)
                                return true
                            end,
                        }))
                        card_eval_status_text(card, "extra", nil, nil, nil, {
                            message = localize('k_unik_xchips_not_vanilla' .. math.random(1,4)),
                            colour = G.C.RED,
                            card=card,
                        })
                    else
                        context.other_card.ability.fuck_xchips = true
                    end
                end
            end
            
        end
    end,
    in_pool = function()
        G.GAME.unik_xchips_triggers = G.GAME.unik_xchips_triggers or 0
        if G.GAME.unik_xchips_triggers > 5 then
            return true
        end
        return false
	end,
} 