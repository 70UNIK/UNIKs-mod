UNIK.detriment{
    key = "unik_robert",
    atlas = "unik_detriments",
	pos = { x = 4, y = 0 },
    config = { extra = { odds = 7, flipped_cards = {} , min_facedowns = 5} },
    severity = 2,
    immutable = true,
    dongtong_compat = false,
    blueprint_compat = true,
    attributes = { 'detrimental','face-down','detriment','chance'},
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,'unik_wheel')
        return { vars = { 
            new_numerator,
            new_denominator,
            card.ability.extra.min_facedowns,
        } }
    end,
    calculate = function(self, card, context)
        if context.stay_flipped 
        and context.to_area == G.hand 
        and context.other_card 
        and SMODS.pseudorandom_probability(card, 'unik_wheel', 1, card.ability.extra.odds) then
            return {
                stay_flipped = true
            }
        end
        if context.on_select_play and not context.blueprint
        then
            for i,v in pairs(G.playing_cards) do
                v.unik_flipped_check = nil
            end
            for i,v in pairs(G.hand.highlighted) do
                v.unik_flipped_check = true
            end
        end
        if context.after and not context.blueprint then
            local flips = 0
            for i,v in pairs(context.scoring_hand) do
                if v.unik_flipped_check then
                    flips = flips + 1
                end
            end
            if flips >= card.ability.extra.min_facedowns then
                selfDestruction(card,"k_unik_wheel_burst",G.C.UNIK_THE_WHEEL)
            end
            
        end
        if context.setting_blind and (G.GAME.blind and (G.GAME.blind.config.blind.name == "The Wheel")) and not (G.GAME.blind.disabled) and not context.blueprint
        and not context.retrigger_joker then
            selfDestruction(card,"k_unik_blind_start_wheel",G.C.UNIK_THE_WHEEL)
        end
    end,
}