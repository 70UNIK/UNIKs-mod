--serpent: caps cards drawn at 3, will make a joker that sets minimum cards drawn to 3.

--Amber acorn: flips and shuffles all jokers, shuffles all jokers, held and played cards on play, making it more of a threat
SMODS.Blind:take_ownership("bl_final_acorn",{
    calculate = function(self, blind, context)
        if context.press_play and not G.GAME.blind.disabled  then
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

--the seed (AIJ): will use my own small/big blind system instead of what the hell they have cause it softlocks my run

SMODS.Blind:take_ownership("bl_aij_the_seed",{
    defeat = function(self)
        local temp = G.GAME.blind and G.GAME.blind.disabled
        if temp then
            return
        end
        G.GAME.aij_force_big_to_be_boss = true
        -- G.GAME.aij_has_big_boss = true
        -- G.GAME.aij_big_boss_reset_ante = true
        -- G.GAME.round_resets.blind_choices.Big_Boss = get_new_boss()
    end
},true)