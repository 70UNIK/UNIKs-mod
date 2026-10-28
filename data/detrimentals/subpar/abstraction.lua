-- -15 chips per joker owned, self destructs after destroying 3 jokers.
UNIK.detriment{
    key = "unik_abstraction",
    atlas = "unik_detriments",
	pos = { x = 3, y = 5 },
    config = { extra = { chip_mod = -15, jokers_destroyed = 0,jokers_to_destroy = 4} }, --why emult? 
    severity = 1,
    immutable = true,
    dongtong_compat = false,
    blueprint_compat = true,
    attributes = { 'detrimental','chips','joker','detriment'},
    loc_vars = function(self, info_queue, card)
        local summation = G.jokers and card.ability.extra.chip_mod * #G.jokers.cards or 0
        return { vars = { card.ability.extra.chip_mod,summation,card.ability.extra.jokers_to_destroy,card.ability.extra.jokers_destroyed} }
	end,
    calculate = function(self, card, context)
        if context.joker_main and G.jokers then
            if #G.jokers.cards > 0 then
                return {
                    chips = card.ability.extra.chip_mod * #G.jokers.cards
                }
            end
           
        end
		if context.unik_other_joker_destroy and not context.blueprint and context.card and context.card ~= card  and not context.blueprint  then
            card.ability.extra.jokers_destroyed = card.ability.extra.jokers_destroyed + 1
            if card.ability.extra.jokers_destroyed >= card.ability.extra.jokers_to_destroy then
                selfDestruction(card,"k_unik_abstract_throw_away",G.C.BLACK)
            else
                return{
                    message = card.ability.extra.jokers_destroyed .. "/" .. card.ability.extra.jokers_to_destroy,
                    colour = G.C.BLACK,
                }
            end
        end
    end,
}