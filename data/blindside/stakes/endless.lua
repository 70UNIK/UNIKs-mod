--endless stake???
--+2 Win Ante
SMODS.Stake{
    key = 'unik_blindside_endless_deck',

    applied_stakes = {'unik_blindside_greed_deck'},
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}, unlocked_stake = {mod = false}},
    
    modifiers = function()
        G.E_MANAGER:add_event(Event({trigger = 'before',func = function() 
				G.GAME.win_ante = G.GAME.win_ante + 2
			return true end })) 
    end,

    --colour = ,


    pos = { x = 1, y = 1 },
    atlas = 'unik_stakes',
}