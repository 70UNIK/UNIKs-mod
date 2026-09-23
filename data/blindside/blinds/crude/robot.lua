--forced to be selected, always played when selected, stubborn
--ugpraded version gives X3 chips and +1 hand
BLINDSIDE.Blind({
    key = 'unik_blindside_robot',
    atlas = 'unik_blindside_blinds',
    pos = {x = 3, y = 7},
    config = {
        forced_selection = true,
        extra = {
            value = 30,
            x_chips = 3.5,
            hands = 1,
            stubborn = true,
        }},
    hues = {"Blue"},
    calculate = function(self, card, context) 

        if tableContains(card, G.hand.cards) and not tableContains(card, G.hand.highlighted) and #G.hand.highlighted < 5 and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
            card.ability.forced_selection = true
            G.hand:add_to_highlighted(card, true)
        end
        if context.after then
            card.ability.forced_selection = false
        end
        if context.cardarea == G.play and context.before and card.facing ~= 'back' and card.ability.extra.upgraded then
            ease_hands_played(card.ability.extra.hands)
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_hands', vars = {card.ability.extra.hands}}})
            return {

            }
        end
        if context.cardarea == G.play and context.main_scoring and card.ability.extra.upgraded then
            
            return {
                x_chips = card.ability.extra.x_chips
            }
        end
        if context.burn_card and context.cardarea == G.play and context.burn_card == card then
            return { remove = true }
        end
        if context.unik_triggering and card.area == G.hand then 
            if (context.selected_card == card) or (context.selected_card.area == G.hand) then
                play_sound('unik_gunshot')
                card:juice_up(1.25,1.25)
                return {
                    finger_triggered = true,
                }
            end
		end
        if context.cardarea == G.play and context.before and card.facing ~= 'back' and card.ability.extra.upgraded then
            for i,v in pairs(G.hand.cards) do
                v.retain = true
            end
        end

        
        
    end,
    curse = true,
    always_scores = true,
    loc_vars = function(self, info_queue, card)
        if card.ability.extra.upgraded then
             info_queue[#info_queue+1] = {key = 'bld_retain', set = 'Other'}
              
        end
        info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
         info_queue[#info_queue+1] = {key = 'bld_stubborn', set = 'Other'}

        
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_robot_upgraded' or 'm_unik_blindside_robot',
            vars = {
                card.ability.extra.x_chips,card.ability.extra.hands
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.upgraded = true
        end
    end
})