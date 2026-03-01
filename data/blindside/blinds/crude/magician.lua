--adds 4 random basic blinds in hand, stubborn, retained --> adds 2 premium blinds in hand after scoring, burns, not stubborn, not retained
BLINDSIDE.Blind({
    key = 'unik_blindside_magician',
    atlas = 'unik_blindside_blinds',
    pos = {x = 1, y = 6},
    config = {
        extra = {
            value = 30,
            cards = 4,
            cardsdown = 2,
            retain = true,
            stubborn = true,
        }},
    hues = {"Blue"},
    always_scores = true,
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.after and card.facing ~= 'back' and not  card.ability.extra.upgraded then
            local cardsadded = {}
            for i = 1, card.ability.extra.cards do
                G.E_MANAGER:add_event(Event({
                    delay = 1,
                    trigger = 'before',
                        func = function()
                            local enhancement = pseudorandom_element({'m_bld_sharp', 'm_bld_adder', 'm_bld_flip', 'm_bld_bite', 'm_bld_pot', 'm_bld_sharp', 'm_bld_adder', 'm_bld_flip', 'm_bld_bite', 'm_bld_pot', 'm_bld_blank'}, pseudoseed('magician'))
                            local cardr = SMODS.create_card { set = "Base", enhancement = enhancement, area = G.hand }
                            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                            cardr.playing_card = G.playing_card
                            table.insert(G.playing_cards, cardr)
                            cardr:start_materialize()
                            G.hand:emplace(cardr)
                            cardsadded[#cardsadded+1] = cardr
                            card:juice_up(1,1)
                            return true
                        end
                    }))
                
            end
             return {
                message = localize('k_unik_deckbloat'),
                colour = G.C.BLACK,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.calculate_context({ playing_card_added = true, cards = { cardsadded } })
                            return true
                        end
                    }))
                end
            }
            elseif context.after and context.cardarea == G.play and card.facing ~= 'back' and card.ability.extra.upgraded then
                    local cardlist = {}
                    for i,v in pairs(context.scoring_hand) do
                        if v ~= card then
                            cardlist[#cardlist+1] = v
                        end
                    end
                if #cardlist > 1 then
                    local copied_card = pseudorandom_element(cardlist, pseudoseed("magician_upgraded"))
                    local copy_card = copy_card(copied_card, nil, nil, G.playing_card)
                    copy_card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, copy_card)
                    G.hand:emplace(copy_card)
                    copy_card.states.visible = nil
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            copy_card:start_materialize()
                            if not copy_card.ability.extra or (copy_card.ability.extra and not copy_card.ability.extra.upgraded) then
                                upgrade_blinds({copy_card})
                            end
                            
                            return true
                        end
                    }))   
                    return {
                        message = localize('k_copied_ex'),
                        colour = G.C.GREEN,
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    SMODS.calculate_context({ playing_card_added = true, cards = { copy_card } })
                                    return true
                                end
                            }))
                        end
                    }
                end
            end
        if context.burn_card and context.cardarea == G.play and card.ability.extra.upgraded and context.burn_card == card then
            card.ability.extra.succeed = nil
            return { remove = true }
        end
    end,
    curse = true,
    loc_vars = function(self, info_queue, card)
        if not  card.ability.extra.upgraded then
             info_queue[#info_queue+1] = {key = 'bld_stubborn', set = 'Other'}
            info_queue[#info_queue+1] = {key = 'bld_retain', set = 'Other'}  
        else
            info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
        end

        
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_magician_upgraded' or 'm_unik_blindside_magician',
            vars = {
                card.ability.extra.cards,
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.cards = card.ability.extra.cards - card.ability.extra.cardsdown
            card.ability.extra.retain = nil
            card.ability.extra.stubborn = nil
            card.ability.extra.upgraded = true
        end
    end
})