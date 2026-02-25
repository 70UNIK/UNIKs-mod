local mod_path = "" .. SMODS.current_mod.path
unik_config = SMODS.current_mod.config
UNIK = SMODS.current_mod
-- unik_config.unik_overshoot_level = 3
if not UNIK then
	UNIK = {}
end

--function to get no. jokers from other mods, used to modify spawn rate of "rare" rares, such as EARTHMOVER and foundation.

-- Enable optional features
SMODS.current_mod.optional_features = {
	retrigger_joker = true,
	post_trigger = true,
	quantum_enhancements = false,
	-- Here are some other ones Steamodded has
	-- These ones add new card areas that Steamodded will calculate through
	-- Might already be useful for sticker calc

	cardareas = {
		deck = true,
		discard = true, -- used by scorch
		unscored = true,
	},
}

function UNIK.has_almanac()
	
	if next(SMODS.find_mod("Jen")) or next(SMODS.find_mod("jen")) or (SMODS.Mods["jen"] or {}).can_load or (SMODS.Mods["Jen"] or {}).can_load  then
		return true
	end
	if next(SMODS.find_mod("PWX")) or next(SMODS.find_mod("pwx")) or (SMODS.Mods["pwx"] or {}).can_load or (SMODS.Mods["PWX"] or {}).can_load  then
		return true
	end
	return false
end

function UNIK.get_almanac_prefix()
	if next(SMODS.find_mod("Jen")) or next(SMODS.find_mod("jen")) or (SMODS.Mods["jen"] or {}).can_load or (SMODS.Mods["Jen"] or {}).can_load  then
		return 'jen'
	end
	if next(SMODS.find_mod("PWX")) or next(SMODS.find_mod("pwx")) or (SMODS.Mods["pwx"] or {}).can_load or (SMODS.Mods["PWX"] or {}).can_load  then
		return 'pwx'
	end
	return 'jen'
end

function AlterConfigWithAlmanac(config1,config2)
	if UNIK.has_almanac() then
		return config2
	end
	return config1
end

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
			label = localize("unik_indigenous_summit_names_option"),
			ref_table = unik_config,
			ref_value = "unik_indigenous_summit_names",
			info = {
				localize("unik_indigenous_summit_names_desc"),
			},
		}),
		create_toggle({
			label = localize("unik_legendary_blinds_option"),
			ref_table = unik_config,
			ref_value = "unik_legendary_blinds",
			info = AlterConfigWithAlmanac(
				{
					localize("unik_legendary_blinds_desc1"),
					localize("unik_legendary_blinds_desc2")
				},
				{
					localize("unik_legendary_blinds_desc1"),
					localize("unik_legendary_blinds_desc2"),
					localize("unik_legendary_blinds_desc3"),
				}
			)
		}),
		create_toggle({
			label = localize("unik_enable_overshoot_option"),
			ref_table = unik_config,
			ref_value = "unik_overshoot_enabled",
			info = AlterConfigWithAlmanac({
					localize("unik_overshoot_enable_desc"),
				},
				{
					localize("unik_overshoot_enable_desc"),
					localize("unik_overshoot_enable_desc2")
				}
			),
		}),
		create_toggle({
			label = localize("unik_custom_menu_option"),
			ref_table = unik_config,
			ref_value = "unik_custom_menu",
			info = {
				localize("unik_menu_desc"),
			},
		}),
		-- create_option_cycle({
		-- 	label = localize("unik_overshoot_config"),
		-- 	scale = 0.8,
		-- 	w = 9,
		-- 	options = {localize("unik_overshoot_off"), localize("unik_overshoot_lenient"), localize("unik_overshoot_strict")},
		-- 	current_option = unik_config.unik_overshoot_level,
		-- 	opt_callback = 'unik_update_overshoot_opt',
		-- 	info = {
		-- 		localize("unik_overshoot_desc1"),
		-- 		localize("unik_overshoot_desc2"),
		-- 		localize("unik_overshoot_desc3"),
		-- 	},
		-- })
	},
	}
end

--
function UNIK.hasBlindside()
	if next(SMODS.find_mod("Blindside")) then
		if G and G.GAME and G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.config and G.GAME.selected_back.effect.center.config.extra then
			if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
			return true
		end
	end
	return false
end

function UNIK.overshootEnabled(no_comment)
	if not unik_config.unik_overshoot_enabled then
		return false
	end
	--temporary
	if UNIK.hasBlindside() then
		if not no_comment then
			print("All overshoot functionality in Blindside is temporarily disabled until v0.7.")
		end
		
		return false
	end
	return true
end

function UNIK.isIndigenousSummitNaming()
	if unik_config.unik_indigenous_summit_names then
		return true
	end
	return false
end

function UNIK.getSummitAtlas()
	if UNIK.isIndigenousSummitNaming() then
		return 'unik_summits_alt'
	end
	return 'unik_summits'
end

if (SMODS.Mods["Cryptid"] or {}).can_load then
	--print("So, you chose slop... Well be prepared to be treated as slop in return...")
	--UNIK.overshootEnabled() = true
	--unik_config.unik_legendary_blinds = true
end
-- print("OVERSHOOT LEVEL:")
-- print(unik_config.unik_overshoot_level)
NFS.load(mod_path .. "talismanless.lua")()
NFS.load(mod_path .. "data/hooks/startup.lua")()
NFS.load(mod_path .. "data/hooks/addremovecards.lua")()
NFS.load(mod_path .. "data/hooks/hand_size_change.lua")()
NFS.load(mod_path .. "data/hooks/colours.lua")()
NFS.load(mod_path .. "data/hooks/updater.lua")()
NFS.load(mod_path .. "data/hooks/boosterHooks.lua")()
NFS.load(mod_path .. "data/misc/plurals.lua")()


SMODS.Atlas({
	key = "unik_cube_boosters",
	path = "unik_cube_boosters.png",
	px = 71,
	py = 95,
})
--Custom spectrum stuff
function UNIK.can_load_spectrums()
	if (not PB_UTIL or ( PB_UTIL and not PB_UTIL.config.suits_enabled))
	 and not next(SMODS.find_mod("Bunco"))
	  and not next(SMODS.find_mod("SixSuits")) 
	  and not (SMODS.Mods["SpectrumFramework"] or {}).can_load
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

SMODS.Atlas {
	key = "unik_blindside_jokers",
	path = "unik_blindside_jokers.png",
	atlas_table = "ANIMATION_ATLAS", 
    px = 34,
    py = 34,
	frames = 21
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
SMODS.Sound({
	key = "woodBreak",
	path = "woodBreak.ogg",
})
SMODS.Sound({
	key = "metalbreak",
	path = "metalbreak.ogg",
})
SMODS.Sound({
	key = "rock_break",
	path = "rock_break.ogg",
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

SMODS.Atlas {
	key = "unik_blindside_blinds",
	path = "unik_blindside_blinds.png",
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
SMODS.Atlas {
	key = "unik_summits",
	path = "unik_summits.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "unik_summits_alt",
	path = "unik_summits_alt.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "unik_seals",
	path = "unik_seals.png",
	px = 71,
	py = 95
}

SMODS.ConsumableType {
	key = "unik_summit",
	prefix_config = { key = true },
	primary_colour = HEX("000000"),
	secondary_colour = HEX("000000"),
	shop_rate = 0.0,
	loc_txt = {},
	default = "c_unik_elbert", 
}

SMODS.UndiscoveredSprite({
	key = "unik_summit",
	atlas = "unik_summits",
	path = "unik_summits.png",
	pos = { x = 2, y = 2 },
	px = 71,
	py = 95,
})

SMODS.UndiscoveredSprite({
	key = "unik_lartceps",
	atlas = "unik_lartceps",
	path = "unik_lartceps.png",
	pos = { x = 0, y = 2 },
	px = 71,
	py = 95,
})

--fonts
SMODS.Font {
    key = 'unik_five_by_five',
    path = 'five_by_five.ttf',
	render_scale = 256,
	TEXT_HEIGHT_SCALE = 0.7,
	TEXT_OFFSET = { x = 0, y = -50 },
	FONTSCALE = 0.11,
	squish = 0.9,
	DESCSCALE = 1
}


--RARITIES--
--Discount exotic
SMODS.Rarity({
	key = "unik_ancient",
	loc_txt = {},
	badge_colour = G.C.UNIK_ANCIENT,
	fallback_joker = 'j_ancient'
})
if (SMODS.Mods["Cryptid"] or {}).can_load then
    Cryptid.pointerblistifytype("rarity", "unik_ancient")
end

--Discount Cursed
SMODS.Rarity({
	key = "unik_detrimental",
	loc_txt = {},
	badge_colour = HEX("474931"),
	fallback_joker = 'j_unik_impounded'
})
NFS.load(mod_path .. "data/overrides/rarity_ownership.lua")() 

UNIK.detrimental_rarities = {
	unik_detrimental = true,
	cry_cursed = true,
	jen_junk = true,
	valk_supercursed = true,
}

-- stickers
NFS.load(mod_path .. "data/stickers/shielded.lua")() 
NFS.load(mod_path .. "data/stickers/limited_edition.lua")() 
NFS.load(mod_path .. "data/stickers/triggering.lua")() 
NFS.load(mod_path .. "data/stickers/depleted.lua")() 
NFS.load(mod_path .. "data/stickers/impounded.lua")() 
NFS.load(mod_path .. "data/stickers/disposable.lua")() 
NFS.load(mod_path .. "data/stickers/niko.lua")() 
NFS.load(mod_path .. "data/stickers/decaying.lua")() 
NFS.load(mod_path .. "data/stickers/ultradebuffed.lua")()
NFS.load(mod_path .. "data/stickers/taw.lua")()   
NFS.load(mod_path .. "data/stickers/claw_mark.lua")() 
NFS.load(mod_path .. "data/stickers/lily_mark.lua")() 
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
NFS.load(mod_path .. "data/decks/greed_deck.lua")()
NFS.load(mod_path .. "data/decks/mountain_deck.lua")()
NFS.load(mod_path .. "data/decks/tic_tac_toe_deck.lua")()
NFS.load(mod_path .. "data/decks/endless_deck.lua")()
NFS.load(mod_path .. "data/decks/polychrome_deck.lua")()
NFS.load(mod_path .. "data/decks/steel_deck.lua")()
NFS.load(mod_path .. "data/decks/shining_glitter_deck.lua")()

--Enhancements
NFS.load(mod_path .. "data/enhancements/pink_card.lua")()
NFS.load(mod_path .. "data/enhancements/dollar_card.lua")()	
NFS.load(mod_path .. "data/enhancements/timber_card.lua")()	
if MoreFluff then
	NFS.load(mod_path .. "data/enhancements/green_card.lua")()
	NFS.load(mod_path .. "data/enhancements/bill_card.lua")()
end
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

NFS.load(mod_path .. "data/misc/rescoring_api.lua")()
--seals
NFS.load(mod_path .. "data/seals/copper_seal.lua")()

--Load suit types

UNIK.light_suits = { 'Diamonds', 'Hearts','unik_Noughts' }
UNIK.dark_suits = { 'Spades', 'Clubs','unik_Crosses' }
SMODS.Atlas({
	key = "unik_suits",
	path = "unik_suits.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	key = "unik_suits_hc",
	path = "unik_suits_hc.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	key = "unik_ranks",
	path = "unik_ranks.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	key = "unik_ranks_hc",
	path = "unik_ranks_hc.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	key = "unik_suits_ui",
	path = "unik_suits_ui.png",
	px = 18,
	py = 18,
})
SMODS.Atlas({
	key = "unik_suits_ui_hc",
	path = "unik_suits_ui_hc.png",
	px = 18,
	py = 18,
})
SMODS.Atlas({
	key = "unik_nils",
	path = "unik_nils.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	key = "unik_nils_hc",
	path = "unik_nils_hc.png",
	px = 71,
	py = 95,
})
NFS.load(mod_path .. "data/suit_shennannigans/noughts.lua")()
NFS.load(mod_path .. "data/suit_shennannigans/crosses.lua")()
NFS.load(mod_path .. "data/suit_shennannigans/enhancement_rank_suit.lua")()
NFS.load(mod_path .. "data/suit_shennannigans/light_dark_suits.lua")()
NFS.load(mod_path .. "data/suit_shennannigans/crossmod_ranks.lua")()
if (SMODS.Mods["Cryptid"] or {}).can_load  then
	NFS.load(mod_path .. "data/overrides/abstract_fix.lua")()
end


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

NFS.load(mod_path .. "data/poker_hands/spectrum_calc.lua")()

UNIK.spectrum_name = 'unik_spectrum'
if SpectrumAPI then
	UNIK.spectrum_name = 'spa_Spectrum'
end
if UNIK.can_load_spectrums() then
	if not SpectrumAPI then
		NFS.load(mod_path .. "data/poker_hands/spectrum.lua")()
		NFS.load(mod_path .. "data/poker_hands/straight_spectrum.lua")()
		NFS.load(mod_path .. "data/poker_hands/spectrum_house.lua")()
		NFS.load(mod_path .. "data/poker_hands/spectrum_five.lua")()
	end

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
NFS.load(mod_path .. "data/poker_hands/light_dark_spectrum.lua")()
------------------------
---CONSUMABLES
--------------------------
---
---TAROTS
NFS.load(mod_path .. "data/tarots/crossdresser.lua")()
NFS.load(mod_path .. "data/tarots/oligarch.lua")()
NFS.load(mod_path .. "data/tarots/carpenter.lua")()
NFS.load(mod_path .. "data/tarots/wheel_of_misfortune.lua")()
--Bunco polymino tarots
if next(SMODS.find_mod("Bunco")) then
	NFS.load(mod_path .. "data/tarots/the_chains.lua")()
	NFS.load(mod_path .. "data/tarots/the_divorce.lua")()
	NFS.load(mod_path .. "data/tarots/the_excommunicated.lua")()
end

SMODS.Atlas {
	key = "unik_polyminos",
	path = "unik_polyminos.png",
	px = 71,
	py = 95
}

--Polyminos
if next(SMODS.find_mod("Bunco")) then
	NFS.load(mod_path .. "data/polyminos/the_double.lua")()
	NFS.load(mod_path .. "data/polyminos/the_triple.lua")()
	NFS.load(mod_path .. "data/polyminos/the_quadruple.lua")()
end

---SPECTRALS
NFS.load(mod_path .. "data/spectrals/foundry.lua")() 
NFS.load(mod_path .. "data/spectrals/sparkle.lua")() 
NFS.load(mod_path .. "data/spectrals/prism.lua")() 
NFS.load(mod_path .. "data/spectrals/bloater.lua")() 
NFS.load(mod_path .. "data/spectrals/turing.lua")() 
NFS.load(mod_path .. "data/spectrals/defend.lua")() 
--NFS.load(mod_path .. "data/spectrals/forever.lua")() 
NFS.load(mod_path .. "data/spectrals/purify.lua")() 
NFS.load(mod_path .. "data/spectrals/expel.lua")() 
NFS.load(mod_path .. "data/spectrals/ring.lua")() 
NFS.load(mod_path .. "data/spectrals/denial.lua")() 
--
--hidden summits
NFS.load(mod_path .. "data/summits/ebott.lua")() 
NFS.load(mod_path .. "data/summits/celeste.lua")() 

NFS.load(mod_path .. "data/spectrals/unik_gateway.lua")() --rework: destroy 2 leftmost non eternals, create an ancient.

--PLANETS
--NFS.load(mod_path .. "data/overrides/eternal_playing_card.lua")()

--SUMMITS--
NFS.load(mod_path .. "data/summits/bonus_exponentials.lua")() 
NFS.load(mod_path .. "data/summits/bonus_indicator.lua")() 
NFS.load(mod_path .. "data/summits/elbert.lua")() 
NFS.load(mod_path .. "data/summits/kosciuszko.lua")() 
NFS.load(mod_path .. "data/summits/narodnaya.lua")() 
NFS.load(mod_path .. "data/summits/mitchell.lua")() 
NFS.load(mod_path .. "data/summits/charleston.lua")() 
NFS.load(mod_path .. "data/summits/whitney.lua")() 
NFS.load(mod_path .. "data/summits/aconcagua.lua")() 
NFS.load(mod_path .. "data/summits/elbrus.lua")() 
NFS.load(mod_path .. "data/summits/everest.lua")() 
NFS.load(mod_path .. "data/summits/denali.lua")() 


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
	NFS.load(mod_path .. "data/lartceps/doom.lua")() 
	if next(SMODS.find_mod("Bunco")) then
		NFS.load(mod_path .. "data/lartceps/parasite.lua")()
	end
	NFS.load(mod_path .. "data/lartceps/blank_lartceps.lua")() 
end

--Vouchers
NFS.load(mod_path .. "data/vouchers/spectral_merchant.lua")() 
NFS.load(mod_path .. "data/vouchers/spectral_tycoon.lua")() 
-- NFS.load(mod_path .. "data/vouchers/summit_merchant.lua")() //turns out this becomes broken. likely have them only spawn in a dedicated deck.
-- NFS.load(mod_path .. "data/vouchers/summit_tycoon.lua")() 
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
	--NFS.load(mod_path .. "data/colours/stone_grey.lua")()
	NFS.load(mod_path .. "data/colours/verdant_green.lua")()
end


--boosters
--TODO: Replace "cube pack" with "UNIK's pack" in the next update, basically an icon pack of sorts
NFS.load(mod_path .. "data/boosters/summit_pack.lua")()
NFS.load(mod_path .. "data/boosters/character_pack.lua")()
-- NFS.load(mod_path .. "data/boosters/cube_pack.lua")()
NFS.load(mod_path .. "data/boosters/lartceps_bundle.lua")()
NFS.load(mod_path .. "data/boosters/egg_pack.lua")()

--tags


NFS.load(mod_path .. "data/tags/shining_glitter_tag.lua")()
NFS.load(mod_path .. "data/tags/steel_tag.lua")()
NFS.load(mod_path .. "data/tags/mountain.lua")()
NFS.load(mod_path .. "data/tags/demon_tag.lua")()
NFS.load(mod_path .. "data/boosters/devil_pack.lua")()
NFS.load(mod_path .. "data/tags/vessel_tag.lua")()
NFS.load(mod_path .. "data/tags/handcuffs_tag.lua")()
NFS.load(mod_path .. "data/tags/positive.lua")()
NFS.load(mod_path .. "data/tags/bloated.lua")()
NFS.load(mod_path .. "data/tags/half.lua")()
NFS.load(mod_path .. "data/tags/fuzzy.lua")()
NFS.load(mod_path .. "data/tags/corrupted.lua")()
NFS.load(mod_path .. "data/tags/disposable.lua")()
NFS.load(mod_path .. "data/tags/triggering.lua")()
NFS.load(mod_path .. "data/tags/limited_edition.lua")()
--manacle tag: -1 hand size

--BLINDS--
NFS.load(mod_path .. "data/bossBlinds/vice_check.lua")()
NFS.load(mod_path .. "data/hooks/blindHooks.lua")() 
NFS.load(mod_path .. "data/bossBlinds/bigger_blind.lua")()
NFS.load(mod_path .. "data/bossBlinds/poppy.lua")() 
NFS.load(mod_path .. "data/misc/death_quote_functions.lua")()

NFS.load(mod_path .. "data/bossBlinds/collapse.lua")()
NFS.load(mod_path .. "data/bossBlinds/the_approval.lua")() 
NFS.load(mod_path .. "data/bossBlinds/the_fill.lua")() 
NFS.load(mod_path .. "data/bossBlinds/vice.lua")()
NFS.load(mod_path .. "data/bossBlinds/sync_catalyst_fail.lua")()
NFS.load(mod_path .. "data/bossBlinds/artisan_builds.lua")()
NFS.load(mod_path .. "data/bossBlinds/cookie.lua")()
NFS.load(mod_path .. "data/bossBlinds/xchips_hater.lua")()
NFS.load(mod_path .. "data/bossBlinds/magician.lua")()
NFS.load(mod_path .. "data/bossBlinds/gun.lua")()
NFS.load(mod_path .. "data/bossBlinds/smile.lua")()
NFS.load(mod_path .. "data/bossBlinds/bloon.lua")()
NFS.load(mod_path .. "data/bossBlinds/halved.lua")()
NFS.load(mod_path .. "data/bossBlinds/fuzzy.lua")()
NFS.load(mod_path .. "data/bossBlinds/darkness.lua")() --Unless i rework edition effect, crossmod?
NFS.load(mod_path .. "data/bossBlinds/ravine.lua")()
NFS.load(mod_path .. "data/bossBlinds/crater.lua")()
NFS.load(mod_path .. "data/bossBlinds/abyss.lua")()
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
NFS.load(mod_path .. "data/bossBlinds/viridian_valve.lua")()
NFS.load(mod_path .. "data/bossBlinds/bronze_bug.lua")()
NFS.load(mod_path .. "data/bossBlinds/red_runner.lua")()
NFS.load(mod_path .. "data/bossBlinds/jaundice_jack.lua")()
NFS.load(mod_path .. "data/bossBlinds/septic_seance.lua")()
NFS.load(mod_path .. "data/bossBlinds/eternal_egg.lua")()
NFS.load(mod_path .. "data/bossBlinds/hate_ball.lua")()
NFS.load(mod_path .. "data/bossBlinds/foul_flowerpot.lua")()
NFS.load(mod_path .. "data/bossBlinds/shitty_superposition.lua")()
NFS.load(mod_path .. "data/bossBlinds/salmon_steps.lua")()
NFS.load(mod_path .. "data/bossBlinds/burgundy_brain.lua")()
NFS.load(mod_path .. "data/bossBlinds/emerald_escalator.lua")()
NFS.load(mod_path .. "data/bossBlinds/green_goalpost.lua")()
NFS.load(mod_path .. "data/bossBlinds/video_poker.lua")()

--blind editions
if (SMODS.Mods['ble'] or {}).can_load or SMODS.BlindEdition then
	NFS.load(mod_path .. "data/blindeditions/steel.lua")()
	NFS.load(mod_path .. "data/blindeditions/bloated.lua")()
	NFS.load(mod_path .. "data/blindeditions/half.lua")()
	NFS.load(mod_path .. "data/blindeditions/positive.lua")()
	NFS.load(mod_path .. "data/blindeditions/shining_glitter.lua")()
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
	NFS.load(mod_path .. "data/bossBlinds/epic_claw.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_reed.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_bellows.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_confrontation.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_height.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_entanglement.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_straightforwardness.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_whole.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_toxin.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_bird.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_neck.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_steed.lua")()
	NFS.load(mod_path .. "data/bossBlinds/epic_xenomorph_queen.lua")()
	--Blinds below require talisman due to exponential requirements
	if UNIK.has_talisman() then
		NFS.load(mod_path .. "data/bossBlinds/legendary_vessel.lua")() --panopicon. thats it
	end
	NFS.load(mod_path .. "data/bossBlinds/legendary_magnet.lua")()
	NFS.load(mod_path .. "data/bossBlinds/legendary_nuke.lua")()
	if UNIK.has_talisman() then
		NFS.load(mod_path .. "data/bossBlinds/legendary_sword.lua")() --good high card score thats it.
	end
	NFS.load(mod_path .. "data/bossBlinds/legendary_tornado.lua")()
	if UNIK.has_talisman() then
		NFS.load(mod_path .. "data/bossBlinds/legendary_chamber.lua")() --dont have too much rarities, have good amount of hands, blueprint(s) 
	end
	NFS.load(mod_path .. "data/bossBlinds/legendary_crown.lua")() --same as above, but dont have too much hands, maybe have higher ranked cards or planets on hand
end

----------------------------------------
---JONKLERS
----------------------------------------
NFS.load(mod_path .. "data/misc/character_pool.lua")()
--Common
NFS.load(mod_path .. "data/jokers/unik/common/lucky_seven.lua")()
NFS.load(mod_path .. "data/jokers/unik/common/gt710.lua")()
NFS.load(mod_path .. "data/jokers/unik/common/golden_glove.lua")()
NFS.load(mod_path .. "data/jokers/unik/common/instant_gratification.lua")()
NFS.load(mod_path .. "data/jokers/unik/common/1_5_joker.lua")() 
NFS.load(mod_path .. "data/jokers/unik/common/landfill.lua")() 
NFS.load(mod_path .. "data/jokers/unik/common/noon.lua")()
-- NFS.load(mod_path .. "data/jokers/unik/common/shitty_joker.lua")()
NFS.load(mod_path .. "data/jokers/unik/common/skipping_stones.lua")()
NFS.load(mod_path .. "data/jokers/unik/common/yes_nothing.lua")()
NFS.load(mod_path .. "data/jokers/unik/common/welfare_payment.lua")()
NFS.load(mod_path .. "data/jokers/unik/common/tape_seven.lua")()

NFS.load(mod_path .. "data/jokers/unik/common/up_n_go.lua")()
NFS.load(mod_path .. "data/jokers/unik/common/violent_joker.lua")()
NFS.load(mod_path .. "data/jokers/unik/common/traitorous_joker.lua")()

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
NFS.load(mod_path .. "data/jokers/unik/uncommon/stamp_spam.lua")()
-- NFS.load(mod_path .. "data/jokers/unik/uncommon/perk_lottery.lua")() 
NFS.load(mod_path .. "data/jokers/unik/uncommon/malicious_face.lua")()
NFS.load(mod_path .. "data/jokers/unik/uncommon/antivirus.lua")() 
NFS.load(mod_path .. "data/jokers/unik/uncommon/energy_compressor.lua")() 
NFS.load(mod_path .. "data/jokers/unik/uncommon/better_riffin.lua")()
NFS.load(mod_path .. "data/jokers/unik/uncommon/base_camp.lua")()  
NFS.load(mod_path .. "data/jokers/unik/uncommon/twin_peaks.lua")()
NFS.load(mod_path .. "data/jokers/unik/uncommon/road_sign.lua")()
NFS.load(mod_path .. "data/jokers/unik/uncommon/multesers.lua")()
NFS.load(mod_path .. "data/jokers/unik/uncommon/brownie.lua")()
NFS.load(mod_path .. "data/jokers/unik/uncommon/mountain_dew.lua")() 
NFS.load(mod_path .. "data/jokers/unik/uncommon/preservatives.lua")()  
NFS.load(mod_path .. "data/jokers/unik/uncommon/pink salt.lua")()
NFS.load(mod_path .. "data/jokers/unik/uncommon/aquamarine.lua")()
NFS.load(mod_path .. "data/jokers/unik/uncommon/pink_guard.lua")()


--Rare
--: create a summit card if hand contains a five of a kind
NFS.load(mod_path .. "data/jokers/unik/rare/railroad_crossing.lua")()
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
NFS.load(mod_path .. "data/jokers/unik/rare/compounding_interest.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/lone_despot.lua")() 
NFS.load(mod_path .. "data/jokers/unik/rare/beaver.lua")() 
NFS.load(mod_path .. "data/jokers/unik/rare/tic_tac.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/double_up.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/coupon_codes.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/antijoker.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/hall_of_mirrors.lua")()
--NFS.load(mod_path .. "data/jokers/unik/rare/electroplating.lua")() --NOT released until v0.8, will only be here for the purpose of testing perma rescoring

if (not PB_UTIL or ( PB_UTIL and not PB_UTIL.config.suits_enabled)) and not next(SMODS.find_mod("Bunco")) then
	NFS.load(mod_path .. "data/jokers/unik/poker_hands/the_dynasty.lua")()
end
NFS.load(mod_path .. "data/jokers/unik/legendary/megatron.lua")() 
NFS.load(mod_path .. "data/jokers/unik/legendary/ALICE.lua")()
--Rare (characters)
NFS.load(mod_path .. "data/jokers/unik/rare/catto_boi.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/reggie.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/poppy.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/kouign_amann_cookie.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/pibby.lua")() 
NFS.load(mod_path .. "data/jokers/unik/rare/lily_sprunki.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/blossom.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/chelsea_ramirez.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/maya_ramirez.lua")()
NFS.load(mod_path .. "data/jokers/unik/rare/yokana_ramirez.lua")() 
--BUN BUN (note add bunny = true for bunny mod crossmod; he is a bunny after all)

--Ancient
NFS.load(mod_path .. "data/jokers/unik/ancient/niko.lua")()
NFS.load(mod_path .. "data/jokers/unik/ancient/sundae_cookie.lua")()
NFS.load(mod_path .. "data/jokers/unik/ancient/white_lily_cookie.lua")()
NFS.load(mod_path .. "data/jokers/unik/ancient/moonlight_cookie.lua")()
NFS.load(mod_path .. "data/jokers/unik/ancient/unik.lua")() 


---------------
---CROSSMOD (non cursed) JONKLERS
---------------
if next(SMODS.find_mod("Bunco")) then
	-- NFS.load(mod_path .. "data/jokers/bunco/neon_rainbows.lua")()
	-- NFS.load(mod_path .. "data/jokers/bunco/king_minos.lua")()
end
if (SMODS.Mods["paperback"] or {}).can_load then
	NFS.load(mod_path .. "data/jokers/paperback/binary_asteroid.lua")()
	NFS.load(mod_path .. "data/jokers/paperback/crosses/nem_nuong.lua")() 
	NFS.load(mod_path .. "data/jokers/paperback/crosses/meaty_stick.lua")() 
	NFS.load(mod_path .. "data/jokers/paperback/noughts/bo_la_lot.lua")() 
	NFS.load(mod_path .. "data/jokers/paperback/noughts/charred_stick.lua")() 
	NFS.load(mod_path .. "data/jokers/paperback/crosses/flowerbeds.lua")() 
	NFS.load(mod_path .. "data/jokers/paperback/noughts/greenfield.lua")() 
	NFS.load(mod_path .. "data/jokers/paperback/weetomancer.lua")() 
	
end
if (SMODS.Mods["Cryptid"] or {}).can_load  then
	NFS.load(mod_path .. "data/jokers/cryptid/scratch.lua")()
	NFS.load(mod_path .. "data/jokers/cryptid/hacker.lua")()
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
	if next(SMODS.find_mod("finity")) then
		local bossblinds = {
			["bl_unik_fuck_eternal_egg"] = {"j_unik_eternal_egg","Eternal Egg"},
		}
		for k, v in pairs(bossblinds) do
			FinisherBossBlindStringMap[k] = v
		end
	end
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

	NFS.load(mod_path .. "data/jokers/finity/eternal_egg.lua")() 
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
NFS.load(mod_path .. "data/overrides/autocannibal_jokers.lua")() 
NFS.load(mod_path .. "data/overrides/crossmod.lua")() 
NFS.load(mod_path .. "data/overrides/last_hand.lua")() 
if next(SMODS.find_mod("Bunco")) then
	NFS.load(mod_path .. "data/overrides/copper_fix.lua")()
	NFS.load(mod_path .. "data/overrides/polyminos_rework.lua")() 
end


--Challenges gone until I fix them to work with new API 
NFS.load(mod_path .. "data/challenges/common_muck.lua")()
 NFS.load(mod_path .. "data/challenges/singleton.lua")()
  NFS.load(mod_path .. "data/challenges/the_rot.lua")()
  NFS.load(mod_path .. "data/challenges/centrelink.lua")()
  NFS.load(mod_path .. "data/challenges/catto_boi_adventures.lua")()
--  NFS.load(mod_path .. "data/challenges/rich_get_richer_2.lua")()
NFS.load(mod_path .. "data/challenges/video_poker_1.lua")()
NFS.load(mod_path .. "data/challenges/video_poker_2.lua")()
NFS.load(mod_path .. "data/challenges/finger_trigger_1.lua")()
if next(SMODS.find_mod("Bunco")) then
	NFS.load(mod_path .. "data/challenges/finger_trigger_2.lua")()
end
if unik_config.unik_legendary_blinds then
	NFS.load(mod_path .. "data/challenges/cookie_clicker.lua")()
	NFS.load(mod_path .. "data/challenges/cookie_clicker_2.lua")()
end
-- NFS.load(mod_path .. "data/challenges/rng_2.lua")()

-- achievements
-- NFS.load(mod_path .. "data/achievements/epic_fail.lua")()
-- NFS.load(mod_path .. "data/achievements/stupid_summoning.lua")()
NFS.load(mod_path .. "data/achievements/bloodbath.lua")()
-- NFS.load(mod_path .. "data/achievements/moonlight_deathstar.lua")()
if unik_config.unik_legendary_blinds then
	NFS.load(mod_path .. "data/achievements/abyss.lua")()
end

NFS.load(mod_path .. "data/overrides/blind_spawn.lua")()


-- joker buffs
NFS.load(mod_path .. "data/overrides/wild_buff.lua")()	
NFS.load(mod_path .. "data/overrides/drunkard_merry_andy_buff.lua")()	
NFS.load(mod_path .. "data/overrides/mr_bones_ui.lua")()	
NFS.load(mod_path .. "data/overrides/matador.lua")()	
NFS.load(mod_path .. "data/overrides/black_hole_observatory.lua")()	

NFS.load(mod_path .. "data/overrides/enhancement_destroy_fx.lua")()	
NFS.load(mod_path .. "data/overrides/values_changes.lua")()	


--UI
NFS.load(mod_path .. "data/ui/overshoot.lua")()
NFS.load(mod_path .. "data/ui/overshoot_part2.lua")()
NFS.load(mod_path .. "data/ui/banished_items.lua")()
NFS.load(mod_path .. "data/ui/blind_exponent.lua")()
if AKYRS then
	NFS.load(mod_path .. "data/ui/aiko_icons.lua")()
end
if unik_config.unik_custom_menu then
	NFS.load(mod_path .. "data/menu.lua")()
end

--blindside:
if next(SMODS.find_mod("Blindside")) then
	NFS.load(mod_path .. "data/blindside/jokers/ancient/ancient_exotic_spawn.lua")()
	
	--BLINDS
	NFS.load(mod_path .. "data/blindside/blinds/halved.lua")()	
	NFS.load(mod_path .. "data/blindside/blinds/prince.lua")()	
	NFS.load(mod_path .. "data/blindside/blinds/blossom.lua")()	
	NFS.load(mod_path .. "data/blindside/blinds/catterfly.lua")()	
	NFS.load(mod_path .. "data/blindside/blinds/descending.lua")()	
	--JOKERS
	NFS.load(mod_path .. "data/blindside/jokers/boss/lily.lua")()	
	NFS.load(mod_path .. "data/blindside/jokers/boss/railroad_crossing.lua")()	
	NFS.load(mod_path .. "data/blindside/jokers/boss/recycle_bin.lua")()	
	NFS.load(mod_path .. "data/blindside/jokers/ancient/unik.lua")()	

	--TAGS
	NFS.load(mod_path .. "data/blindside/tags/dethroning.lua")()	
end


NFS.load(mod_path .. "data/stickers/mad.lua")() 

if Entropy then
	NFS.load(mod_path .. "data/overrides/entropy_recipes.lua")() 
	
end
if JokerDisplay then
	NFS.load(mod_path .. "data/jokerdisplay/rescoring_calc.lua")() 
	NFS.load(mod_path .. "data/jokerdisplay/rescoring_jokers.lua")() 
	NFS.load(mod_path .. "data/jokerdisplay/ancient.lua")() 
	NFS.load(mod_path .. "data/jokerdisplay/legendary.lua")() 
	NFS.load(mod_path .. "data/jokerdisplay/common.lua")() 
	NFS.load(mod_path .. "data/jokerdisplay/uncommon.lua")() 
	NFS.load(mod_path .. "data/jokerdisplay/rare.lua")() 
	NFS.load(mod_path .. "data/jokerdisplay/editions.lua")() 
	NFS.load(mod_path .. "data/jokerdisplay/detrimental.lua")() 
end


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


--April fools events:
-- Every ancient Joker is resdesigned to look like Ancient Joker or
-- Only Ancient Jokers can spawn from awakening (randomizes per run)
-- Not winning small blind on the first hand in round 1 will instantly kill you on the spot (with a special message)
-- all eternal stickers are replaced with TAW and lockpick is automatically banished in the run.
-- playing a 7 and a 10 together has a 1 in 700 chance to spawn UNIK
-- playing a 6 and a 9 together brings up the url to my furaffinity profile
-- playing a 4 and a 2 together levels up hand
--playing a 6 and a 7 together instatly kills you
-- "Ancient Ancient Ancient Joker" can spawn in the ancient joker pool (create 5 disposable negative ancient jokers on cashout)
---April fools can be toggled between: off, on and always active (not recommended)
