local mod_path = "" .. SMODS.current_mod.path

SMODS.Atlas {
	key = "modicon",
	path = "modicon.png",
	px = 34,
	py = 34
}
--hooks--
---happiness is mandatory ---
SMODS.Atlas({ 
	key = "unik_showdown_blinds", 
	atlas_table = "ANIMATION_ATLAS", 
	path = "unik_showdown_blinds.png", 
	px = 34, 
	py = 34, 
	frames = 21 })
NFS.load(mod_path .. "data/hooks/addremovecards.lua")()
NFS.load(mod_path .. "data/hooks/hand_size_change.lua")()
--Creates an atlas for cards to use
-- SMODS.Atlas {
-- 	-- Key for code to find it with
-- 	key = "unik_cursed",
-- 	-- The name of the file, for the code to pull the atlas from
-- 	path = "unik_cursed.png",
-- 	-- Width of each sprite in 1x size
-- 	px = 71,
-- 	-- Height of each sprite in 1x size
-- 	py = 95
-- }
-- SMODS.Atlas {
-- 	key = "unik_bossJokers",
-- 	path = "unik_bossJokers.png",
-- 	px = 71,
-- 	py = 95
-- }
SMODS.Atlas {
	key = "unik_stickers",
	path = "unik_stickers.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "unik_stickers",
	path = "unik_stickers.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "unik_common",
	path = "unik_common.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "unik_uncommon",
	path = "unik_uncommon.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "placeholders",
	path = "placeholders.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "unik_rare",
	path = "unik_rare.png",
	px = 71,
	py = 95
}
-- SMODS.Atlas {
-- 	key = "unik_epic",
-- 	path = "unik_epic.png",
-- 	px = 71,
-- 	py = 95
-- }
SMODS.Atlas {
	key = "unik_cursed",
	path = "unik_cursed.png",
	px = 71,
	py = 95
}
-- Pool used by boss blind jokers
SMODS.ObjectType({
	key = "unik_boss_blind_joker",
	default = "j_obelisk",
	cards = {},
})
-- stickers
NFS.load(mod_path .. "data/stickers/depleted.lua")() 
-- consumables
NFS.load(mod_path .. "data/tarots/wheel_of_misfortune.lua")() --no image


--BLINDS--
NFS.load(mod_path .. "data/bossBlinds/poppy.lua")() 
NFS.load(mod_path .. "data/bossBlinds/joyless.lua")()
NFS.load(mod_path .. "data/bossBlinds/collapse.lua")()
NFS.load(mod_path .. "data/bossBlinds/sync_catalyst_fail.lua")()
--The lily: Destroy all cards played after scoring; each card destroyed increases blind requirements by 0.02%
--The Garbage: Add random permanently debuffed cards equal to 16% of total cards in deck (they self destruct after blind ends)

NFS.load(mod_path .. "data/bossBlinds/purple_pentagram.lua")()
NFS.load(mod_path .. "data/bossBlinds/indigo_icbm.lua")() 
NFS.load(mod_path .. "data/bossBlinds/batman.lua")()
NFS.load(mod_path .. "data/bossBlinds/persimmon_placard.lua")()
NFS.load(mod_path .. "data/bossBlinds/bigger_boo.lua")()

-- EDITIONS --
NFS.load(mod_path .. "data/editions/positive.lua")()
-- JOKERS --
--- Common ---
-- NFS.load(mod_path .. "data/jokers/holepunched_card.lua")() -- too unoriginal? Could have niche use in multi card hands, but is hanging chad with extra steps

-- not redundant with extra credit, as it instead can stack ON top of the existing lucky enhancement. You just need some more //SEEDS
NFS.load(mod_path .. "data/jokers/lucky_seven.lua")()
NFS.load(mod_path .. "data/jokers/gt710.lua")()
NFS.load(mod_path .. "data/jokers/big_joker.lua")()

--- Uncommon ---
NFS.load(mod_path .. "data/jokers/no_standing_zone.lua")()
NFS.load(mod_path .. "data/jokers/711.lua")()
NFS.load(mod_path .. "data/jokers/riif_roof.lua")()
NFS.load(mod_path .. "data/jokers/yes_nothing.lua")()
NFS.load(mod_path .. "data/jokers/cube_joker.lua")() 
NFS.load(mod_path .. "data/jokers/recycler.lua")()

-- No standing Zone: 3x mult, decreases by 0.01x per 2 seconds in this ante after purchase. If hits 1x mult, switches to "Towaway" (Cursed). Resets after defeating a boss blind.
--- Rare ---
NFS.load(mod_path .. "data/jokers/ghost_trap.lua")() 
NFS.load(mod_path .. "data/jokers/lily_sprunki.lua")()
--- Epic ---
NFS.load(mod_path .. "data/jokers/chelsea_ramirez.lua")()
--NFS.load(mod_path .. "data/jokers/maya_ramirez.lua")() --broken until smods fix perma_x_chips --no image: the titular character
NFS.load(mod_path .. "data/jokers/yokana_ramirez.lua")() 
--- Legendary ---
--- Exotic ---
NFS.load(mod_path .. "data/jokers/moonlight_cookie.lua")()
NFS.load(mod_path .. "data/jokers/unik.lua")() --maybe rework image?

--- Cursed --- 15 of those
NFS.load(mod_path .. "data/jokers/happiness.lua")()
NFS.load(mod_path .. "data/jokers/autocannibalism.lua")()
NFS.load(mod_path .. "data/jokers/impounded.lua")()
NFS.load(mod_path .. "data/jokers/the_plant.lua")()
NFS.load(mod_path .. "data/jokers/caveman_club.lua")()
NFS.load(mod_path .. "data/jokers/broken_window.lua")()
NFS.load(mod_path .. "data/jokers/goading_joker.lua")() --no image, patronizing joker, but more crass, rugged and dirty
NFS.load(mod_path .. "data/jokers/headless_joker.lua")()
NFS.load(mod_path .. "data/jokers/handcuffs.lua")() 
NFS.load(mod_path .. "data/jokers/border_wall.lua")()
NFS.load(mod_path .. "data/jokers/broken_arm.lua")() --no image, the space joker with a br0ken arm
--Hook n' discard (The Hook): Discards 2 random cards before play. Self destruct after 16 consecutive discards with only two cards or the hook is triggered
--Expired smoothie: x0.5 mult, sell to multiply all values of all owned jokers by 0.8x
--Monster spawner: Create 1 Cursed Joker after defeating each Boss Blind; 69 in 70 chance for it to not be negative. Self destruct if spawned 2 cursed jokers. If absolute, will never expire (for challenges). WIll never spawn another monster spawner.
--Forced Seance: Create 1 Eternal Banana Seance after each hand. Self destructs when there are 13 seances present.
--Vampiric Hammer: Remove all card enhancements after scoring. Self destruct if you have <30% enhanced cards in your deck or The Hammer is triggered (Ortalab)
--Jimbillion Virus: Replace 1 random joker with Jimbo before each hand (except for Jimbotron 9000). Self destructs when all jokers are jimbo.

--- Devastating ---
--- Catastrophic ---
--- 
--- 
--- Challenges
NFS.load(mod_path .. "data/challenges/chipzel.lua")()
NFS.load(mod_path .. "data/challenges/multiplication.lua")()
NFS.load(mod_path .. "data/challenges/common_muck.lua")()
NFS.load(mod_path .. "data/challenges/boss_rush_2.lua")()
NFS.load(mod_path .. "data/challenges/boss_rush_3.lua")()



