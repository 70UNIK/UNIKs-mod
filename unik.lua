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
SMODS.Sound({
	key = "gore6",
	path = "gore6.ogg",
})
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
--placeholder boss icons
SMODS.Atlas ({
	key = "BlindChips",
	atlas_table = "ANIMATION_ATLAS", 
	path = "BlindChips.png",
	px = 34,
	py = 34,
	frames = 21 })

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
SMODS.Atlas {
	key = "unik_epic",
	path = "unik_epic.png",
	px = 71,
	py = 95
}
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
NFS.load(mod_path .. "data/stickers/disposable.lua")() 
NFS.load(mod_path .. "data/stickers/niko.lua")() 
-- consumables
NFS.load(mod_path .. "data/tarots/wheel_of_misfortune.lua")() --no image


--BLINDS--
NFS.load(mod_path .. "data/bossBlinds/poppy.lua")() 
NFS.load(mod_path .. "data/bossBlinds/joyless.lua")()
NFS.load(mod_path .. "data/bossBlinds/collapse.lua")()
NFS.load(mod_path .. "data/bossBlinds/sync_catalyst_fail.lua")()
NFS.load(mod_path .. "data/bossBlinds/artisan_builds.lua")()
--The lily: Destroy all cards played after scoring
--The Garbage: Add random debuffed niko cards equal to 20% of total cards in deck

NFS.load(mod_path .. "data/bossBlinds/purple_pentagram.lua")()
NFS.load(mod_path .. "data/bossBlinds/indigo_icbm.lua")() 
NFS.load(mod_path .. "data/bossBlinds/maroon_magnet.lua")()
NFS.load(mod_path .. "data/bossBlinds/raspberry_racket.lua")()
NFS.load(mod_path .. "data/bossBlinds/batman.lua")()
NFS.load(mod_path .. "data/bossBlinds/persimmon_placard.lua")()
NFS.load(mod_path .. "data/bossBlinds/bigger_boo.lua")()
NFS.load(mod_path .. "data/bossBlinds/green_goalpost.lua")()
NFS.load(mod_path .. "data/bossBlinds/video_poker.lua")()
--Bigger blind: Does nothing and is not treated as a boss (but has a chance to replace it). Cannot appear in rerolls. Has normal background.
--Boring Blank: Does nothing and is not treated as a boss (but has a chance to replace it). Cannot appear in rerolls. A finisher "boss"
--Both of above will lack boss music and chicot and luchador will not be active/trigger.
NFS.load(mod_path .. "data/bossBlinds/legendary_magnet.lua")()
NFS.load(mod_path .. "data/bossBlinds/legendary_vessel.lua")()
NFS.load(mod_path .. "data/bossBlinds/legendary_nuke.lua")()

-- EDITIONS --
NFS.load(mod_path .. "data/editions/positive.lua")()
-- JOKERS --
--- Common ---
-- NFS.load(mod_path .. "data/jokers/holepunched_card.lua")() -- too unoriginal? Could have niche use in multi card hands, but is hanging chad with extra steps

-- not redundant with extra credit, as it instead can stack ON top of the existing lucky enhancement. You just need some more //SEEDS
NFS.load(mod_path .. "data/jokers/lucky_seven.lua")()
NFS.load(mod_path .. "data/jokers/gt710.lua")()
NFS.load(mod_path .. "data/jokers/1_5_joker.lua")() 
-- NFS.load(mod_path .. "data/jokers/dawn.lua")()
NFS.load(mod_path .. "data/jokers/noon.lua")()
-- Noon: X2 mult ONLY on the first hand: WIll be an environment in the daytime. It's common as Dusk is uncommon and Night is rare.

--- Uncommon ---
NFS.load(mod_path .. "data/jokers/no_standing_zone.lua")()
NFS.load(mod_path .. "data/jokers/711.lua")()

NFS.load(mod_path .. "data/jokers/riif_roof.lua")()
NFS.load(mod_path .. "data/jokers/yes_nothing.lua")()
NFS.load(mod_path .. "data/jokers/cube_joker.lua")() 
NFS.load(mod_path .. "data/jokers/recycler.lua")()
NFS.load(mod_path .. "data/jokers/soul_fragment.lua")()

NFS.load(mod_path .. "data/jokers/coupon_codes.lua")()
--NFS.load(mod_path .. "data/jokers/big_alice.lua")() (unneeded and already in the form of big joker)
--- Rare ---
NFS.load(mod_path .. "data/jokers/ghost_trap.lua")() 
NFS.load(mod_path .. "data/jokers/a_taste_of_power.lua")() 

 --rare
--- Epic ---
NFS.load(mod_path .. "data/jokers/foundation.lua")() --no image
NFS.load(mod_path .. "data/jokers/lily_sprunki.lua")()
NFS.load(mod_path .. "data/jokers/chelsea_ramirez.lua")()
--NFS.load(mod_path .. "data/jokers/maya_ramirez.lua")() --broken until smods fix perma_x_chips --no image: the titular character
NFS.load(mod_path .. "data/jokers/yokana_ramirez.lua")() 
NFS.load(mod_path .. "data/jokers/ALICE.lua")()

NFS.load(mod_path .. "data/jokers/white_lily_cookie.lua")()

---- this will be her moonflower faerie form
--- Pure Vanilla Cookie: Removes all detrimental stickers (except for unremovable ones) from ALL jokers, vouchers, consumables and cards while he is present. Only appears in black stake or higher.
NFS.load(mod_path .. "data/jokers/moonlight_cookie.lua")()
NFS.load(mod_path .. "data/jokers/unik.lua")() 


--- Cursed --- 15 of those
NFS.load(mod_path .. "data/jokers/happiness.lua")()
NFS.load(mod_path .. "data/jokers/autocannibalism.lua")()
NFS.load(mod_path .. "data/jokers/impounded.lua")() -- no image, an impound notice
NFS.load(mod_path .. "data/jokers/rancid_smoothie.lua")() -- no image, the smoothie, but looking ass
NFS.load(mod_path .. "data/jokers/monster_spawner.lua")() --no image: mc monster spawner
NFS.load(mod_path .. "data/jokers/broken_scale.lua")() -- broken double scale/vary fair
NFS.load(mod_path .. "data/jokers/the_plant.lua")()
NFS.load(mod_path .. "data/jokers/caveman_club.lua")()
NFS.load(mod_path .. "data/jokers/broken_window.lua")()
NFS.load(mod_path .. "data/jokers/goading_joker.lua")() --no image, patronizing joker, but more crass, rugged and dirty
NFS.load(mod_path .. "data/jokers/headless_joker.lua")()
NFS.load(mod_path .. "data/jokers/handcuffs.lua")() 
NFS.load(mod_path .. "data/jokers/border_wall.lua")()
NFS.load(mod_path .. "data/jokers/hook_n_discard.lua")() 
NFS.load(mod_path .. "data/jokers/broken_arm.lua")() --no image, the space joker with a br0ken arm
NFS.load(mod_path .. "data/jokers/vampiric_hammer.lua")() --no image, either a vampire with a hammer, or candy apple cookie with her hammer, destroying a mult card.

--- Devastating ---
--- Catastrophic ---
--- 
--- 
--- Challenges
NFS.load(mod_path .. "data/challenges/lily_goes_fucking_berserk.lua")()
NFS.load(mod_path .. "data/challenges/rng_2.lua")()
NFS.load(mod_path .. "data/challenges/chipzel.lua")()
NFS.load(mod_path .. "data/challenges/multiplication.lua")()
NFS.load(mod_path .. "data/challenges/common_muck.lua")()
NFS.load(mod_path .. "data/challenges/video_poker_1.lua")()
NFS.load(mod_path .. "data/challenges/video_poker_2.lua")()
NFS.load(mod_path .. "data/challenges/video_poker_3.lua")()
NFS.load(mod_path .. "data/challenges/boss_rush_2.lua")()
NFS.load(mod_path .. "data/challenges/boss_rush_3.lua")() --hell
NFS.load(mod_path .. "data/challenges/rush_hour_4.lua")()

-- achievements
-- Jackpot! - Score a Royal Flush against Video Poker
-- IN SPACE! - Have Observatory, Perkeo and Moonlight Cookie all at once
-- Big Hand, Iron Fist - Win against the Maroon Magnet while you have Efficinare
-- Self Insert - Get UNIK from a gateway.
-- Dicey - Complete the RNG II challenge
-- Alice in Wonderland - Get Alice from obtaining Average Alice

-- Stupid Summoning - Rig an Evocation and use it.
-- Hell Invasion - Own every Cursed Joker in the collection.
-- Debuffs, Debuffs everywhere - Have all your Jokers and your entire deck debuffed.
-- Beaned - Die from having zero hand size from depleted Turtle Beans
-- Epic Fail - Score under -1.79e308 Chips in a single hand
-- Royal Fuck - Score a Royal Flush against Video Poker and die anyway

--Artwork to do:

--Monster spawner
--Rancid Smoothie
--Impound Notice
--Broken scale
--Goading Joker

--Broken Arm
--Vampiric Hammer
--The Evocation
--hypercube
--cube pack (booster)

--Legendary magnet, vessel and nuke



