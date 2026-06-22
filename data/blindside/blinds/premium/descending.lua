--1 in 3 chance to set joker operator to addition then ^2.5 joker's mult
--descending fix: +Mult equal to joker's chips
    BLINDSIDE.Blind({
        key = 'unik_blindside_descending',
        atlas = 'unik_blindside_blinds',
        pos = {x = 4, y = 1},
        config = {
            extra = {
                value = 100,
                chance = 2,
                trigger = 3,
                chancedown = -1,
                j_e_mult = 5,
                j_e_mult_down = 2,
            }
        },
        hues = {"Purple", "Blue"},
        always_scores = true,
        rare = true,
        calculate = function(self, card, context)
            if context.cardarea == G.play and context.before and card.facing ~= 'back' then
                if not SMODS.pseudorandom_probability(card, pseudoseed("descflip"), card.ability.extra.chance, card.ability.extra.trigger, 'descflip') and card.facing ~= "back" and not G.GAME.unik_old_operator then
                    card:flip()
                    card:flip()
                    G.GAME.unik_old_operator = true
                    BLINDSIDE.joker_operator(G.GAME.blindside_current_operator-1)
                    card.ability.extra.succeed = true
                    BLINDSIDE.chipsmodify(0, 0, G.GAME.blind.basechips/4)
                    return {
                        message = localize('k_unik_lowered'),
                        colour = G.C.DARK_EDITION,
                        focus = card,
                    }
                else
                    if card.facing ~= 'back' then 
                    card:flip()
                    end
                    card_eval_status_text(card, "debuff", nil, nil, nil, nil)
                    return {
                    }
                end
            end
            if context.burn_card and context.cardarea == G.play and context.burn_card == card and card.ability.extra.succeed then
                card.ability.extra.succeed = nil
                return { remove = true }
            end
        end,
        loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'unik_self_debuffing', set = 'Other'}
        info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
            local chance, trigger = SMODS.get_probability_vars(card, card.ability.extra.chance, card.ability.extra.trigger, 'descflip')
            return {
                vars = {
                    card.ability.extra.j_e_mult,
                    chance,
                    trigger,
                    colours =  {HEX('cc73d9')}
                }
            }
        end,
        upgrade = function(card) 
            if not card.ability.extra.upgraded then
            card.ability.extra.chance = card.ability.extra.chance + card.ability.extra.chancedown
            card.ability.extra.trigger = card.ability.extra.trigger + card.ability.extra.chancedown
            card.ability.extra.j_e_mult = card.ability.extra.j_e_mult - card.ability.extra.j_e_mult_down
            
            card.ability.extra.upgraded = true
            end
        end
})
local defeatHook = Blind.defeat
function Blind:defeat(silent)
    local ret = defeatHook(self,silent)
    if G.GAME.unik_old_operator then
        BLINDSIDE.joker_operator(G.GAME.blindside_current_operator+1)
        G.GAME.unik_old_operator = nil
    end
    return ret
end
--eval G.hand.cards[1]:set_ability('m_unik_blindside_descending')