    BLINDSIDE.Blind({
        key = 'unik_blindside_lily',
        atlas = 'unik_blindside_blinds',
        pos = {x = 4, y = 8},
        config = {
            --forced_selection = true,
            extra = {
                value = 30,
                jokeremult = 1.2,
                jokeremultdown = 0.25,
            }},
        hues = {"Faded","Red"},
        curse = true,
        always_scores = true,
        hidden = true,
        calculate = function(self, card, context)
            -- if card.ability.extra.upgraded then
            --     card.ability.forced_selection = false
            -- end
            -- if tableContains(card, G.hand.cards) and not tableContains(card, G.hand.highlighted) and #G.hand.highlighted < 5 and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED and not card.ability.extra.upgraded then
            --     card.ability.forced_selection = true
            --     G.hand:add_to_highlighted(card, true)
            -- end

            -- if context.after and not card.ability.extra.upgraded then
            --     card.ability.forced_selection = false
            -- end
            if context.cardarea == G.play and context.main_scoring then
                UNIK.blindside_chips_modifyV2({e_mult = card.ability.extra.jokeremult }) 
               return {
                    message = "^" .. card.ability.extra.jokeremult .. localize('k_unik_jmult'),
                    colour = G.C.BLACK,
                    focus = context.blueprint_card or card,
                }
        end
        end,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
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