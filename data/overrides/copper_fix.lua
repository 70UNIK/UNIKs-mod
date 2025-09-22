--Fixing bunco's copper cards to be more durable against crossmods as well as open opportunities for quantum enhancements and cyborg (rescore ALL cards when a copper card is rescored)

SMODS.Enhancement:take_ownership("m_bunc_copper",{
    config = {extra = {rescore = 1}},
    calculate = function(self, card, context, effect)
        if context.unik_rescore_card and context.full_hand then
            local success = false
            for i = 1, #context.full_hand do
                if context.full_hand[i] == card then
                    if i > 1 and context.full_hand[i-1] and SMODS.has_enhancement(context.full_hand[i-1],'m_bunc_copper') and not context.full_hand[i-1].debuff then
                        success = true
                        break
                    end
                    if i < #context.cardarea.cards and context.cardarea.cards[i+1] and SMODS.has_enhancement(context.full_hand[i+1],'m_bunc_copper') and not context.full_hand[i+1].debuff then
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
        if context.unik_post_rescore and context.rescored_cards and not context.blueprint then
            local validCards = {}
                for i,v in pairs(context.rescored_cards) do
                    if SMODS.has_enhancement(v.card,"m_bunc_copper") then
                        validCards[#validCards+1] = v.card
                    end
                end

            card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.bonus * #validCards)

            return {
                message = localize('k_upgrade_ex'),
                card = card
            }
        end
        if context.joker_main then
            if card.ability.extra.mult ~= 0 then
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
        if context.unik_kite_experiment and context.rescored_cards and context.scoring_hand then
            if SMODS.pseudorandom_probability(card, 'kite_experiment'..G.SEED, 1, card.ability.extra.odds, 'bunc_kite_experiment') then
                local validCards = {}
                for i,v in pairs(context.rescored_cards) do
                    if SMODS.has_enhancement(v.card,"m_bunc_copper") then
                        validCards[#validCards+1] = v.card
                    end
                end
                return {
                    target_cards = validCards,
                    mod_rescore = 1,
                    card = card,
                    message = '+1',
                }
            end
        end
    end
},true)