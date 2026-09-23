--X1.75 Mult, 1 in 3 chance to play selected cards when selected --> X2.5 Mult, 1 in 7 chance to play selected cards when selected
BLINDSIDE.Blind({
    key = 'unik_blindside_gun',
    atlas = 'unik_blindside_blinds',
    pos = {x = 3, y = 0},
    config = {
        extra = {
            value = 14,
            x_mult = 1.75,
            x_mult_up = 0.75,
            chance = 3,
            base_chance = 1,
            chance_up = 3,
        }},
    hues = {"Yellow"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.main_scoring then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
        if context.unik_triggering then 
            if (context.selected_card == card) then
                if SMODS.pseudorandom_probability(card, pseudoseed('unik_the_gun'), card.ability.extra.base_chance, card.ability.extra.chance, 'unik_the_gun') then
                    play_sound('unik_gunshot')
                    card:juice_up(1.25,1.25)
                    return {
                        finger_triggered = true,
                    }
                end
            end

            
		end
    end,
    common = true,
    loc_vars = function(self, info_queue, card)
        local chance, trigger = SMODS.get_probability_vars(card, card.ability.extra.base_chance, card.ability.extra.chance, 'unik_the_gun')
        return {
            vars = {
                card.ability.extra.x_mult,
                chance,
                trigger,
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_up
            card.ability.extra.chance = card.ability.extra.chance + card.ability.extra.chance_up
            card.ability.extra.upgraded = true
        end
    end
})
--eval G.hand.cards[1]:set_ability('m_unik_blindside_halved')