--while held, each blind has a 1 in 8 chance to play selected blinds when selected, stubborn
--X3 Mult, when selected has a 1 in 5 chance to play selected blinds
BLINDSIDE.Blind({
    key = 'unik_blindside_impatience',
    atlas = 'unik_blindside_blinds',
    pos = {x = 2, y = 7},
    config = {
        extra = {
            value = 30,
            x_mult = 3,
            chance = 8,
            base_chance = 1,
            chance_down = 3,
            retain = true,
            stubborn = true,
        }},
    hues = {"Purple"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.main_scoring and card.ability.extra.upgraded then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
        if context.unik_triggering then 
            if (context.selected_card == card) or (not card.ability.extra.upgraded and context.selected_card.area == G.hand) then
                if SMODS.pseudorandom_probability(card, pseudoseed('unik_impatience'), card.ability.extra.base_chance, card.ability.extra.chance, 'unik_impatience') then
                    play_sound('unik_gunshot')
                    card:juice_up(1.25,1.25)
                    return {
                        finger_triggered = true,
                    }
                end
            end

            
		end
    end,
    curse = true,
    loc_vars = function(self, info_queue, card)
        if not  card.ability.extra.upgraded then
             info_queue[#info_queue+1] = {key = 'bld_stubborn', set = 'Other'}
            info_queue[#info_queue+1] = {key = 'bld_retain', set = 'Other'}  
        else

        end
        local chance, trigger = SMODS.get_probability_vars(card, card.ability.extra.base_chance, card.ability.extra.chance, 'unik_impatience')
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_impatience_upgraded' or 'm_unik_blindside_impatience',
            vars = {
                chance,
                trigger,
                card.ability.extra.x_mult,
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.chance = card.ability.extra.chance - card.ability.extra.chance_down
            card.ability.extra.retain = nil
            card.ability.extra.stubborn = nil
            card.ability.extra.upgraded = true
        end
    end
})