SMODS.Atlas({ 
    key = "unik_legendary_vessel", 
    atlas_table = "ANIMATION_ATLAS", 
    path = "unik_legendary_vessel.png", 
    px = 34, 
    py = 34, 
frames = 21 })
SMODS.Blind{
    key = 'unik_legendary_vessel',
    config = {},
    boss = {min = 1,legendary = true, showdown = true,no_orb = true}, 
    atlas = "unik_legendary_vessel",
    pos = {x=0, y=0},
    boss_colour= HEX("8a71e1"), --all legendary blinds will be blood red and black.
    dollars = 13,
    mult = 1,
    exponent = {1,2.1666},
    glitchy_anim = true,
    jen_blind_exponent_resize = {2,4.666}, --to align with epic blinds. ^9.666 that also kills you if you overshoot is worse than *e100
    --Proof: Lets say you face epicWall at blind e300. THe epic wall already applies x e100, so becomes e400. Overshoot, and it adds e100, = e500.
    --If facing against this, 300 x 6.666 = ~e2000, which is way over what the wall can do most of the time.
    gameset_config = {
		modest = { disabled = true},
	},
    set_blind = function(self, reset, silent)
        --set blind size to ^2.666x
        G.GAME.unik_kill_player_before_last_hand = true
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
            if(SMODS.Mods["jen"] or {}).can_load then
                G.GAME.blind.chips = G.GAME.blind.chips/(G.GAME.blind.chips^16.666)
            else
                G.GAME.blind.chips = G.GAME.blind.chips/(G.GAME.blind.chips^2.666)
            end
        end
        G.GAME.unik_kill_player_before_last_hand = nil
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        G.HUD_blind:recalculate(true)
	end,
	defeat = function(self)
        G.GAME.unik_kill_player_before_last_hand = nil
	end,
}