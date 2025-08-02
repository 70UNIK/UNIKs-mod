--Corrupted:
--Misprint all values between -0.8x and 0.8x

SMODS.Shader({
    key = "corrupted",
    path = "corrupted.fs",
})
SMODS.Sound({
	key = "pibby_glitch",
	path = "pibby_glitch.ogg",
})
SMODS.Edition({
	key = "corrupted",
	order = 66666,
	weight = 0, -- should not appear normally in stores as its a detrimental one
	shader = "corrupted", --placeholder for now until I program one. It should have negative shine, but with a polychromesque shine from normal to overlay to a bit of negative, just to show its the opposite
	extra_cost = -5, --Its a detrimental edition, hence lower cost
    apply_to_float = true,
    disable_base_shader = true,
    no_shadow = true,
	detrimental = true,
	sound = {
		sound = "unik_pibby_glitch",
		per = 1,
		vol = 2,
	},
	get_weight = function(self)
		if G.GAME.unik_bad_editions_everywhere then
			return G.GAME.edition_rate * 4
		else
			return 0
		end
	end,
    in_shop = false,
    badge_colour = G.C.UNIK_SHITTY_EDITION,
	on_apply = function(card)
		if not card.ability.unik_corrupted then
			Cryptid.with_deck_effects(card, function(card)
				Cryptid.misprintize(card, {
					min = 0.1,
					max = 0.75,
				}, nil, true)
			end)
			if card.config.center.unik_corrupted then
				card.config.center:apply_corrupted(card, function(val)
					return Cryptid.misprintize_val(val, {
						min =  0.1 * (G.GAME.modifiers.cry_misprint_min or 1),
						max = 0.75 * (G.GAME.modifiers.cry_misprint_max or 1),
					}, Cryptid.is_card_big(card))
				end)
			end
		end
		card.ability.unik_corrupted = true
	end,
	on_remove = function(card)
		Cryptid.with_deck_effects(card, function(card)
			Cryptid.misprintize(card, { min = 1, max = 1 }, true)
			Cryptid.misprintize(card) -- Correct me if i'm wrong but this is for misprint deck. or atleast it is after this patch
		end)
		card.ability.unik_corrupted = nil
	end,
})