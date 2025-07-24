--Literally the descending.
--Mult is added to Chips and set to 1.
--^0.9 blind reqs.

SMODS.Blind{
    key = 'unik_salmon_steps',
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 26},
    boss_colour= HEX("f27c6e"),
    dollars = 8,
    mult = 2,
    unik_exponent = {1,0.7},
    config = {},
    death_message = 'special_lose_salmon_steps',
    unik_debuff_after_hand = function(self,poker_hands, scoring_hand,cards, check,mult,hand_chips,sum)
        local hand_chips2 = hand_chips + mult
        local mult2 = 1
        update_hand_text({delay = 0}, {mult = mult2, chips = hand_chips2})
        G.E_MANAGER:add_event(Event({
            func = (function()
                G.GAME.blind.triggered = true
                G.GAME.blind:wiggle()
                
                local text = localize('unik_the_descending')
                play_sound('gong', 0.94, 0.3)
                play_sound('gong', 0.94*1.5, 0.2)
                play_sound('tarot1', 1.5)
                ease_colour(G.C.UI_CHIPS, darken(G.C.UI_MULT, 0.5))
                ease_colour(G.C.UI_MULT, darken(G.C.UI_MULT, 0.5))
                attention_text({
                    scale = 1.4, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                })
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    blockable = false,
                    blocking = false,
                    delay =  4.3,
                    func = (function() 
                            ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
                            ease_colour(G.C.UI_MULT, G.C.RED, 2)
                        return true
                    end)
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    blockable = false,
                    blocking = false,
                    no_delete = true,
                    delay =  6.3,
                    func = (function() 
                        G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
                        G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
                        return true
                    end)
                }))
                return true
            end)
        }))

        delay(0.6)
        
        return {
            mod_mult = mult2,
            mod_chips = hand_chips2,
            debuff = false,
        }
    end,
}