-- -12 Mult if poker hand has already been played this round, self destructs after playing the same hand 10 consecutive times.
UNIK.detriment{
    key = "unik_flock_camera",
    atlas = "unik_detriments",
	pos = { x = 6, y = 3 },
    config = { extra = { mult = -8,last_poker_hand = 'High Card',hands = 7,hands_played = 0} }, --why emult? 
    severity = 1,
    immutable = true,
    dongtong_compat = false,
    blueprint_compat = true,
    attributes = { 'detrimental','mult','hand_type','detriment'},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult,card.ability.extra.hands,card.ability.extra.hands_played,localize(card.ability.extra.last_poker_hand, 'poker_hands')} }
	end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round > 1 then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.after and context.cardarea == G.unik_detriment_area  and not context.blueprint then
            if context.scoring_name == card.ability.extra.last_poker_hand then
                card.ability.extra.hands_played = card.ability.extra.hands_played + 1
                if card.ability.extra.hands_played > card.ability.extra.hands then
                    selfDestruction(card,"k_unik_weapon_destroyed",G.C.BLACK)
                else
                    return{
                        message = card.ability.extra.hands_played .. "/" .. card.ability.extra.hands,
                        colour = G.C.BLACK,
                    }
                end
            else
                card.ability.extra.hands_played = 0
                card.ability.extra.last_poker_hand = context.scoring_name
                return {
                    message = localize('k_reset'),
                    colour = G.C.BLACK,
                }
            end
        end
		
    end,
}