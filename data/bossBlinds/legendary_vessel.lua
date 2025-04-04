
SMODS.Blind{
    key = 'unik_legendary_vessel',
    config = {},
    boss = {min = 1,legendary = true, showdown = true}, 
    atlas = "unik_legendary_blinds",
    pos = {x=0, y=0},
    boss_colour= HEX("600000"), --all legendary blinds will be blood red and black.
    dollars = 13,
    mult = 2,
    jen_blind_resize = 1e300, --To align with epic blind sizing
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
        local straddle = 0
        --if you increase straddle, these fuckers can spawn earlier!
        if G.GAME.straddle then
            straddle = G.GAME.straddle
        end
        if not G.jokers or not G.jokers.cards then
			return false
		end
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].config.center.rarity == "cry_exotic" then
                hasExotic = true
            end
        end

        --how this works:
        --Disabled in modest
        --In base cryptid, has to exceed round 100 with an exotic in hand to activate
        --In almanac, just has to exceed round 100 - (straddle x 5)
        if Cryptid.gameset() ~= "modest" and ((G.GAME.round >= 100 - (straddle*5) and (hasExotic or (SMODS.Mods["jen"] or {}).can_load)) or G.GAME.modifiers.unik_legendary_at_any_time) then

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