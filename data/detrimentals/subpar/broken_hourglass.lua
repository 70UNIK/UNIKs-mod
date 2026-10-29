-- -$2 per discard used, self destructs after 7 rounds without using any discards
UNIK.detriment{
    key = "unik_broken_hourglass",
    atlas = "unik_detriments",
	pos = { x = 2, y = 5 },
    config = { extra = { money_mod = 2, rounds = 7, rounds_done = 0} }, --why emult? 
    severity = 1,
    immutable = true,
    dongtong_compat = false,
    blueprint_compat = true,
    attributes = { 'detrimental','mult','detriment'},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money_mod,card.ability.extra.rounds,card.ability.extra.rounds_done} }
	end,
    calculate = function(self, card, context)
		if context.discard and (#context.full_hand == 0 or context.other_card == context.full_hand[#context.full_hand]) and not context.blueprint  then
            return{
                dollars = -card.ability.extra.money_mod,
                    delay = 0.45,
                    func = function() -- This is for timing purposes, it runs after the dollar manipulation
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.dollar_buffer = 0
                                return true
                            end
                        }))
                    end
            }
        end
        if context.end_of_round and context.cardarea == G.unik_detriment_area and not context.repetition and not context.blueprint and G.GAME.current_round.discards_used == 0 then
                card.ability.extra.rounds_done = card.ability.extra.rounds_done + 1
                if card.ability.extra.rounds_done > card.ability.extra.rounds then
                    selfDestruction(card,"k_unik_smashed",G.C.BLACK)
                else
                    return{
                        message = card.ability.extra.rounds_done .. "/" .. card.ability.extra.rounds,
                        colour = G.C.BLACK,
                    }
                end
            
        end
    end,
}