--1 in 3 chance to set joker operator to addition then ^2.5 joker's mult
    BLINDSIDE.Blind({
        key = 'unik_blindside_descending',
        atlas = 'unik_blindside_blinds',
        pos = {x = 4, y = 1},
        config = {
            extra = {
                value = 100,
                chance = 3,
                trigger = 5,
                chancedown = -2,
                j_e_mult = 1.75,
                j_e_mult_down = 0.35,
            }
        },
        hues = {"Purple", "Blue"},
        always_scores = true,
        rare = true,
        calculate = function(self, card, context)
            if context.cardarea == G.play and context.before and card.facing ~= 'back' then
                if not SMODS.pseudorandom_probability(card, pseudoseed("descflip"), card.ability.extra.chance, card.ability.extra.trigger, 'descflip') and card.facing ~= "back" then
                    card:flip()
                    card:flip()
                else
                    if card.facing ~= 'back' then 
                    card:flip()
                    end
                end
            end
            if context.cardarea == G.play and context.main_scoring then
                if card.facing ~= "back" then
                    UNIK.operator(-1)
                    card.ability.extra.succeed = true
                    
                    UNIK.blindside_chips_modifyV2({e_mult = card.ability.extra.j_e_mult}) 
                    return {
                        message = "^" .. card.ability.extra.j_e_mult .. localize('k_unik_jmult'),
                        colour = G.C.BLACK,
                        focus = card,
                    }
                else
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
            card.ability.extra.j_e_mult = card.ability.extra.j_e_mult - card.ability.extra.j_e_mult_down
            
            card.ability.extra.upgraded = true
            end
        end
})
function UNIK.operator(arrow)
     G.E_MANAGER:add_event(Event({trigger = 'immediate', delay = 0, func = function()
        local container = G.HUD_blind:get_UIE_by_ID('unik_operator_text_7777')
        if container then
            play_sound('button', 1.1, 0.65)
            if arrow == -1 then
                G.GAME.unik_current_operator = arrow
                container:juice_up()
            -- G.GAME.blind.hand_operator_container:juice_up()
                container.config.text = "+"
                
            else
                G.GAME.unik_current_operator = 0
                container:juice_up()
                container.config.text = "X"
            end
            G.HUD_blind:recalculate()
        end
        
        
        return true
    end}))
    
end
function UNIK.arrowfunction(operator,first,second)
    if operator == -1 then
        return first + second
    elseif operator == 0 then
        return first * second
    elseif operator == 1 then
        return first ^ second
    end
    return first * second
end

local defeatHook = Blind.defeat
function Blind:defeat(silent)
    local ret = defeatHook(self,silent)
    G.GAME.unik_current_operator = G.GAME.unik_current_operator or 0
    if G.GAME.unik_current_operator ~= 0 then
        UNIK.operator(0)
    end
    return ret
end
--eval G.hand.cards[1]:set_ability('m_unik_blindside_descending')