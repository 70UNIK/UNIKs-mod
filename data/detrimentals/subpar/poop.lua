UNIK.detriment{
    key = "unik_poop",
    atlas = "unik_detriments",
	pos = { x = 3, y = 0 },
    config = { extra = { mult = -3, discards = 20,curr_discards = 0} }, --why emult? 
    severity = 1,
    immutable = true,
    dongtong_compat = false,
    blueprint_compat = true,
    attributes = { 'detrimental','mult','detriment', 'immediate'},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult,card.ability.extra.discards,card.ability.extra.curr_discards} }
	end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
		if context.discard and context.other_card == context.full_hand[#context.full_hand] and not context.blueprint  then
            card.ability.extra.curr_discards = card.ability.extra.curr_discards + 1
            if card.ability.extra.curr_discards > card.ability.extra.discards then
                selfDestruction(card,"k_unik_poop_remove",G.C.BLACK)
            else
                return{
                    message = card.ability.extra.curr_discards .. "/" .. card.ability.extra.discards,
                    colour = G.C.BLACK,
                }
            end
        end
    end,
}