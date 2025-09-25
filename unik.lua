local mod_path = "" .. SMODS.current_mod.path
unik_config = SMODS.current_mod.config
UNIK = SMODS.current_mod

if not UNIK then
	UNIK = {}
end

-- Enable optional features
SMODS.current_mod.optional_features = {
	retrigger_joker = true,
	post_trigger = true,
	quantum_enhancements = false,
	-- Here are some other ones Steamodded has
	-- Cryptid doesn't use them YET, but these should be uncommented if (SMODS.Mods["Cryptid"] or {}).can_load and   uses them
	-- These ones add new card areas that Steamodded will calculate through
	-- Might already be useful for sticker calc

	-- Cryptid uses cardarea deck now
	cardareas = {
		deck = true,
		discard = true, -- used by scorch
	},
}

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
		create_toggle({
			label = localize("unik_cryptid_nerfs_option"),
			ref_table = unik_config,
			ref_value = "unik_cryptid_nerfs",
		}),
	},
	}
end

NFS.load(mod_path .. "talismanless.lua")()
NFS.load(mod_path .. "data/hooks/startup.lua")()
NFS.load(mod_path .. "data/hooks/addremovecards.lua")()
NFS.load(mod_path .. "data/hooks/hand_size_change.lua")()
NFS.load(mod_path .. "data/hooks/legendary_blinds.lua")()
NFS.load(mod_path .. "data/hooks/colours.lua")()
NFS.load(mod_path .. "data/hooks/updater.lua")()
NFS.load(mod_path .. "data/misc/plurals.lua")()

--Custom spectrum stuff
function UNIK.can_load_spectrums()
	if (not PB_UTIL or ( PB_UTIL and not PB_UTIL.config.suits_enabled))
	 and not next(SMODS.find_mod("Bunco"))
	  and not next(SMODS.find_mod("SixSuits")) 
	  and not next(SMODS.find_mod("SpectrumFramework"))
	  then
		return true
	end
	return false
end
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
SMODS.Sound({
	key = "gore6",
	path = "gore6.ogg",
})
SMODS.Sound({
	key = "explosion1",
	path = "explosion1.ogg",
})



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
	key = "unik_decks",
	path = "unik_decks.png",
	px = 71,
	py = 95
}

SMODS.Atlas({ 
  key = "unik_rotarots", 
  path = "unik_rotarots2.png", 
  px = 107, 
  py = 107
})

SMODS.Atlas {
	key = "unik_grab_bag_jokers",
	path = "unik_grab_bag_jokers.png",
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

--RARITIES--
--Discount exotic
SMODS.Rarity({
	key = "unik_ancient",
	loc_txt = {},
	badge_colour = G.C.UNIK_ANCIENT,
})
if (SMODS.Mods["Cryptid"] or {}).can_load then
    Cryptid.pointerblistifytype("rarity", "unik_ancient")
end

--Discount Cursed
SMODS.Rarity({
	key = "unik_detrimental",
	loc_txt = {},
	badge_colour = HEX("474931"),
})


-- stickers
NFS.load(mod_path .. "data/stickers/limited_edition.lua")() 
NFS.load(mod_path .. "data/stickers/triggering.lua")() 
NFS.load(mod_path .. "data/stickers/depleted.lua")() 
NFS.load(mod_path .. "data/stickers/impounded.lua")() 
NFS.load(mod_path .. "data/stickers/disposable.lua")() 
NFS.load(mod_path .. "data/stickers/niko.lua")() 
NFS.load(mod_path .. "data/stickers/ultradebuffed.lua")() 
if not (SMODS.Mods["Cryptid"] or {}).can_load then
	NFS.load(mod_path .. "data/stickers/cryptidless_sticker_logic.lua")() 
end


-- STAKES --
NFS.load(mod_path .. "data/stakes/blue_stake_fix.lua")() 
NFS.load(mod_path .. "data/stakes/shitty.lua")() 
NFS.load(mod_path .. "data/stakes/persimmon.lua")() 
if (SMODS.Mods["Buffoonery"] or {}).can_load then
	NFS.load(mod_path .. "data/overrides/buffoonery_compat.lua")() 
end
NFS.load(mod_path .. "data/stakes/stake_card_modifiers.lua")() 
--decks
NFS.load(mod_path .. "data/decks/polychrome_deck.lua")()
NFS.load(mod_path .. "data/decks/steel_deck.lua")()
NFS.load(mod_path .. "data/decks/shining_glitter_deck.lua")()

--Enhancements
NFS.load(mod_path .. "data/enhancements/pink_card.lua")()
if MoreFluff then
	NFS.load(mod_path .. "data/enhancements/green_card.lua")()
	NFS.load(mod_path .. "data/enhancements/bill_card.lua")()
end
NFS.load(mod_path .. "data/enhancements/dollar_card.lua")()	
if unik_config.unik_legendary_blinds then
	NFS.load(mod_path .. "data/enhancements/namta.lua")()	
end

-- EDITIONS --
NFS.load(mod_path .. "data/editions/shining_glitter.lua")()
NFS.load(mod_path .. "data/editions/steel.lua")()
NFS.load(mod_path .. "data/editions/positive.lua")()
NFS.load(mod_path .. "data/editions/bloated.lua")()
NFS.load(mod_path .. "data/editions/half.lua")()
NFS.load(mod_path .. "data/editions/fuzzy.lua")()
NFS.load(mod_path .. "data/editions/corrupted.lua")()



--Load suit types

UNIK.light_suits = { 'Diamonds', 'Hearts' }
UNIK.dark_suits = { 'Spades', 'Clubs' }
NFS.load(mod_path .. "data/suit_shennannigans/enhancement_rank_suit.lua")()
NFS.load(mod_path .. "data/suit_shennannigans/light_dark_suits.lua")()
if (SMODS.Mods["Cryptid"] or {}).can_load  then
	NFS.load(mod_path .. "data/overrides/abstract_fix.lua")()
end

NFS.load(mod_path .. "data/poker_hands/spectrum_calc.lua")()
--HANDS


SMODS.Atlas {
	key = "unik_poker_hand_shit",
	path = "poker_hand_shit.png",
	px = 71,
	py = 95
}
if not (SMODS.Mods["Cryptid"] or {}).can_load  then
	NFS.load(mod_path .. "data/poker_hands/bulwark.lua")()
	--planets
	NFS.load(mod_path .. "data/planets/asteroid_belt.lua")()
end
if UNIK.can_load_spectrums() then
	NFS.load(mod_path .. "data/poker_hands/spectrum.lua")()
	NFS.load(mod_path .. "data/poker_hands/straight_spectrum.lua")()
	NFS.load(mod_path .. "data/poker_hands/spectrum_house.lua")()
	NFS.load(mod_path .. "data/poker_hands/spectrum_five.lua")()
	--planets
	NFS.load(mod_path .. "data/planets/quaoar.lua")()
	NFS.load(mod_path .. "data/planets/haumea.lua")()
	NFS.load(mod_path .. "data/planets/sedna.lua")()
	NFS.load(mod_path .. "data/planets/makemake.lua")()
end
if next(SMODS.find_mod("Bunco")) then
	NFS.load(mod_path .. "data/poker_hands/bunco_override.lua")()
end
if next(SMODS.find_mod("SixSuits")) then
	NFS.load(mod_path .. "data/poker_hands/six_suits_override.lua")()
end
if next(SMODS.find_mod("SpectrumFramework")) then
	NFS.load(mod_path .. "data/poker_hands/framework_override.lua")()
end
------------------------
---CONSUMABLES
--------------------------
---
---TAROTS
NFS.load(mod_path .. "data/tarots/crossdresser.lua")()
NFS.load(mod_path .. "data/tarots/oligarch.lua")()
NFS.load(mod_path .. "data/tarots/wheel_of_misfortune.lua")()

---SPECTRALS
NFS.load(mod_path .. "data/spectrals/foundry.lua")() 
NFS.load(mod_path .. "data/spectrals/sparkle.lua")() 
NFS.load(mod_path .. "data/spectrals/prism.lua")() 
NFS.load(mod_path .. "data/spectrals/bloater.lua")() 
--
NFS.load(mod_path .. "data/spectrals/unik_gateway.lua")() --rework: destroy 2 leftmost non eternals, create an ancient.

--PLANETS



--rotarots
if MoreFluff then
	NFS.load(mod_path .. "data/tarots/rotated_crossdresser.lua")() 
	NFS.load(mod_path .. "data/tarots/rotated_oligarch.lua")() 
	NFS.load(mod_path .. "data/tarots/rotated_wheel_of_misfortune.lua")() 
end
--L A R T C E P S--
if unik_config.unik_legendary_blinds then
	NFS.load(mod_path .. "data/lartceps/lartcep_spawn_disable.lua")() 
	NFS.load(mod_path .. "data/lartceps/placard.lua")() 
	NFS.load(mod_path .. "data/lartceps/powerdown.lua")() 
	NFS.load(mod_path .. "data/lartceps/brethren_moon.lua")() 
	NFS.load(mod_path .. "data/lartceps/trim.lua")() 
	if (SMODS.Mods["Cryptid"] or {}).can_load then
		NFS.load(mod_path .. "data/lartceps/expiry.lua")() 
	end
	NFS.load(mod_path .. "data/lartceps/extortion.lua")() 

	NFS.load(mod_path .. "data/lartceps/reeducation.lua")() 
	NFS.load(mod_path .. "data/lartceps/garbage.lua")() 
	NFS.load(mod_path .. "data/lartceps/hellspawn.lua")() 
	NFS.load(mod_path .. "data/lartceps/escalation.lua")() 
	NFS.load(mod_path .. "data/lartceps/sauron.lua")() 
	NFS.load(mod_path .. "data/lartceps/blank_lartceps.lua")() 
end

--Vouchers
NFS.load(mod_path .. "data/vouchers/spectral_merchant.lua")() 
NFS.load(mod_path .. "data/vouchers/spectral_tycoon.lua")() 
if (SMODS.Mods["Cryptid"] or {}).can_load  then
	NFS.load(mod_path .. "data/vouchers/spectral_acclimator.lua")() 
end

--MF color cards
SMODS.Atlas({ 
  key = "unik_colours", 
  path = "unik_colours.png",
  px = 71, 
  py = 95 
})
--Color cards
if MoreFluff and mf_config and mf_config["Colour Cards"] == true then
	NFS.load(mod_path .. "data/colours/spectral_blue.lua")()
	if (SMODS.Mods["paperback"] or {}).can_load then
		NFS.load(mod_path .. "data/colours/lavender.lua")()
	end
	NFS.load(mod_path .. "data/colours/stone_grey.lua")()
end


--boosters
--TODO: Replace "cube pack" with "UNIK's pack" in the next update, basically an icon pack of sorts
NFS.load(mod_path .. "data/boosters/cube_pack.lua")()
NFS.load(mod_path .. "data/boosters/lartceps_bundle.lua")()
NFS.load(mod_path .. "data/boosters/egg_pack.lua")()

--tags


NFS.load(mod_path .. "data/tags/shining_glitter_tag.lua")()
NFS.load(mod_path .. "data/tags/steel_tag.lua")()
NFS.load(mod_path .. "data/tags/demon_tag.lua")()
NFS.load(mod_path .. "data/boosters/devil_pack.lua")()
NFS.load(mod_path .. "data/tags/vessel_tag.lua")()
NFS.load(mod_path .. "data/tags/handcuffs_tag.lua")()
NFS.load(mod_path .. "data/tags/positive.lua")()
--manacle tag: -1 hand size

--BLINDS--
NFS.load(mod_path .. "data/hooks/blindHooks.lua")() 
NFS.load(mod_path .. "data/bossBlinds/bigger_blind.lua")()
NFS.load(mod_path .. "data/bossBlinds/poppy.lua")() 

NFS.load(mod_path .. "data/bossBlinds/collapse.lua")()
NFS.load(mod_path .. "data/bossBlinds/vice.lua")()
NFS.load(mod_path .. "data/bossBlinds/sync_catalyst_fail.lua")()
NFS.load(mod_path .. "data/bossBlinds/artisan_builds.lua")()
NFS.load(mod_path .. "data/bossBlinds/cookie.lua")()
NFS.load(mod_path .. "data/bossBlinds/xchips_hater.lua")()
NFS.load(mod_path .. "data/bossBlinds/magician.lua")()
NFS.load(mod_path .. "data/bossBlinds/smile.lua")()
NFS.load(mod_path .. "data/bossBlinds/bloon.lua")()
NFS.load(mod_path .. "data/bossBlinds/halved.lua")()
NFS.load(mod_path .. "data/bossBlinds/fuzzy.lua")()
NFS.load(mod_path .. "data/bossBlinds/darkness.lua")() --Unless i rework edition effect, crossmod?
if (SMODS.Mods["Cryptid"] or {}).can_load  then
	NFS.load(mod_path .. "data/bossBlinds/cryptid/joyless.lua")() --Cryptid crossmod
end

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
NFS.load(mod_path .. "data/bossBlinds/eternal_egg.lua")()
NFS.load(mod_path .. "data/bossBlinds/hate_ball.lua")()
NFS.load(mod_path .. "data/bossBlinds/salmon_steps.lua")()
NFS.load(mod_path .. "data/bossBlinds/burgundy_brain.lua")()
NFS.load(mod_path .. "data/bossBlinds/green_goalpost.lua")()
NFS.load(mod_path .. "data/bossBlinds/video_poker.lua")()

--blind editions
if (SMODS.Mods['ble'] or {}).can_load then
	NFS.load(mod_path .. "data/blindeditions/steel.lua")()
	NFS.load(mod_path .. "data/blindeditions/bloated.lua")()
	NFS.load(mod_path .. "data/blindeditions/half.lua")()
	NFS.load(mod_path .. "data/blindeditions/positive.lua")()
end

if unik_config.unik_legendary_blinds then
	NFS.load(mod_path .. "data/bossBlinds/epic_legendary_check.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_box.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_shackle.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_decision.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_nostalgic_pillar_flint.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_collapse.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_artisan.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_cookie.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_vice.lua")()
	if (SMODS.Mods["Cryptid"] or {}).can_load  then
		NFS.load(mod_path .. "data/bossBlinds/cryptid/epic_jollyless.lua")()
	end
	NFS.load(mod_path .. "data/bossBlinds/epic_sink.lua")() --hold for now until a more interesting effect is in place
	NFS.load(mod_path .. "data/bossBlinds/epic_sand.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_miser.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_reed.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_confrontation.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_height.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_whole.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_xenomorph_queen.lua")()
	--Blinds below require talisman due to exponential requirements
	if Talisman then
		NFS.load(mod_path .. "data/bossBlinds/legendary_vessel.lua")() --panopicon. thats it
	end
	NFS.load(mod_path .. "data/bossBlinds/legendary_magnet.lua")()
	NFS.load(mod_path .. "data/bossBlinds/legendary_nuke.lua")()
	if Talisman then
		NFS.load(mod_path .. "data/bossBlinds/legendary_sword.lua")() --good high card score thats it.
	end
	NFS.load(mod_path .. "data/bossBlinds/legendary_tornado.lua")()
	if Talisman then
		NFS.load(mod_path .. "data/bossBlinds/legendary_chamber.lua")() --dont have too much rarities, have good amount of hands, blueprint(s) 
	end
	NFS.load(mod_path .. "data/bossBlinds/legendary_crown.lua")() --same as above, but dont have too much hands, maybe have higher ranked cards or planets on hand
end

----------------------------------------
---JONKLERS
----------------------------------------

--Common
NFS.load(mod_path .. "data/jokers/unik/common/lucky_seven.lua")()
NFS.load(mod_path .. "data/jokers/unik/common/gt710.lua")()
NFS.load(mod_path .. "data/jokers/unik/common/golden_glove.lua")() --NoImage
NFS.load(mod_path .. "data/jokers/unik/common/instant_gratification.lua")() --NoImage
NFS.load(mod_path .. "data/jokers/unik/common/1_5_joker.lua")() 
NFS.load(mod_path .. "data/jokers/unik/common/noon.lua")()
NFS.load(mod_path .. "data/jokers/unik/common/shitty_joker.lua")()
NFS.load(mod_path .. "data/jokers/unik/common/skipping_stones.lua")()
NFS.load(mod_path .. "data/jokers/unik/common/yes_nothing.lua")()

if (not PB_UTIL or ( PB_UTIL and not PB_UTIL.config.suits_enabled)) and not next(SMODS.find_mod("Bunco")) then
	NFS.load(mod_path .. "data/jokers/unik/poker_hands/zealous_joker.lua")()
	NFS.load(mod_path .. "data/jokers/unik/poker_hands/lurid_joker.lua")()
end

NFS.load(mod_path .. "data/jokers/unik/common/double_container.lua")() --Uncommon when morefluff installed

--Uncommon
NFS.load(mod_path .. "data/jokers/unik/uncommon/no_standing_zone.lua")()
NFS.load(mod_path .. "data/jokers/unik/uncommon/riif_roof.lua")()
NFS.load(mod_path .. "data/jokers/unik/uncommon/tax_haven.lua")()
NFS.load(mod_path .. "data/jokers/unik/uncommon/cube_joker.lua")() 
NFS.load(mod_path .. "data/jokers/unik/uncommon/vessel_kiln.lua")()
NFS.load(mod_path .. "data/jokers/unik/uncommon/borg_cube.lua")()
NFS.load(mod_path .. "data/jokers/unik/uncommon/recycler.lua")()
NFS.load(mod_path .. "data/jokers/unik/uncommon/soul_fragment.lua")()
NFS.load(mod_path .. "data/jokers/unik/uncommon/fat_joker.lua")()
NFS.load(mod_path .. "data/jokers/unik/uncommon/joker_dollar.lua")()	
NFS.load(mod_path .. "data/jokers/unik/uncommon/lockpick.lua")()
NFS.load(mod_path .. "data/jokers/unik/uncommon/cobblestone.lua")()
NFS.load(mod_path .. "data/jokers/unik/uncommon/chipzel.lua")()
NFS.load(mod_path .. "data/jokers/unik/uncommon/euclid.lua")()
NFS.load(mod_path .. "data/jokers/unik/uncommon/pavement_joker.lua")() 
NFS.load(mod_path .. "data/jokers/unik/uncommon/uniku.lua")() 
NFS.load(mod_path .. "data/jokers/unik/uncommon/D16.lua")() 
NFS.load(mod_path .. "data/jokers/unik/uncommon/rainbow_river.lua")() 

--Rare
NFS.load(mod_path .. "data/jokers/unik/rare/711.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/minimized.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/copycat.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/invisible_card.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/ghost_trap.lua")() 
NFS.load(mod_path .. "data/jokers/unik/rare/a_taste_of_power.lua")() 
NFS.load(mod_path .. "data/jokers/unik/rare/riff_rare.lua")() 
NFS.load(mod_path .. "data/jokers/unik/rare/clone_man.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/epic_blind_sauce.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/foundation.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/EARTHMOVER.lua")() 
NFS.load(mod_path .. "data/jokers/unik/rare/last_tile.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/ghost_joker.lua")() 
NFS.load(mod_path .. "data/jokers/unik/rare/lone_despot.lua")() 

if (not PB_UTIL or ( PB_UTIL and not PB_UTIL.config.suits_enabled)) and not next(SMODS.find_mod("Bunco")) then
	NFS.load(mod_path .. "data/jokers/unik/poker_hands/the_dynasty.lua")()
end
NFS.load(mod_path .. "data/jokers/unik/legendary/megatron.lua")() 

--Rare (characters)
NFS.load(mod_path .. "data/jokers/unik/rare/poppy.lua")() 
NFS.load(mod_path .. "data/jokers/unik/rare/kouign_amann_cookie.lua")() --FULL REWORK NEEDED
NFS.load(mod_path .. "data/jokers/unik/rare/pibby.lua")() 
NFS.load(mod_path .. "data/jokers/unik/rare/lily_sprunki.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/chelsea_ramirez.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/maya_ramirez.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/yokana_ramirez.lua")() 

--Ancient
--NIKO
--WORLD MACHINE
NFS.load(mod_path .. "data/jokers/unik/ancient/ALICE.lua")()
NFS.load(mod_path .. "data/jokers/unik/ancient/white_lily_cookie.lua")()
NFS.load(mod_path .. "data/jokers/unik/ancient/moonlight_cookie.lua")()
NFS.load(mod_path .. "data/jokers/unik/ancient/unik.lua")() 


---------------
---CROSSMOD (non cursed) JONKLERS
---------------
if (SMODS.Mods["paperback"] or {}).can_load then
	NFS.load(mod_path .. "data/jokers/paperback/binary_asteroid.lua")()
	NFS.load(mod_path .. "data/jokers/paperback/weetomancer.lua")() 
end
if (SMODS.Mods["Cryptid"] or {}).can_load  then
	NFS.load(mod_path .. "data/jokers/cryptid/scratch.lua")()
	NFS.load(mod_path .. "data/jokers/cryptid/hacker.lua")()
	NFS.load(mod_path .. "data/jokers/cryptid/coupon_codes.lua")()
	NFS.load(mod_path .. "data/jokers/cryptid/epic_riffin.lua")() 
end

if next(SMODS.find_mod("GrabBag")) then
	NFS.load(mod_path .. "data/jokers/grab_bag/poppy.lua")() 
	NFS.load(mod_path .. "data/jokers/grab_bag/collapse.lua")() 
	NFS.load(mod_path .. "data/jokers/grab_bag/artesian.lua")() 
	if (SMODS.Mods["Cryptid"] or {}).can_load   then
		NFS.load(mod_path .. "data/jokers/grab_bag/jollyless.lua")() 
	end
	NFS.load(mod_path .. "data/jokers/grab_bag/bloon.lua")() 
	NFS.load(mod_path .. "data/jokers/grab_bag/smiley.lua")() 
	NFS.load(mod_path .. "data/jokers/grab_bag/halved.lua")() 
	NFS.load(mod_path .. "data/jokers/grab_bag/fuzzy.lua")() 
end
local mainmenuref2 = Game.main_menu
Game.main_menu = function(change_context)
	if unik_config.unik_legendary_blinds then
  	if next(SMODS.find_mod("finity")) then
		local legendarybossblinds = {
		["bl_unik_legendary_crown"] = {"j_unik_legendary_crown","Korruptionkruunu"},
		}
		for k, v in pairs(legendarybossblinds) do
			FinisherBossBlindStringMap[k] = v
		end
	end


  end
  local ret = mainmenuref2(change_context)
  return ret
end

--Finity Jokers
if next(SMODS.find_mod("finity")) then

	if unik_config.unik_legendary_blinds then
		if (SMODS.Mods["Cryptid"] or {}).can_load then
			Cryptid.pointerblistifytype("rarity", "unik_finity_legendary_crown")
		end
		SMODS.Rarity({
			key = "unik_legendary_blind_finity",
			loc_txt = {},
			badge_colour = G.C.UNIK_RGB,
		})
		NFS.load(mod_path .. "data/jokers/finity/legendary_crown.lua")() 
	
	end
end

---------------
---CURSED JONKLERS
---------------
NFS.load(mod_path .. "data/jokers/unik/detrimental/happiness.lua")()
NFS.load(mod_path .. "data/jokers/unik/detrimental/autocannibalism.lua")()
NFS.load(mod_path .. "data/jokers/unik/detrimental/impounded.lua")() 
NFS.load(mod_path .. "data/jokers/unik/detrimental/monster_spawner.lua")() 
NFS.load(mod_path .. "data/jokers/unik/detrimental/broken_scale.lua")()
NFS.load(mod_path .. "data/jokers/unik/detrimental/xchips_hater.lua")() --noimage
if (SMODS.Mods["Cryptid"] or {}).can_load  then
	NFS.load(mod_path .. "data/jokers/cryptid/rancid_smoothie.lua")()
	NFS.load(mod_path .. "data/jokers/cryptid/nostalgic_astral_in_a_bottle.lua")() --noimage
end

--Blind based detrimental/cursed
NFS.load(mod_path .. "data/jokers/unik/detrimental/the_plant.lua")() 
NFS.load(mod_path .. "data/jokers/unik/detrimental/caveman_club.lua")()
NFS.load(mod_path .. "data/jokers/unik/detrimental/broken_window.lua")()
NFS.load(mod_path .. "data/jokers/unik/detrimental/goading_joker.lua")() 
NFS.load(mod_path .. "data/jokers/unik/detrimental/headless_joker.lua")()
NFS.load(mod_path .. "data/jokers/unik/detrimental/handcuffs.lua")() 
NFS.load(mod_path .. "data/jokers/unik/detrimental/border_wall.lua")()
NFS.load(mod_path .. "data/jokers/unik/detrimental/hook_n_discard.lua")() 
NFS.load(mod_path .. "data/jokers/unik/detrimental/broken_arm.lua")() 
NFS.load(mod_path .. "data/jokers/unik/detrimental/decaying_tooth.lua")() --noimage
NFS.load(mod_path .. "data/jokers/unik/detrimental/robert.lua")() --noimage
NFS.load(mod_path .. "data/jokers/unik/detrimental/vampiric_hammer.lua")()
--- 
---Overrides
if (SMODS.Mods["Cryptid"] or {}).can_load and unik_config.unik_cryptid_nerfs then
	NFS.load(mod_path .. "data/overrides/cryptid_balancing.lua")() 
end

NFS.load(mod_path .. "data/overrides/autocannibal_jokers.lua")() 
NFS.load(mod_path .. "data/overrides/crossmod.lua")() 
NFS.load(mod_path .. "data/overrides/last_hand.lua")() 


--Challenges gone until I fix them to work with new API NFS.load(mod_path .. "data/challenges/common_muck.lua")()
 NFS.load(mod_path .. "data/challenges/singleton.lua")()
NFS.load(mod_path .. "data/challenges/video_poker_1.lua")()
NFS.load(mod_path .. "data/challenges/video_poker_2.lua")()
if unik_config.unik_legendary_blinds then
	NFS.load(mod_path .. "data/challenges/cookie_clicker.lua")()
	NFS.load(mod_path .. "data/challenges/cookie_clicker_2.lua")()
end
-- NFS.load(mod_path .. "data/challenges/rng_2.lua")()

if (not (SMODS.Mods["Cryptid"] or {}).can_load  ) then
	very_fair_quip = {}
end

-- achievements
-- NFS.load(mod_path .. "data/achievements/epic_fail.lua")()
-- NFS.load(mod_path .. "data/achievements/stupid_summoning.lua")()
-- NFS.load(mod_path .. "data/achievements/bloodbath.lua")()
-- NFS.load(mod_path .. "data/achievements/moonlight_deathstar.lua")()
if unik_config.unik_legendary_blinds then
	NFS.load(mod_path .. "data/achievements/abyss.lua")()
end

NFS.load(mod_path .. "data/overrides/blind_spawn.lua")()
function vice_check()
	if G.GAME.round_resets.ante >= 0 and G.GAME.round_resets.ante < 2 then
		return G.GAME.win_ante
	end
	G.GAME.unik_vice_squeeze = G.GAME.unik_vice_squeeze or 1
	G.GAME.OvershootFXVal = G.GAME.OvershootFXVal or 0
	if G.GAME.OvershootFXVal >= 4 then
		return 1
	end
	if G.GAME.win_ante < G.GAME.unik_vice_squeeze then
		return 1
	end
    if G.GAME.round_resets.ante and G.GAME.round_resets.ante % math.floor(G.GAME.win_ante/(math.floor(G.GAME.unik_vice_squeeze*10000)/10000)) == 0 then
        return 1
    end
    if G.GAME.round_resets.ante and G.GAME.round_resets.ante% G.GAME.win_ante == 0 then
        return 1
    end
	if G.GAME.all_finishers then
		return 1
	end
    return G.GAME.win_ante
end

--UI
NFS.load(mod_path .. "data/ui/overshoot.lua")()
NFS.load(mod_path .. "data/ui/blind_exponent.lua")()
if AKYRS then
	NFS.load(mod_path .. "data/ui/aiko_icons.lua")()
end
NFS.load(mod_path .. "data/menu.lua")()
---
---Indigo ICBM: Gain X1 Mult per hand played, lose X1 mult if hand exceeds 3X requirements.
---Persimmon Placard: All cards are debuffed, held debuffed cards each give X1 mult and $1. Increase Xmult by +X0.1 per played debuffed card
---Raspberry Racket: If Money < $50 per hand, set money to $50. Increase this by $2 per Dollar Card scored.
---Maroon Magnet: Convert all held cards to steel cards, scored Steel Cards give X2 mult
---Jaundice Jack: Gain X0.4 Mult per discarded Jack.
---Black Bat: All other Jokers (except Black Bat) are debuffed, ^1.25 Mult per debuffed Joker.
---Septic Seance: Create a negative shortcut, seance, paved joker and/or four fingers if you don't already on blind select. Create an ://EXPLOIT if played hand is not a straight flush.
---Purple Pentagram: All Boss Blinds are the Decision. Destroy all Cursed Jokers and gain X2 Mult per destroyed Cursed Joker.
---Salmon Steps: ^1.75 Chips. All Mult is added to Chips instead. 
---
---Epic Blinds:
---Epic Collapse: Rankless and suitless cards each give ^1.1 Mult.
---Epic Xenomorph Queen: If all played cards are debuffed, gain ^0.05 Mult per played debuffed card.
---Epic Artesian: Gain ^Mult proportionate to X0.0001 the reroll cost per reroll. ($2 --> 0.0002, so it's encouraged to not have free rerolls))
---Epic Jollyless: Destroy all Jolly and M jokers per blind select, gain ^0.1 Mult per destroyed Jolly/M Joker. Destroy all played cards if hand does not contain a pair.
---Epic Box: Common Jokers each give ^1.1 Mult.
---Epic Decision: Gain ^1 Mult per Lartceps card used this run. Lartceps packs may spawn.
---Epic Reed: (3 randomly selected ranks) each give X3 Mult when scored
---Epic Sand: Create a Quintuple Tag per discard.
---Epic Miser: Gains ^0.2 Mult if the shop is not intereacted with.
---Epic Sink: Gains ^0.1 Mult if discarded hand contains a flush.
---Epic Confrontation: Held face cards give X3 Mult.
---Epic Whole: Scored ranks previously played in last hand permanently gain X0.15 Mult.
---
---Beast Blinds:
---
---Legendary Blinds:
---Legendary Vessel: All Boss Blinds become Legendary Vessel, gains ^Mult (capped at ^0.5) based on (Digits in score) x 0.001
---Legendary Nuke: Gain ^^0.01 Chips if hand does not defeat the boss. Resets if score exceeds ^2 requirements.
---Legendary Magnet: Convert played face cards into Steel Red Seal Steel Kings and these permanently gain ^0.01 Mult (when held).
---Legendary Sword: If played hand contains only 1 card, scored card gives ^1.5 Mult.
---Legendary Tornado: Mark the last 3 cards to be drawn from deck. Scored marked cards give ^1.5 Mult.
--partner ideas:
--Microwave (Lily): Click to destroy up to 1 selected card per ante. --> Click to destroy up to 1 selected card per round.
--Crossdress (UNIK): First scored 7 gives X1.57 Chips --> first scored 7 gives X2.7 Chips
--Pop (Poppy): Retrigger rightmost card at 0 discards --> retrigger rightmost card 2 times at 0 discards
--Stars (Moonlight): 3 in 4 chance to not retrigger levelups once. --> 1 in 2 chance to not retrigger levelups once.
--Cube (Cube Joker): gains 5 chips if hand contains exactly 4 cards --> gains 9 chips if hand contains exactly 4 cards

--TODO:
--Blind fixes:
--Epic Decision (open booster pack when selecting blind, but make it much less janky)
--The Vice/Epic Vice (Dedicated boss blind spawn system)
--