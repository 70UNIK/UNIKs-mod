SMODS.Joker {
    key = 'unik_skipping_stones',
    atlas = 'unik_common',
	pos = { x = 1, y = 1 },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    config = { extra = {retriggers = 1},immutable = {max_retriggers = 50} },
    loc_vars = function(self, info_queue, center)
        return { 
            vars = {math.min(center.ability.extra.retriggers,center.ability.immutable.max_retriggers)} 
        }
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
        if context.repetition and context.cardarea == G.play then
            if SMODS.has_no_rank(context.other_card) and SMODS.has_no_suit(context.other_card) then
                local rep = math.min(card.ability.extra.retriggers,card.ability.immutable.max_retriggers)
                if rep > 0 then
                    return {
                        message = localize("k_again_ex"),
                        repetitions = to_number(
                            rep
                        ),
                        card = card,
                    }
                end  
            end
		end
    end,
}