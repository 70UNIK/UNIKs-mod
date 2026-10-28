-- -25 Chips if hand does not contain a straight, self destructs if played hand contains a straight flush.
UNIK.detriment{
    key = "unik_straightjacket",
    atlas = "unik_detriments",
	pos = { x = 7, y = 2 },
    config = { extra = { chips = -28, hand = 'Straight',destroy_hand = 'Straight Flush'} }, --why emult? 
    severity = 1,
    immutable = true,
    dongtong_compat = false,
    blueprint_compat = true,
    attributes = { 'detrimental','chips','hand_type','detriment'},
    loc_vars = function(self, info_queue, card)

        return { vars = { card.ability.extra.chips} }
	end,
    calculate = function(self, card, context)
        if context.joker_main and not next(context.poker_hands[card.ability.extra.hand]) then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.after and next(context.poker_hands[card.ability.extra.destroy_hand]) and not context.blueprint then
            selfDestruction(card,"k_unik_manacle_big",G.C.BLACK)
        end 
    end,
}