UNIK.detriment{
    key = "unik_office_drone",
    atlas = "unik_detriments",
	pos = { x = 1, y = 2 },
    config = { extra = { chips = -35,hands_no_most = 9,hands = 0 } }, --why emult? 
    severity = 1,
    immutable = true,
    dongtong_compat = false,
    blueprint_compat = true,
    attributes = { 'detrimental','chips','detriment', 'immediate'},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips,card.ability.extra.hands_no_most,card.ability.extra.hands} }
	end,
    calculate = function(self, card, context)
		if context.after and not context.blueprint then
            local reset = true
            local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
            for handname, values in pairs(G.GAME.hands) do
                if handname ~= context.scoring_name and values.played >= play_more_than and SMODS.is_poker_hand_visible(handname) then
                    reset = false
                    break
                end
            end
            if reset then
                if card.ability.extra.hands > 0 then
                    card.ability.extra.hands = 0
                    return {
                        message = localize('k_reset'),
                        colour = G.C.BLACK,
                    }
                end
            else
                -- See note about SMODS Scaling Manipulation on the wiki
                card.ability.extra.hands = card.ability.extra.hands + 1
                if card.ability.extra.hands >= card.ability.extra.hands_no_most then
                    selfDestruction(card,"k_unik_fight_club_quit",G.C.BLACK)
                else
                    return{
                        message = card.ability.extra.hands .. "/" .. card.ability.extra.hands_no_most,
                        colour = G.C.BLACK,
                    }
                end
            end
        end
        if context.joker_main and context.scoring_name then
            local reset = true
            local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
            for handname, values in pairs(G.GAME.hands) do
                if handname == context.scoring_name and values.played >= play_more_than and SMODS.is_poker_hand_visible(handname) then
                    reset = false
                    break
                    
                end
            end
            if reset then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end,
}