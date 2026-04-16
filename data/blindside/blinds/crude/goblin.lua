--banish a random trinket when played, banish all non crude blinds in deck instead if no trinkets owned, burns --> add finish to a random trinket, then debuff it, burns.
--green goblin reference
BLINDSIDE.Blind({
    key = 'unik_blindside_goblin',
    atlas = 'unik_blindside_blinds',
    pos = {x = 7, y = 6},
    config = {
        extra = {
            value = 30,
            retain = true,
            stubborn = true,
        }
    },
    hues = {"Green"},
    calculate = function(self, card, context) 
        if context.on_select_play and card.highlighted and not card.ability.extra.used then
            if card.ability.extra.upgraded then
                local cards = {}
                for i,v in pairs(G.jokers.cards) do
                    if not v.edition then
                        cards[#cards+1] = v
                    end
                end
                if #cards > 0 then
                    local neck_banish = pseudorandom_element(cards, pseudoseed("unik_osborn"))
                    card:juice_up(1,1)
                    neck_banish:set_edition( {bld_finish = true},true, nil, true )
                    neck_banish:set_debuff(true)
                end
            else
                local cards = {}
                for i,v in pairs(G.jokers.cards) do
                    if not v.banished_by_goblin then
                        cards[#cards+1] = v
                    end
                end
                --print(cards)
                if #cards > 0 then
                    local neck_banish = pseudorandom_element(cards, pseudoseed("unik_green_goblin"))
                    --neck_banish.banished_by_goblin = true
                    card:juice_up(3,3)
                    neck_banish:gore6_break()
                    if not G.GAME.banned_keys then
                    G.GAME.banned_keys = {}
                    end
                    if not G.GAME.cry_banished_keys then
                        G.GAME.cry_banished_keys = {}
                    end
                    G.GAME.cry_banished_keys[neck_banish.config.center.key] = true
                        
                else
                    -- if #G.deck.cards > 0 then
                    --     card:juice_up(3,3)
                    --     for i,v in pairs(G.deck.cards) do
                    --     if not v.config.center.curse then
                    --         if not G.GAME.cry_banned_pcards then
                    --             G.GAME.cry_banned_pcards = {}
                    --         end
                    --         if not G.GAME.banned_keys then
                    --             G.GAME.banned_keys = {}
                    --         end
                    --             G.GAME.cry_banished_keys[v.config.center.key] = true
                    --                 G.E_MANAGER:add_event(Event({
                    --                     delay = 0.25,
                    --                 func = function()
                    --                     v:gore6_break()
                    --                     return true
                    --                 end
                    --             }))
                                
                    --     end
                    -- end
                    -- end
                     
                end
               
            end
            card.ability.extra.used = true
        end
        if context.before or context.after then
            card.ability.extra.used = nil
        end
        if context.burn_card and context.cardarea == G.play and context.burn_card == card then
            return { remove = true }
        end
    end,
    curse = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
if not  card.ability.extra.upgraded then
            info_queue[#info_queue+1] = {key = 'bld_stubborn', set = 'Other'}  
            info_queue[#info_queue+1] = {key = 'bld_retain', set = 'Other'}  
            info_queue[#info_queue + 1] = { set = "Other", key = "unik_banishing" }
        else
            info_queue[#info_queue+1] = G.P_CENTERS.e_bld_finish
        end
        
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_goblin_upgraded' or 'm_unik_blindside_goblin',
            vars = {
                
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.stubborn = nil
            card.ability.extra.retain = nil
            card.ability.extra.stubborn = false
            card.ability.extra.retain = false
            card.ability.extra.upgraded = true
        end
    end
})