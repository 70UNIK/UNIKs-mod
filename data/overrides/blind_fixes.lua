--serpent: caps cards drawn at 3, will make a joker that sets minimum cards drawn to 3.

--Amber acorn: flips and shuffles all jokers, shuffles all jokers, held and played cards on play, making it more of a threat
SMODS.Blind:take_ownership("bl_final_acorn",{
    calculate = function(self, blind, context)
        if context.press_play then
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
                        if #G.consumeables.cards > 0 then
                           -- print("suffle2")
                            G.consumeables:shuffle('NUTTY4'); 
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
                        if #G.consumeables.cards > 0 then
                           -- print("suffle2")
                            G.consumeables:shuffle('NUTTY4'); 
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
                        if #G.consumeables.cards > 0 then
                           -- print("suffle2")
                            G.consumeables:shuffle('NUTTY4'); 
                        end
                        return true
                    end
                }))
                delay(0.5)
                
            return {

            }
        end
    end,
    
},true) 