--middlemost card gives -66 Chips and X0.5 mult, self destructs after playing 7 consecutive hands that are high card
UNIK.detriment{
    key = "unik_middle_finger",
    atlas = "unik_detriments",
	pos = { x = 5, y = 4 },
    config = { extra = { chips = -50,x_mult = 0.5,hands = 4,hands_played = 0} }, --why emult? 
    severity = 2,
    immutable = true,
    dongtong_compat = false,
    blueprint_compat = true,
    attributes = { 'detrimental','xmult','chips','detriment'},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips,card.ability.extra.x_mult,card.ability.extra.hands,card.ability.extra.hands_played} }
	end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local middle = math.ceil(#context.scoring_hand/2)
            if context.scoring_hand[middle] == context.other_card then
                 return {
                    chips = card.ability.extra.chips,
                    x_mult = card.ability.extra.x_mult,
                }
            end
           
        end
        if context.after and not context.blueprint then
            local middle = math.ceil(#context.scoring_hand/2)
            if context.scoring_hand[middle].debuff then
                card.ability.extra.hands_played  = card.ability.extra.hands_played  + 1
                if card.ability.extra.hands_played  > card.ability.extra.hands then
                    selfDestruction(card,"k_unik_goading_fuck_you",G.C.BLACK)
                else
                    return{
                        message = card.ability.extra.hands_played  .. "/" .. card.ability.extra.hands,
                        colour = G.C.BLACK,
                    }
                end
            end
            
        end
    end,
}