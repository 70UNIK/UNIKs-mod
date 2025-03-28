
SMODS.Blind{
    key = 'unik_legendary_vessel',
    config = {},
    boss = {min = 1,legendary = true, showdown = true}, 
    atlas = "unik_legendary_blinds",
    pos = {x=0, y=0},
    boss_colour= HEX("600000"), --all legendary blinds will be blood red and black.
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
    ignore_showdown_check = true,
    in_pool = function()
        --do not appear in modest, scaling of blind size is enough of a challenge in vanilla.
        -- it requires you to have an exotic joker on hand as well to spawn
        local hasExotic = false
        if not G.jokers or not G.jokers.cards then
			return false
		end
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].config.center.rarity == "cry_exotic" then
                hasExotic = true
            end
        end

        if Cryptid.gameset() ~= "modest" and ((G.GAME.round >= 100 and hasExotic) or G.GAME.modifiers.unik_legendary_at_any_time) then
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