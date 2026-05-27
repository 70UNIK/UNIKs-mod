--while held, selecting a blind shuffles all held blinds
BLINDSIDE.Blind({
    key = 'unik_blindside_nut',
    atlas = 'unik_blindside_blinds',
    pos = {x = 2, y = 6},
    config = {
        extra = {
            value = 30,
            money = 4,
            none = 0,
            retain = true,
            stubborn = true,
        }},
    hues = {"Yellow"},
    always_scores = true,
    calculate = function(self, card, context) 
        if card.area == G.hand and context.press_play and context.main_eval then
            G.E_MANAGER:add_event(Event({
                    func = function()
                        if #G.jokers.cards > 0 then
                           -- print("suffle")
                            G.jokers:shuffle('NUTTY'); play_sound('cardSlide1', 0.85)
                        end
                        if #G.hand.cards > 0 then
                           -- print("suffle2")
                            G.hand:shuffle('NUTTY2');
                        end
                        if #G.play.cards > 0 then
                           -- print("suffle2")
                            G.play:shuffle('NUTTY3'); 
                        end
                        return true
                    end
                }))
                 delay(0.15)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if #G.jokers.cards > 0 then
                            G.jokers:shuffle('NUTTY'); play_sound('cardSlide1', 1.15)
                        end
                        if #G.hand.cards > 0 then
                            G.hand:shuffle('NUTTY2');
                        end
                        if #G.play.cards > 0 then

                            G.play:shuffle('NUTTY3');
                        end
                        return true
                    end
                }))
                 delay(0.15)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if #G.jokers.cards > 0 then
                            G.jokers:shuffle('NUTTY'); play_sound('cardSlide1', 1)
                        end
                        if #G.hand.cards > 0 then
                            G.hand:shuffle('NUTTY2'); 
                        end
                        if #G.play.cards > 0 then

                            G.play:shuffle('NUTTY3');
                        end
                        return true
                    end
                }))
                delay(0.5)
                
            return {

            }
        end
        if context.cardarea == G.play and context.main_scoring and not card.ability.extra.upgraded then
            if G.GAME.dollars > 0 then
                return {
                    p_dollars = -G.GAME.dollars,
                }
            end
            
        end
         if context.cardarea == G.hand and context.main_scoring and card.ability.extra.upgraded then
            return {
                dollars = card.ability.extra.money
            }
        end
    end,
    curse = true,
    loc_vars = function(self, info_queue, card)
        if not  card.ability.extra.upgraded then
             info_queue[#info_queue+1] = {key = 'bld_stubborn', set = 'Other'}
             
        else
        end
        info_queue[#info_queue+1] = {key = 'bld_retain', set = 'Other'} 

        
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_nut_upgraded' or 'm_unik_blindside_nut',
            vars = {
                card.ability.extra.none,card.ability.extra.money,
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.stubborn = nil
            card.ability.extra.upgraded = true
        end
    end
})