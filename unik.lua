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
-- SMODS.Atlas {
-- 	key = "unik_rare",
-- 	path = "unik_rare.png",
-- 	px = 71,
-- 	py = 95
-- }
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
NFS.load(mod_path .. "data/stickers/depleted.lua")()
--BLINDS--
NFS.load(mod_path .. "data/bossBlinds/poppy.lua")()
--NFS.load(mod_path .. "data/bossBlinds/joyless.lua")() --Not listed until I fix the issue of M jokers not counting as "Jolly"
NFS.load(mod_path .. "data/bossBlinds/purple_pentagram.lua")()
NFS.load(mod_path .. "data/bossBlinds/indigo_icbm.lua")()
NFS.load(mod_path .. "data/bossBlinds/batman.lua")()
NFS.load(mod_path .. "data/bossBlinds/persimmon_placard.lua")()
NFS.load(mod_path .. "data/bossBlinds/bigger_boo.lua")()
-- EDITIONS --
NFS.load(mod_path .. "data/editions/positive.lua")()
-- JOKERS --
--- Common ---
NFS.load(mod_path .. "data/jokers/lucky_seven.lua")()
--- Uncommon ---
NFS.load(mod_path .. "data/jokers/711.lua")()
NFS.load(mod_path .. "data/jokers/riif_roof.lua")()
NFS.load(mod_path .. "data/jokers/yes_nothing.lua")()
--- Rare ---
--- Epic ---
--- Legendary ---
--- Exotic ---
---- Character cards ----
NFS.load(mod_path .. "data/jokers/moonlight_cookie.lua")()
NFS.load(mod_path .. "data/jokers/unik.lua")()

--- Cursed ---
NFS.load(mod_path .. "data/jokers/happiness.lua")()
NFS.load(mod_path .. "data/jokers/autocannibalism.lua")()
NFS.load(mod_path .. "data/jokers/the_plant.lua")()
NFS.load(mod_path .. "data/jokers/handcuffs.lua")()
NFS.load(mod_path .. "data/jokers/border_wall.lua")()
--- Devastating ---
--- Catastrophic ---
--- 
--- 
--- Challenges
NFS.load(mod_path .. "data/challenges/chipzel.lua")()
NFS.load(mod_path .. "data/challenges/common_muck.lua")()


