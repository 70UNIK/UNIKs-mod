--1 in 2 chance for ^1.2 Mult, otherwise ^1.15 Chips
BLINDSIDE.Blind({
    key = 'unik_blindside_epic_flip',
    atlas = 'unik_blindside_epic_blinds',
    pos = {x = 0, y = 3},
    config = {
        extra = {
            value = 1,
            trigger = 2,
            chance = 1,
            e_mult = 1.25,
            e_mult_up = 0.15,
            e_chips = 1.2,
            e_chips_up = 0.15,
            x_mult = 2.5,
            x_mult_up = 1.5,
            x_chips = 2.5,
            x_chips_up = 1.5,
        }},
    hues = {"Green","Purple"},
    calculate = function(self, card, context) 
        if SMODS.in_scoring(card,context.scoring_hand) and context.final_scoring_step then
            if SMODS.pseudorandom_probability(card, pseudoseed("flip_alternate"), card.ability.extra.chance, card.ability.extra.trigger, 'flip_alternate') then
                if pseudorandom('flip_alternate_middle') < 0.5 then
                    return {
                        e_mult = card.ability.extra.e_mult
                    }        
                else
                    return {
                        e_chips = card.ability.extra.e_chips
                    }
                end
            else
                if pseudorandom('flip_alternate_middle') < 0.5 then
                    return {
                        x_mult = card.ability.extra.x_mult
                    }        
                else
                    return {
                        x_chips = card.ability.extra.x_chips
                    }
                end
            end
        end
    end,
    unik_ancient = true,
    loc_vars = function(self, info_queue, card)
        local chance, trigger = SMODS.get_probability_vars(card, card.ability.extra.chance, card.ability.extra.trigger, 'flip_alternate')
        return {
            vars = {
                chance,trigger,card.ability.extra.e_mult,card.ability.extra.e_chips,card.ability.extra.x_mult,card.ability.extra.x_chips
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.e_mult = card.ability.extra.e_mult + card.ability.extra.e_mult_up
            card.ability.extra.e_chips = card.ability.extra.e_chips + card.ability.extra.e_chips_up
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_up
            card.ability.extra.x_chips = card.ability.extra.x_chips + card.ability.extra.x_chips_up
            card.ability.extra.upgraded = true
        end
    end
})