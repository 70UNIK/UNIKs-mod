SMODS.Blind{
    key = 'unik_approval',
    config = {},
    boss = {min = 2, }, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 40},
    boss_colour= HEX("00FF5D"),
    dollars = 5,
    mult = 2,
	in_pool = function(self, args)
        local back = G.GAME.selected_back
        local back_config = back and back.effect.center.has_crosses
        if back_config and G.GAME.round_resets.ante >= 2  then 
            return true

            end

        return false
	end,
    recalc_debuff = function(self, card, from_blind)
        if (card.area ~= G.jokers) and not G.GAME.blind.disabled and card:is_suit('unik_Crosses') then
            return true
        end
        return false
	end,
}