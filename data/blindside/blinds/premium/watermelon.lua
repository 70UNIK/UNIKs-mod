BLINDSIDE.Blind({
    key = 'unik_blindside_watermelon',
    atlas = 'unik_blindside_blinds',
    pos = {x = 5, y = 2},
    config = {
        extra = {
            value = 20,
        }},
    hues = {"Red", "Green"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.main_scoring and not G.GAME.unik_restrict_watermelon then
            return {
                message = "+1",
                colour = G.C.MULT,
                func = function()
                    local cards = {}
                    for i,v in pairs(G.play.cards) do
                        if v:is_color('Red') or (card.ability.extra.upgraded and v:is_color('Green')) then
                            cards[#cards+1] = v
                        end      
                    end
                    if #cards > 0 then
                         play_area_status_text(localize('k_unik_repeat'))
                         G.E_MANAGER:add_event(Event({
                            trigger = 'immediate',
                            func = function()
                                for i,v in pairs(cards) do
                                    v:juice_up(1,1)
                                end
                                return true
                            end
                        }))
                        
                    end
                    for i,v in pairs(cards) do
                         G.GAME.unik_block_blindside_rescore = true
                         G.GAME.unik_only_rescore = true
                         G.GAME.unik_restrict_watermelon = true
                        local ctx = {
                            cardarea = G.play,
                            full_hand = G.play.cards,
                            scoring_hand = context.scoring_hand,
                            scoring_name = context.scoring_name,
                            poker_hands = context.poker_hands,
                        }
                        
                        SMODS.score_card(v, ctx)
                        if v.blindside_rescore then
                            for z = 1, v.blindside_rescore do
                                G.GAME.unik_block_blindside_rescore = true
                                card_eval_status_text(v, "extra", nil, nil, nil, {
                                    message = (localize('k_again_ex')),
                                    colour = G.C.RED,
                                    card=v,
                                })
                                G.GAME.unik_only_rescore = nil
                                BLINDSIDE.rescore_card(v, context)
                                G.GAME.unik_only_rescore = true
                                
                            end
                        end
                        G.GAME.unik_only_rescore = nil
                        G.GAME.unik_restrict_watermelon = nil    
                         G.GAME.unik_block_blindside_rescore = nil
                    end
                    
                end
            }
            
        end
        if context.cardarea == G.play and context.before and card.facing ~= 'back' then
            for i=1, #G.play.cards do
                if G.play.cards[i]:is_color("Blue", true, false) and G.play.cards[i] ~= card then
                    G.play.cards[i].config.center.blind_debuff(G.play.cards[i], true)
                end
            end
            for i=1, #G.hand.cards do
                 if G.hand.cards[i]:is_color("Blue", true, false) then
                     G.hand.cards[i].config.center.blind_debuff(G.hand.cards[i], true)
                 end
               
            end
        end
        if context.cardarea == G.play and context.after and card.facing ~= 'back' and card.ability.extra.upgraded  then
            for i=1, #G.play.cards do
                if G.play.cards[i]:is_color("Blue", true, false) and G.play.cards[i] ~= card then
                    G.play.cards[i]:set_debuff(false)
                end
            end
            for i=1, #G.hand.cards do
                if G.hand.cards[i]:is_color("Blue", true, false) then
                    G.hand.cards[i]:set_debuff(false)
                    local carder = G.hand.cards[i]
                    if carder.facing == 'back' and (not carder.ability.extra or (carder.ability.extra and not carder.ability.extra.flipped)) then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                carder:flip()
                                return true
                            end,
                        }))
                        
                    end
                end
                
            end
        end
        if context.destroy_card  and not card.ability.extra.upgraded and card.area == G.play and (context.cardarea == G.play or context.cardarea == G.hand) then
            if (context.destroy_card.area == G.play or context.destroy_card.area == G.hand) and context.destroy_card:is_color("Blue", true, false) then
                return { 
                    remove = true, 
                }
            end
        end
    end,
    rare = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }

        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_watermelon_upgraded' or 'm_unik_blindside_watermelon',
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
        card.ability.extra.upgraded = true
        end
    end
})