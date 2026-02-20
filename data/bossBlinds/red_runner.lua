--all cards debuffed until a hand containing a straight is played 
SMODS.Blind{
    key = 'unik_red_runner',
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 36},
    boss_colour= HEX("ff0000"),
    dollars = 8,
    mult = 2,
    config = {},
    pronouns = "he_him",
    death_card = {
        card = 'j_runner', 
        mod_card = function(self, card) --used to apply editions and/or stickers
        end,
        quotes = {'special_lose_runner'},
        say_times = 6,
    },
    unik_before_play = function(self)
        local text, loc_disp_text, poker_hands, scoring_hand, disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
        if next(poker_hands["Straight"]) then
            G.E_MANAGER:add_event(Event({trigger = 'immediate',func = function()
                G.GAME.blind:disable()
                return true
            end}))
        end
	end,
    debuff_hand = function(self, cards, hand, handname, check)
		if next(hand["Straight"]) then	
			return false
		end
        G.GAME.blind.triggered = true
		return true
	end,
}