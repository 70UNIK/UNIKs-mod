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
    death_message = "special_lose_runner",
    --Create an eternal ghost

    unik_before_play = function(self)
        local text, loc_disp_text, poker_hands, scoring_hand, disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
        if poker_hands["Straight"] then
            G.E_MANAGER:add_event(Event({trigger = 'immediate',func = function()
                G.GAME.blind:disable()
                return true
            end}))
        end
	end,
    recalc_debuff = function(self, card, from_blind)
        if (card.area ~= G.jokers) then
            return true
        end
        return false
	end,
}