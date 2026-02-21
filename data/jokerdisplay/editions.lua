JokerDisplay.Edition_Definitions["e_unik_shining_glitter"] = {
    condition_function = function(card)
        return not card.debuff and card.edition and card.edition.x_chips
    end,
    mod_function = function(card)
        return { x_chips = card.edition.x_chips }
    end
}
JokerDisplay.Edition_Definitions["e_unik_steel"] = {
    condition_function = function(card)
        return not card.debuff and card.edition and card.edition.x_mult
    end,
    mod_function = function(card)
        return { x_mult = card.edition.x_mult }
    end
}
JokerDisplay.Edition_Definitions["e_unik_fuzzy"] = {
    condition_function = function(card)
        return not card.debuff and card.edition and card.edition.max_dollars
    end,
    mod_function = function(card)
        local mult = pseudorandom("unik_fuzzy_mult2",card.edition.min_mult,card.edition.max_mult)
        local chips = pseudorandom("unik_fuzzy_chips2",card.edition.min_chips,card.edition.max_chips)
        local dollars = pseudorandom("unik_fuzzy_chips2",card.edition.min_dollars,card.edition.max_dollars)
        return { mult = mult, chips = chips, dollars = dollars }
    end
}
JokerDisplay.Edition_Definitions["e_unik_corrupted"] = {
    condition_function = function(card)
        return not card.debuff and card.edition and card.edition.echips

    end,
    mod_function = function(card)
        return { e_mult = card.edition.emult, e_chips = card.edition.echips }
    end
}