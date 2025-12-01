SMODS.Blind{
    key = 'unik_fill',
    config = {},
    boss = {min = 2, }, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 41},
    boss_colour= HEX("d3757a"),
    dollars = 5,
    mult = 2,
	in_pool = function(self, args)
        local back = G.GAME.selected_back
        local back_config = back and back.effect.center.has_noughts
        if back_config and G.GAME.round_resets.ante >= 2 then 
            return true 

            end

        return false
	end,
    recalc_debuff = function(self, card, from_blind)
        if (card.area ~= G.jokers) and not G.GAME.blind.disabled and SMODS.has_no_suit(card) then
            return true
        end
        return false
	end,
}