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
    boss_colour= HEX("8a71e1"), 
    dollars = 13,
    mult = 1,
    unik_exponent = {1,2.5},
    glitchy_anim = true,
    death_message = "special_lose_unik_vessel_legendary",
    --Proof: Lets say you face epicWall at blind e300. THe epic wall already applies x e100, so becomes e400. Overshoot, and it adds e100, = e500.
    --If facing against this, 300 x 6.666 = ~e2000, which is way over what the wall can do most of the time.
    gameset_config = {
		modest = { disabled = true},
	},
    ignore_showdown_check = true,
    in_pool = function()
        return CanSpawnLegendary()
    end,
    --somehow if that happens, set the base to be 
    disable = function(self)
        G.GAME.blind.chips = G.GAME.blind.chips/(G.GAME.blind.chips^2.5)
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        G.HUD_blind:recalculate(true)
	end,
	unik_after_defeat = function(self,chips,blind_size)
        if G.GAME.current_round.hands_left > 0 and not next(find_joker("j_cry_panopticon")) then
            return true
        end
        return false
    end
}