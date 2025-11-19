--Fixing bunco's copper cards to be more durable against crossmods as well as open opportunities for quantum enhancements and cyborg (rescore ALL cards when a copper card is rescored)

SMODS.Enhancement:take_ownership("m_bunc_copper",{
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
    end,
    config = {extra = {rescore = 1}},
    calculate = function(self, card, context, effect)
        if context.unik_after_effect and context.scoring_hand then
            local success = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i] == card then
                    if i > 1 and context.scoring_hand[i-1] and SMODS.has_enhancement(context.scoring_hand[i-1],'m_bunc_copper') and not context.scoring_hand[i-1].debuff then
                        success = true
                        break
                    end
                    if i < #context.scoring_hand and context.scoring_hand[i+1] and SMODS.has_enhancement(context.scoring_hand[i+1],'m_bunc_copper') and not context.scoring_hand[i+1].debuff then
                        success = true
                        break
                    end
                end
            end
            if success then
                return {
                    rescore = card.ability.extra.rescore,
                }
            end
        end
    end
},true)

SMODS.Joker:take_ownership("j_bunc_robot",{
    calculate = function(self, card, context)
        if context.unik_post_rescore and context.rescored_cards and not context.blueprint and context.cardarea == G.play then
            local validCards = {}
                for i,v in pairs(context.rescored_cards) do
                    if SMODS.has_enhancement(v,"m_bunc_copper") then
                        validCards[#validCards+1] = v
                    end
                end

            card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.bonus * #validCards)
            if to_big(card.ability.extra.bonus * #validCards) > to_big(0) then
                return {
                    message = localize('k_upgrade_ex'),
                    card = card
                }
            end
            
        end
        if context.joker_main then
            if to_big(card.ability.extra.mult) ~= to_big(0) then
                return {
                    mult = card.ability.extra.mult,
                    card = card
                }
            end
        end
    end
},true)

SMODS.Joker:take_ownership("j_bunc_kite_experiment",{
    calculate = function(self, card, context)
        if context.unik_kite_experiment and context.scoring_hand then
            if SMODS.pseudorandom_probability(card, 'kite_experiment'..G.SEED, 1, card.ability.extra.odds, 'bunc_kite_experiment') then
                local validCards = {}
                for i,v in pairs(context.scoring_hand) do
                    if SMODS.has_enhancement(v,"m_bunc_copper") and v.unik_rescored then
                        validCards[#validCards+1] = v
                    end
                end
                return {
                    target_cards = validCards,
                    rescore = 1,
                    card = card,
                    message = '+1',
                }
            end
        end
    end
},true)