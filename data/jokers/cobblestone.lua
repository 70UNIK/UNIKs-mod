--rankless and suitless cards have a 1 in 2 chance to NOT give x1.5 chips
SMODS.Joker {
    key = 'unik_cobblestone',
    atlas = 'placeholders',
    rarity = 2,
	pos = { x = 1, y = 0 },
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    demicoloncompat = true,
    config = { extra = {odds = 2,x_chips = 1.5} },
    loc_vars = function(self, info_queue, center)
        return { 
            vars = {center and cry_prob(center.ability.cry_prob,center.ability.extra.odds_money,center.ability.cry_rigged)or 1,center.ability.extra.odds, 
        center.ability.extra.x_chips} }
	end,
    in_pool = function()
        local stoneCards = 0
        if G.deck then 
            for i, w in pairs(G.deck.cards) do
                if SMODS.has_no_suit(w) and SMODS.has_no_rank(w) then
                    stoneCards = stoneCards + 1
                end
            end
        end
        if stoneCards >= 1 then
            return true
        end
        return false
	end,
    calculate = function(self, card, context)
        if context.forcetrigger then
            return {
                p_dollars = card.ability.extra.p_dollars,
                mult = card.ability.extra.mult,
                card = card,
            }
        end
        if context.individual and context.cardarea == G.play then
            -- if a seven
            if SMODS.has_no_rank(context.other_card) and SMODS.has_no_suit(context.other_card) then
                if not (pseudorandom('unik_cobblestone') < cry_prob(card.ability.cry_prob,card.ability.extra.odds,card.ability.cry_rigged)/card.ability.extra.odds) then
                    return {
                         message = localize({
                            type = "variable",
                            key = "a_xchips",
                            vars = { number_format(card.ability.extra.x_chips) },
                        }),
                        Xchip_mod = card.ability.extra.x_chips,
                        colour = G.C.CHIPS,
                    }
                end
			end
        end
    end,
}