
SMODS.Blind{
    key = 'unik_legendary_vessel',
    config = {},
    boss = {min = 1, showdown = true,legendary = true}, 
    atlas = "BlindChips",
    pos = {x=0, y=29}, --placeholder is violet vessel, will have an  appropriate icon later
    boss_colour= HEX("ff0000"), --all legendary blinds will be blood red and black.
    dollars = 13,
    mult = 2,
    gameset_config = {
		modest = { disabled = true},
	},
    set_blind = function(self, reset, silent)
        --set blind size to ^2.666x
        G.GAME.unik_kill_player_before_last_hand = true
        G.GAME.blind.chips = G.GAME.blind.chips^2.666
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        G.HUD_blind:recalculate(true)
	end,
    in_pool = function()
        if G.GAME.round >= 100 or G.GAME.modifiers.unik_legendary_at_any_time then
            return true
        end
        return false
    end,
    --somehow if that happens, set the base to be 
    disable = function(self)
        if G.GAME.unik_kill_player_before_last_hand then
            G.GAME.blind.chips = G.GAME.blind.chips/(G.GAME.blind.chips^2.666)
            G.GAME.blind.chips = G.GAME.blind.chips - (G.GAME.blind.chips )
        end
        G.GAME.unik_kill_player_before_last_hand = nil

	end,
	defeat = function(self)
        G.GAME.unik_kill_player_before_last_hand = nil
	end,
}