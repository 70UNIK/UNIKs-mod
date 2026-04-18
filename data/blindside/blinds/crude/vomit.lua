-- 1 in 2 chance for ^1.25 Mult to Joker --> 1 in 2 chance for ^0.97 Mult to Joker
    BLINDSIDE.Blind({
        key = 'unik_blindside_vomit',
        atlas = 'unik_blindside_blinds',
        pos = {x = 6, y = 6},
        config = {
            extra = {
                value = 30,
                jokeremult = 1.25,
                jokeremultdown = 0.30,
                base = 1,
                odds = 2
            }},
        hues = {"Green"},
        curse = true,
        calculate = function(self, card, context)
            if context.burn_card and context.cardarea == G.play and context.burn_card == card then
                return { remove = true }
            end
            if context.cardarea == G.play and context.main_scoring then
                if SMODS.pseudorandom_probability(card, pseudoseed('bld_vomit'), card.ability.extra.base, card.ability.extra.odds, 'bld_vomit') then
                     UNIK.blindside_chips_modifyV2({e_mult = card.ability.extra.jokeremult}) 
                    return {
                        message = "^" .. card.ability.extra.jokeremult .. localize('k_unik_jmult'),
                        colour = G.C.BLACK,
                        focus = card,
                    }
                else
                    return {
                        message = localize('k_nope_ex')
                    }
                end
            end
        end,
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
            local n,d = SMODS.get_probability_vars(card, card.ability.extra.base, card.ability.extra.odds,'bld_vomit')
            return {
                vars = {
                    n,
                    d,
                    card.ability.extra.jokeremult,
                }
            }
        end,
        upgrade = function(card)
            if not card.ability.extra.upgraded then
                card.ability.extra.jokeremult = card.ability.extra.jokeremult - card.ability.extra.jokeremultdown
                card.ability.extra.upgraded = true
            end
        end
    })