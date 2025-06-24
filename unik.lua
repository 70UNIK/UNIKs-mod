local mod_path = "" .. SMODS.current_mod.path
unik_config = SMODS.current_mod.config
--config tag is only avaliable in baseline cryptid; in almanac, both of those are fixed to true
SMODS.current_mod.config_tab = function() --Config tab
	
	return {
	n = G.UIT.ROOT,
	config = {
		align = "cm",
		padding = 0.05,
		colour = G.C.CLEAR,
	},
	nodes = {
		create_toggle({
			label = localize("unik_legendary_blinds_option"),
			ref_table = unik_config,
			ref_value = "unik_legendary_blinds",
		}),
	},
	}
end
Cryptid.cross_mod_names = {
	CardSleeves = "Card Sleeves",
	Cryptid = "Cryptid",
	sdm0sstuff = "SDM_0's Stuff",
	magic_the_jokering = "Magic the Jokering",
	extracredit = "Extra Credit",
	Buffoonery = "Buffoonery",
}
SMODS.Atlas {
	key = "modicon",
	path = "modicon.png",
	px = 34,
	py = 34
}
SMODS.Atlas {
	key = "achievements",
	path = "cry_achievements.png",
	px = 66,
	py = 66,
}
SMODS.Atlas {
	key = "unik_edition_deck",
	path = "unik_edition_deck.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "unik_sticker_deck",
	path = "unik_sticker_decks.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "unik_sticker_stakes",
	path = "unik_sticker_stakes.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "unik_stakes",
	path = "unik_stakes.png",
	px = 29,
	py = 29
}
SMODS.Atlas {
	key = "unik_enhancements",
	path = "unik_enhancements.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "placeholder_voucher",
	path = "placeholder_voucher.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "unik_akio_icons",
	path = "unik_akio_icons.png",
    px = 34,
    py = 34
}

SMODS.ObjectType({
	key = "riff_raff",
	default = "j_riff_raff",
	cards = {
	},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		-- insert base game jokers
		self:inject_card(G.P_CENTERS.j_riff_raff)
	end,
})
--hooks--
---happiness is mandatory ---
SMODS.Atlas({ 
	key = "unik_showdown_blinds", 
	atlas_table = "ANIMATION_ATLAS", 
	path = "unik_showdown_blinds.png", 
	px = 34, 
	py = 34, 
	frames = 21 })
	SMODS.Atlas({ 
		key = "unik_legendary_blinds", 
		atlas_table = "ANIMATION_ATLAS", 
		path = "unik_legendary_blinds.png", 
		px = 34, 
		py = 34, 
		frames = 21 })
NFS.load(mod_path .. "data/hooks/addremovecards.lua")()
NFS.load(mod_path .. "data/hooks/hand_size_change.lua")()
NFS.load(mod_path .. "data/hooks/legendary_blinds.lua")()
NFS.load(mod_path .. "data/hooks/updater.lua")()
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
SMODS.Atlas {
	key = "unik_tags",
	path = "unik_tags.png",
	px = 34,
	py = 34
}
SMODS.Atlas {
	key = "unik_tags_shiny",
	path = "unik_tags_shiny.png",
	px = 34,
	py = 34
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
	key = "placeholders2",
	path = "placeholders2.png",
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
SMODS.Atlas {
	key = "unik_tarots",
	path = "unik_tarots.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "unik_spectrals",
	path = "unik_spectrals.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "unik_vouchers",
	path = "unik_vouchers.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "unik_lartceps",
	path = "unik_lartceps.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "unik_omegaplanets",
	path = "unik_omegaplanets.png",
	px = 71,
	py = 95
}

-- Pool used by boss blind jokers
SMODS.ObjectType({
	key = "unik_boss_blind_joker",
	default = "j_seance", --cause that is hot garbage
	cards = {},
})
SMODS.ConsumableType {
	key = "lartceps",
	prefix_config = { key = true },
	primary_colour = HEX("000000"),
	secondary_colour = HEX("ff0000"),
	shop_rate = 0.0,
	loc_txt = {},
	default = "c_unik_hellspawn", 
	in_pool = function(self, args)
        return false
    end
}

-- EDITIONS --
NFS.load(mod_path .. "data/editions/steel.lua")()
NFS.load(mod_path .. "data/editions/positive.lua")()
NFS.load(mod_path .. "data/editions/bloated.lua")()
NFS.load(mod_path .. "data/editions/half.lua")()
NFS.load(mod_path .. "data/editions/fuzzy.lua")()
NFS.load(mod_path .. "data/editions/corrupted.lua")()

-- stickers
NFS.load(mod_path .. "data/stickers/triggering.lua")() 
NFS.load(mod_path .. "data/stickers/depleted.lua")() 
NFS.load(mod_path .. "data/stickers/impounded.lua")() 
NFS.load(mod_path .. "data/stickers/disposable.lua")() 
NFS.load(mod_path .. "data/stickers/niko.lua")() 
NFS.load(mod_path .. "data/stickers/ultradebuffed.lua")() 
NFS.load(mod_path .. "data/stickers/baseless.lua")() 

NFS.load(mod_path .. "data/stakes/shitty.lua")() 
NFS.load(mod_path .. "data/stakes/persimmon.lua")() 
NFS.load(mod_path .. "data/overrides/buffoonery_compat.lua")() 
--Stakes
--Persimmon Stake: Cards can be Triggering (Automatically used when possible), goes after gold stake, incompatible with eternal for jokers and consumeables (after orange)
--Shitty Stake: Jokers can be Disposable (Self destructs at end of round), goes after orange stake, incompatible with eternal and perishable (after gold)
--Fat Stake: Jokers can be bloated
--Smiley Stake: Jokers can be Positive
--Half Stake: Jokers can be half
--Dizzy Stake: Jokers can be Fuzzy
--Learning Stake: Jokers can be Corrupted
--Steel Stake: All cards can gain Deditions (Bloated, Positive, Fuzzy, etc), after yellow stake (inside edition pool)

--Enhancements
NFS.load(mod_path .. "data/enhancements/pink_card.lua")()
-- consumables
NFS.load(mod_path .. "data/tarots/wheel_of_misfortune.lua")()
NFS.load(mod_path .. "data/tarots/crossdresser.lua")()
NFS.load(mod_path .. "data/spectrals/foundry.lua")() 
NFS.load(mod_path .. "data/spectrals/unik_gateway.lua")() 
--Vouchers
--Spectral Merchant (Tier 1) Spectrals can appear in shop
--Spectral Tycoon (tier 2) Spectrals appear 2x as often
--Spectral Acclimator (tier 3) Spectrals appear 6x as often
NFS.load(mod_path .. "data/vouchers/spectral_merchant.lua")() 
NFS.load(mod_path .. "data/vouchers/spectral_tycoon.lua")() 
NFS.load(mod_path .. "data/vouchers/spectral_acclimator.lua")() 

--L A R T C E P S--
if unik_config.unik_legendary_blinds then
	NFS.load(mod_path .. "data/lartceps/lartcep_spawn_disable.lua")() 
	NFS.load(mod_path .. "data/lartceps/placard.lua")() 
	NFS.load(mod_path .. "data/lartceps/powerdown.lua")() 
	NFS.load(mod_path .. "data/lartceps/brethren_moon.lua")() 
	NFS.load(mod_path .. "data/lartceps/trim.lua")() 
	NFS.load(mod_path .. "data/lartceps/expiry.lua")() 
	NFS.load(mod_path .. "data/lartceps/extortion.lua")() 

	NFS.load(mod_path .. "data/lartceps/reeducation.lua")() 
	NFS.load(mod_path .. "data/lartceps/garbage.lua")() 
	NFS.load(mod_path .. "data/lartceps/hellspawn.lua")() 
	NFS.load(mod_path .. "data/lartceps/escalation.lua")() 
	NFS.load(mod_path .. "data/lartceps/sauron.lua")() 
	NFS.load(mod_path .. "data/lartceps/blank_lartceps.lua")() 
end
--boosters
NFS.load(mod_path .. "data/boosters/cube_pack.lua")()

--tags
NFS.load(mod_path .. "data/boosters/devil_pack.lua")()
NFS.load(mod_path .. "data/boosters/lartceps_bundle.lua")()
NFS.load(mod_path .. "data/tags/positive.lua")()
NFS.load(mod_path .. "data/tags/demon_tag.lua")()
NFS.load(mod_path .. "data/tags/vessel_tag.lua")()
NFS.load(mod_path .. "data/tags/handcuffs_tag.lua")()
--manacle tag: -1 hand size

--BLINDS--
NFS.load(mod_path .. "data/hooks/blindHooks.lua")() 
if AKYRS then
	NFS.load(mod_path .. "data/bossBlinds/aiko.lua")()
end
NFS.load(mod_path .. "data/bossBlinds/bigger_blind.lua")()
NFS.load(mod_path .. "data/bossBlinds/poppy.lua")() 
NFS.load(mod_path .. "data/bossBlinds/joyless.lua")()
NFS.load(mod_path .. "data/bossBlinds/collapse.lua")()
NFS.load(mod_path .. "data/bossBlinds/vice.lua")()
NFS.load(mod_path .. "data/bossBlinds/sync_catalyst_fail.lua")()
NFS.load(mod_path .. "data/bossBlinds/artisan_builds.lua")()
NFS.load(mod_path .. "data/bossBlinds/cookie.lua")()
NFS.load(mod_path .. "data/bossBlinds/smile.lua")()
NFS.load(mod_path .. "data/bossBlinds/bloon.lua")()
NFS.load(mod_path .. "data/bossBlinds/halved.lua")()
NFS.load(mod_path .. "data/bossBlinds/fuzzy.lua")()
NFS.load(mod_path .. "data/bossBlinds/darkness.lua")()
--The lily: Destroy all cards played after scoring
--The Garbage: Add random debuffed niko cards equal to 20% of total cards in deck
NFS.load(mod_path .. "data/bossBlinds/boring_blank.lua")()
NFS.load(mod_path .. "data/bossBlinds/purple_pentagram.lua")()
NFS.load(mod_path .. "data/bossBlinds/indigo_icbm.lua")() 
NFS.load(mod_path .. "data/bossBlinds/maroon_magnet.lua")()
NFS.load(mod_path .. "data/bossBlinds/raspberry_racket.lua")()
NFS.load(mod_path .. "data/bossBlinds/batman.lua")()
NFS.load(mod_path .. "data/bossBlinds/persimmon_placard.lua")()
NFS.load(mod_path .. "data/bossBlinds/jaundice_jack.lua")()
NFS.load(mod_path .. "data/bossBlinds/septic_seance.lua")()


NFS.load(mod_path .. "data/bossBlinds/green_goalpost.lua")()
NFS.load(mod_path .. "data/bossBlinds/video_poker.lua")()

--blind editions
if (SMODS.Mods['ble'] or {}).can_load then
	NFS.load(mod_path .. "data/blindeditions/steel.lua")()
	NFS.load(mod_path .. "data/blindeditions/bloated.lua")()
	NFS.load(mod_path .. "data/blindeditions/half.lua")()
	NFS.load(mod_path .. "data/blindeditions/positive.lua")()
end

--Bigger blind: Does nothing and is not treated as a boss (but has a chance to replace it). Cannot appear in rerolls. Has normal background.
--Boring Blank: Does nothing and is not treated as a boss (but has a chance to replace it). Cannot appear in rerolls. A finisher "boss"
--Both of above will lack boss music and chicot and luchador will not be active/trigger.
if unik_config.unik_legendary_blinds then
	
	NFS.load(mod_path .. "data/bossBlinds/epic_legendary_check.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_box.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_shackle.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_decision.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_nostalgic_pillar_flint.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_collapse.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_artisan.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_cookie.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_jollyless.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_vice.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_sand.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_reed.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_confrontation.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_xenomorph_queen.lua")()
	NFS.load(mod_path .. "data/bossBlinds/legendary_vessel.lua")() --panopicon. thats it
	NFS.load(mod_path .. "data/bossBlinds/legendary_magnet.lua")()
	NFS.load(mod_path .. "data/bossBlinds/legendary_nuke.lua")() --Uhhh, maybe I can add a joker that scales xmult but caps score at 0.75x and scale only if score is exactly 1.5x, but that breaks the consecutive scoring
	NFS.load(mod_path .. "data/bossBlinds/legendary_sword.lua")() --good high card score thats it.
	NFS.load(mod_path .. "data/bossBlinds/legendary_tornado.lua")() --may need to be reworked to be less annoying
	NFS.load(mod_path .. "data/bossBlinds/legendary_chamber.lua")() --dont have too much rarities, have good amount of hands, blueprint(s) 
	NFS.load(mod_path .. "data/bossBlinds/legendary_crown.lua")() --same as above, but dont have too much hands, maybe have higher ranked cards or planets on hand
	--NFS.load(mod_path .. "data/bossBlinds/legendary_pentagram.lua")() --BUGGY AND GLITCHY
end

if unik_config.unik_legendary_blinds then
	NFS.load(mod_path .. "data/enhancements/namta.lua")()	
end

-- JOKERS --
--- Common ---

-- NFS.load(mod_path .. "data/jokers/holepunched_card.lua")() -- too unoriginal? Could have niche use in multi card hands, but is hanging chad with extra steps

-- not redundant with extra credit, as it instead can stack ON top of the existing lucky enhancement. You just need some more //SEEDS
NFS.load(mod_path .. "data/jokers/lucky_seven.lua")()
NFS.load(mod_path .. "data/jokers/gt710.lua")()
NFS.load(mod_path .. "data/jokers/1_5_joker.lua")() 
-- NFS.load(mod_path .. "data/jokers/dawn.lua")()
NFS.load(mod_path .. "data/jokers/noon.lua")()
NFS.load(mod_path .. "data/jokers/scratch.lua")()
NFS.load(mod_path .. "data/jokers/shitty_joker.lua")()
-- Noon: X2 mult ONLY on the first hand: WIll be an environment in the daytime. It's common as Dusk is uncommon and Night is rare.

--- Uncommon ---
NFS.load(mod_path .. "data/jokers/no_standing_zone.lua")()
NFS.load(mod_path .. "data/jokers/711.lua")()

NFS.load(mod_path .. "data/jokers/riif_roof.lua")()

NFS.load(mod_path .. "data/jokers/cube_joker.lua")() 
NFS.load(mod_path .. "data/jokers/vessel_kiln.lua")()
NFS.load(mod_path .. "data/jokers/borg_cube.lua")()
NFS.load(mod_path .. "data/jokers/recycler.lua")()
NFS.load(mod_path .. "data/jokers/soul_fragment.lua")()

--Celestials:
--Borg Cube (Uncommon): A cube joker. Other steel EDITION cards give 2.5x mult. Obvious star trek reference
--HER (Cursed): Other positive Jokers reduce joker slots by 0.5. Self destructs if edition stripped from this Joker. FTL multiverse reference
--Reality Tear (Cursed): If more than 3 cards are played, other Half Jokers give 0.5X mult. Cannot be debuffed. Self destructs if played at least X hands with 3 cards or less.
--Red Giant (Cursed): If a bloated card is destroyed under it's own effect, destroy adjacent cards. [No self destruct condition (destroyed under it's own effect or edition)]
--Event Horizon (Cursed): Other Fuzzy cards give -$1 - $0, -50 - 0 Chips, -10 - 0 Mult. Self destructs if score is positive and chips and mult are both negative.
--The Warp (Cursed): Other Corrupted card values are multiplied by 0.9X at end of round. Self destructs after 6 rounds.

NFS.load(mod_path .. "data/jokers/coupon_codes.lua")()
NFS.load(mod_path .. "data/jokers/lockpick.lua")()
NFS.load(mod_path .. "data/jokers/cobblestone.lua")()
--- Rare ---
-- NFS.load(mod_path .. "data/jokers/double_container.lua")()
NFS.load(mod_path .. "data/jokers/yes_nothing.lua")()
NFS.load(mod_path .. "data/jokers/invisible_card.lua")()
NFS.load(mod_path .. "data/jokers/ghost_trap.lua")() 
NFS.load(mod_path .. "data/jokers/a_taste_of_power.lua")() 
NFS.load(mod_path .. "data/jokers/riff_rare.lua")() 
NFS.load(mod_path .. "data/jokers/clone_man.lua")()
NFS.load(mod_path .. "data/jokers/epic_blind_sauce.lua")()
NFS.load(mod_path .. "data/jokers/epic_riffin.lua")() 
-- Bun Bun: +X0.2 mult per each card or joker in possession with an edition. If gained corrupted edition, transforms into Bun Bun?

NFS.load(mod_path .. "data/jokers/foundation.lua")() --no image
NFS.load(mod_path .. "data/jokers/lone_despot.lua")() --no image
-- NFS.load(mod_path .. "data/jokers/factorialis.lua")() --not gonna do factorials, cannot be balanced AT ALL.

NFS.load(mod_path .. "data/jokers/pibby.lua")() 
NFS.load(mod_path .. "data/jokers/lily_sprunki.lua")()
NFS.load(mod_path .. "data/jokers/chelsea_ramirez.lua")()
NFS.load(mod_path .. "data/jokers/maya_ramirez.lua")() --broken until smods fix perma_x_chips --no image: the titular character
NFS.load(mod_path .. "data/jokers/yokana_ramirez.lua")() 
NFS.load(mod_path .. "data/jokers/ALICE.lua")()
NFS.load(mod_path .. "data/jokers/white_lily_cookie.lua")()
--- Pure Vanilla Cookie: Removes all detrimental stickers (except for unremovable ones) from ALL jokers, vouchers, consumables and cards while he is present. Only appears in black stake or higher.
NFS.load(mod_path .. "data/jokers/moonlight_cookie.lua")()
NFS.load(mod_path .. "data/jokers/unik.lua")() 
--function for reference


--- Cursed --- 15 of those
NFS.load(mod_path .. "data/jokers/happiness.lua")()
NFS.load(mod_path .. "data/jokers/autocannibalism.lua")()
NFS.load(mod_path .. "data/jokers/impounded.lua")() 
NFS.load(mod_path .. "data/jokers/rancid_smoothie.lua")()
NFS.load(mod_path .. "data/jokers/monster_spawner.lua")() 
NFS.load(mod_path .. "data/jokers/broken_scale.lua")()
NFS.load(mod_path .. "data/jokers/the_plant.lua")() 
NFS.load(mod_path .. "data/jokers/caveman_club.lua")()
NFS.load(mod_path .. "data/jokers/broken_window.lua")()
NFS.load(mod_path .. "data/jokers/goading_joker.lua")() 
NFS.load(mod_path .. "data/jokers/headless_joker.lua")()
NFS.load(mod_path .. "data/jokers/handcuffs.lua")() 
NFS.load(mod_path .. "data/jokers/border_wall.lua")()
NFS.load(mod_path .. "data/jokers/hook_n_discard.lua")() 
NFS.load(mod_path .. "data/jokers/broken_arm.lua")() --no image, the space joker with a br0ken arm
NFS.load(mod_path .. "data/jokers/vampiric_hammer.lua")() --no image, either a vampire with a hammer, or candy apple cookie with her hammer, destroying a mult card.
--Bun Bun? Hidden effect; all shop items become Corrupted; adds a random corrupted card on blind select. 9 in 10 chance to not self destruct after round end (decrease by 1 per failed chance)

--- Devastating ---
--- Catastrophic ---
--- 
---Overrides
NFS.load(mod_path .. "data/overrides/cryptid_balancing.lua")() 
NFS.load(mod_path .. "data/overrides/autocannibal_jokers.lua")() 
NFS.load(mod_path .. "data/overrides/crossmod.lua")() 

--- 
--- 
--- Challenges
-- NFS.load(mod_path .. "data/challenges/lily_goes_fucking_berserk.lua")()
-- NFS.load(mod_path .. "data/challenges/chipzel.lua")() --rework needed: all mult goes into chips. Otherwise it will never work trying to ban all mult based jokers.
-- NFS.load(mod_path .. "data/challenges/multiplication.lua")() --rework needed: all chips go into mult
NFS.load(mod_path .. "data/challenges/common_muck.lua")()
NFS.load(mod_path .. "data/challenges/temu_vouchers.lua")()
-- NFS.load(mod_path .. "data/challenges/monsters.lua")()
NFS.load(mod_path .. "data/challenges/video_poker_1.lua")()
NFS.load(mod_path .. "data/challenges/video_poker_2.lua")()
NFS.load(mod_path .. "data/challenges/rng_2.lua")()
-- NFS.load(mod_path .. "data/challenges/boss_rush_2.lua")()
-- NFS.load(mod_path .. "data/challenges/rush_hour_4.lua")()

-- achievements
NFS.load(mod_path .. "data/achievements/epic_fail.lua")()
NFS.load(mod_path .. "data/achievements/stupid_summoning.lua")()
NFS.load(mod_path .. "data/achievements/bloodbath.lua")()
NFS.load(mod_path .. "data/achievements/moonlight_deathstar.lua")()
if unik_config.unik_legendary_blinds then
	NFS.load(mod_path .. "data/achievements/abyss.lua")()
end
--Future jokers to take ownership:
--Popcorn, Ice Cream, Ramen, Turtle Bean, Clicked Cookie: Properly display negative values + state self destruct values when depleted
--Average Alice (Extra Credit): Godsmarble functionality + sprites
--Dorkshire Tea (Extra Credit): Godsmarble functionality + sprites


-- Jackpot! - Score a Royal Flush against Video Poker
-- Spacefarer - Own Observatory, Perkeo, Satelite, Space Joker and Moonlight Cookie all at once
-- Big Hand, Iron Fist - Win against the Maroon Magnet while you have Efficinare
-- Self Insert - Get UNIK from a gateway (or hypercube)
-- Dicey - Complete the RNG II challenge
-- Alice in Wonderland - Get Alice from obtaining Average Alice
-- Dante's Inferno - Survive a Legendary Blind
-- the other family - Own Yokana, Maya and Chelsea at the same time

-- Vessel Printer - Own Energia and gain 40 Vessel tags at once
-- Hell Invasion - Own every Cursed Joker in the collection.
-- Debuffs, Debuffs everywhere - Have all your Jokers and your entire deck debuffed.
-- Beaned - Die from having zero hand size from depleted Turtle Beans
-- Royal Fuck - Score a Royal Flush against Video Poker and die anyway
-- The Abyss - Die to a Legendary Blind
-- 