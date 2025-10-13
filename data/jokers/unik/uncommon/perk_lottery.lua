SMODS.Joker {
    key = "unik_perk_lottery",
    atlas = 'placeholders',
    rarity = 2,
    cost = 6,
    pos = { x = 1, y = 0 },
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    immutable = true,
    config = {extra = {prob = 1, odds = 2,choices = 1}},
    pronouns = "it_its",
    enhancement_gate = 'm_glass',
    loc_vars = function(self, info_queue, center)
        local new_numerator, new_denominator = SMODS.get_probability_vars(center, center.ability.extra.prob, center.ability.extra.odds, 'unik_plottery')
        return { 
           vars = {new_numerator, new_denominator,center.ability.extra.choices} }
	end,
    calculate = function(self, card, context)
        if context.unik_selecting_booster_option and context.cards_left then
            if G.GAME.pack_choices and to_big(#context.cards_left) > to_big(0) then
                if not SMODS.pseudorandom_probability(card, 'unik_plottery', card.ability.extra.prob, card.ability.extra.odds, 'unik_plottery') then
                    G.GAME.pack_choices = G.GAME.pack_choices + 1
                    return {
                        message = "+1",
                        card=card,
                    }
                end
            end
            
        end
    end
}