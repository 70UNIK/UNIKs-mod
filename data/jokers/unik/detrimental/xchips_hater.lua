--XCHIPS IS NOT VANILLA! - if an exchips joker+ is triggered, it is destroyed instead of scoring. self destructs if no xchips triggers occur for the next 6 consecutive rounds.
SMODS.Joker {
    key = 'unik_xchips_hater',
    atlas = 'placeholders',
    rarity = 'unik_detrimental',
	no_dbl = true,
	pos = { x = 3, y = 1 },
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
        if context.xchips_hater then
            card.ability.extra.xchips_triggered = true
            return{
                message = localize("k_unik_xchips_not_vanilla" .. math.random(1,4)),
                colour = G.C.RED,
            }
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