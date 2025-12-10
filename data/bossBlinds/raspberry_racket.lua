--Spend $40 after each hand. Must have at least $40 to score 
--Will score like the poppy to allow stuff such as gold seals, lucky cards, reserved parking to add up money.
--Racket is named for "protection rackets", more specifically, that in this case, you need to pay to survive (score)
SMODS.Blind{
    key = 'unik_raspberry_racket',
    config = {},
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 12},
    boss_colour= HEX("ff3181"),
    dollars = 8 ,
    mult = 2,
    death_message="special_lose_unik_racket",
	set_blind = function(self)
        local text = localize('k_unik_protection_racket_start')
        attention_text({
            scale = 0.65, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
        })
	end,
    get_loc_debuff_text = function(self)
		return localize("k_unik_racket_warning")
	end,
    --Give a warning if you dont have enough money
    debuff_hand = function(self, cards, hand, handname, check)
        if check then
            if to_big((G.GAME.dollars-G.GAME.bankrupt_at) - 25) < to_big(0) then
                return true
            end
        end
        return false
    end,
    unik_debuff_after_hand = function(self,poker_hands, scoring_hand,cards, check,sum)
        if to_big((G.GAME.dollars-G.GAME.bankrupt_at) - 25) < to_big(0) then
            return {
                debuff = true,
            }
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',delay = 0.4,
                func = function()
                    G.GAME.blind.triggered = true
                    G.GAME.blind:wiggle()
                    ease_dollars(-25, true)
                    G.ROOM.jiggle = G.ROOM.jiggle + 0.7
                return true
            end   
        }))
        return {
            debuff = false,
        }
    end,
}