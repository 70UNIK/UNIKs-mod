--Create two crude blinds, self destructs
BLINDSIDE.Blind({
    key = 'unik_blindside_ai_brainrot',
    atlas = 'unik_blindside_blinds',
    pos = {x = 3, y = 6},
    config = {
        forced_selection = true,
        extra = {
            value = 30,
            cards = 2,
            stubborn = true,
        }},
    hues = {"Faded"},
    calculate = function(self, card, context) 
        if tableContains(card, G.hand.cards) and not tableContains(card, G.hand.highlighted) and #G.hand.highlighted < 5 and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
            card.ability.forced_selection = true
            G.hand:add_to_highlighted(card, true)
        end

        if context.after then
            card.ability.forced_selection = false
        end
        if context.cardarea == G.play and context.before and card.facing ~= 'back' then
            card.ability.stuffplayed = true
            local cardsadded = {}
            for i = 1, card.ability.extra.cards do
                G.E_MANAGER:add_event(Event({
                    delay = 1,
                    trigger = 'before',
                        func = function()
                            local args = {}
                            args.guaranteed = true
                            args.options = G.P_CENTER_POOLS.bld_obj_blindcard_generate
                            args.cursed = true
                            local cardtype = BLINDSIDE.poll_enhancement(args)
                            
                            local cardr = SMODS.create_card { set = "Base", enhancement = cardtype, area = G.hand }
                            if card.ability.extra.upgraded then
                                upgrade_blinds({cardr}, nil, true)
                            end
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
            if not card.ability.extra.upgraded then
                for i,v in pairs(context.full_hand) do
                    -- if not v.config.center.curse then
                    --     v.will_be_gored = true
                    --     if not G.GAME.cry_banned_pcards then
                    --         G.GAME.cry_banned_pcards = {}
                    --     end
                    --     if not G.GAME.banned_keys then
                    --         G.GAME.banned_keys = {}
                    --     end
                    --     G.GAME.cry_banished_keys[v.config.center.key] = true
                    -- end
                end
                for i,v in pairs(G.hand.cards) do
                    -- if not v.config.center.curse then
                    --     v.will_be_gored = true
                    --         if not G.GAME.cry_banned_pcards then
                    --         G.GAME.cry_banned_pcards = {}
                    --     end
                    --     if not G.GAME.banned_keys then
                    --         G.GAME.banned_keys = {}
                    --     end
                    --     G.GAME.cry_banished_keys[v.config.center.key] = true
                    -- end
                end
                 return {
                    message = localize('k_unik_ai'),
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
            else
                 return {
                message = localize('k_unik_ai_upgrade'),
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.calculate_context({ playing_card_added = true, cards = { cardsadded } })
                            return true
                        end
                    }))
                end
            }
            end
        end
        if context.after and not card.ability.extra.upgraded and card.ability.stuffplayed then
            local cards = {}
            for i,v in pairs(context.full_hand) do
                if not v.config.center.curse then
                    v.will_be_gored = true
                    if not G.GAME.cry_banned_pcards then
                        G.GAME.cry_banned_pcards = {}
                    end
                    if not G.GAME.banned_keys then
                        G.GAME.banned_keys = {}
                    end
                    G.GAME.cry_banished_keys[v.config.center.key] = true
                    cards[#cards+1] = v
                end
            end
            for i,v in pairs(G.hand.cards) do
                if not v.config.center.curse then
                    v.will_be_gored = true
                        if not G.GAME.cry_banned_pcards then
                        G.GAME.cry_banned_pcards = {}
                    end
                    if not G.GAME.banned_keys then
                        G.GAME.banned_keys = {}
                    end
                    G.GAME.cry_banished_keys[v.config.center.key] = true
                    cards[#cards+1] = v
                end
            end
            cards[#cards+1] = card
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.destroy_cards(cards)
                                
                            return true
                        end
                    }))
                end
            }
        end
        if context.destroy_card and not card.ability.extra.upgraded and card.area == G.play and (context.cardarea == G.play or context.cardarea == G.hand) then
            if (context.destroy_card.area == G.play or context.destroy_card.area == G.hand) and not context.destroy_card.config.center.curse then
                 if not G.GAME.cry_banned_pcards then
                    G.GAME.cry_banned_pcards = {}
                end
                if not G.GAME.banned_keys then
                    G.GAME.banned_keys = {}
                end
                    G.GAME.cry_banished_keys[context.destroy_card.config.center.key] = true
                    context.destroy_card.will_be_gored = true
                return { remove = true }
            end
            -- if context.destroy_card == card and context.cardarea == G.play then
            --     return { remove = true }
            -- end
			
		end
        if context.burn_card and context.cardarea == G.play and card.ability.extra.upgraded and context.burn_card == card then
            return { remove = true }
        end
    end,
    curse = true,
always_scores = true,
    loc_vars = function(self, info_queue, card)
        if not  card.ability.extra.upgraded then
             info_queue[#info_queue+1] = {key = 'bld_stubborn', set = 'Other'}
             info_queue[#info_queue + 1] = { set = "Other", key = "unik_banishing" }
        else
            info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
        end

        
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_ai_brainrot_upgraded' or 'm_unik_blindside_ai_brainrot',
            vars = {
                card.ability.extra.cards,
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.retain = nil
            card.ability.extra.stubborn = nil
            card.ability.forced_selection = nil
            card.ability.extra.upgraded = true
        end
    end
})