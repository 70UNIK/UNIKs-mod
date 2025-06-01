--Omega ruutu
SMODS.Consumable {
    key = "unik_ruutu_omega",
    set = 'jen_omegaconsumable',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0},
    cost = 25,
    no_doe = true,
    aurinko = true,
    unlocked = true,
    discovered = true,
    gloss = true,
    soul_rate = 0,
    atlas = 'unik_omegaplanets',
    hidden = true,
    hidden2 = true,
    can_stack = true,
    can_divide = true,
    can_bulk_use = true,
    can_mass_use = true,
    config = { hand_types = { "High Card", "Pair", "Two Pair" } },
    can_use = function(self, card)
        return jl.canuse()
    end,
    loc_vars = function(self, info_queue, center)
		return {
			vars = {
				localize("High Card", "poker_hands"),
				localize("Pair", "poker_hands"),
				localize("Two Pair", "poker_hands"),
			},
		}
	end,
    use = function(self, card, area, copier)
        for i = 1, #card.ability.hand_types do
            local hand = card.ability.hand_types[i]
            update_operator_display_custom('Per Lv.', G.C.WHITE)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(hand, 'poker_hands'),chips = G.GAME.hands[hand].l_chips, mult = G.GAME.hands[hand].l_mult, level=G.GAME.hands[hand].level})
            G.GAME.hands[hand].l_chips = G.GAME.hands[hand].l_chips * 6
            G.GAME.hands[hand].l_mult = G.GAME.hands[hand].l_mult * 6
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1, func = function()
                play_sound('jen_boost1', 1, 0.4)
                card:juice_up(0.8, 0.5)
            return true end }))
            update_hand_text({delay = 1}, {chips = 'x6', StatusText = true})
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1, func = function()
                play_sound('jen_boost2', 1, 0.4)
                card:juice_up(0.8, 0.5)
            return true end }))
            update_hand_text({delay = 1}, {mult = 'x6', StatusText = true})
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1, delay = 1}, {chips = G.GAME.hands[hand].l_chips, mult = G.GAME.hands[hand].l_mult})
            delay(2)
            update_operator_display()
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 1}, {chips = G.GAME.hands[hand].chips, mult = G.GAME.hands[hand].mult})
            G.GAME.hands[hand].chips = G.GAME.hands[hand].chips * 6
            G.GAME.hands[hand].mult = G.GAME.hands[hand].mult * 6
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1, func = function()
                play_sound('jen_boost3', 1, 0.4)
                card:juice_up(0.8, 0.5)
            return true end }))
            update_hand_text({delay = 1}, {chips = 'x6', StatusText = true})
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1, func = function()
                play_sound('jen_boost4', 1, 0.4)
                card:juice_up(0.8, 0.5)
            return true end }))
            update_hand_text({delay = 1}, {mult = 'x6', StatusText = true})
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1, delay = 1}, {chips = G.GAME.hands[hand].chips, mult = G.GAME.hands[hand].mult})
            level_up_hand(card, hand, false, G.GAME.hands[hand].level)
            jl.ch()
        end   
    end,
    bulk_use = function(self, card, area, copier, number)
        for i = 1, #card.ability.hand_types do
            local hand = card.ability.hand_types[i]
            local factor = to_big(6) ^ number
            update_operator_display_custom('Per Lv.', G.C.WHITE)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(hand, 'poker_hands'),chips = G.GAME.hands[hand].l_chips, mult = G.GAME.hands[hand].l_mult, level=G.GAME.hands[hand].level})
            G.GAME.hands[hand].l_chips = G.GAME.hands[hand].l_chips * factor
            G.GAME.hands[hand].l_mult = G.GAME.hands[hand].l_mult * factor
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1, func = function()
                play_sound('jen_boost1', 1, 0.4)
                card:juice_up(0.8, 0.5)
            return true end }))
            update_hand_text({delay = 0.3}, {chips = 'x' .. number_format(factor), StatusText = true})
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1, func = function()
                play_sound('jen_boost2', 1, 0.4)
                card:juice_up(0.8, 0.5)
            return true end }))
            update_hand_text({delay = 0.3}, {mult = 'x' .. number_format(factor), StatusText = true})
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1, delay = 1}, {chips = G.GAME.hands[hand].l_chips, mult = G.GAME.hands[hand].l_mult})
            delay(2)
            update_operator_display()
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 1}, {chips = G.GAME.hands[hand].chips, mult = G.GAME.hands[hand].mult})
            G.GAME.hands[hand].chips = G.GAME.hands[hand].chips * 6
            G.GAME.hands[hand].mult = G.GAME.hands[hand].mult * 6
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1, func = function()
                play_sound('jen_boost3', 1, 0.4)
                card:juice_up(0.8, 0.5)
            return true end }))
            update_hand_text({delay = 0.3}, {chips = 'x' .. number_format(factor), StatusText = true})
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1, func = function()
                play_sound('jen_boost4', 1, 0.4)
                card:juice_up(0.8, 0.5)
            return true end }))
            update_hand_text({delay = 0.3}, {mult = 'x' .. number_format(factor), StatusText = true})
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1, delay = 1}, {chips = G.GAME.hands[hand].chips, mult = G.GAME.hands[hand].mult})
            level_up_hand(card, hand, false, G.GAME.hands[hand].level * (number <= 1 and number or (2 ^ number)) - (number <= 1 and 0 or G.GAME.hands[hand].level))
            jl.ch()
        end   
    end
}



local omegas_found = 0
--taken from almanac again to have below work
local function play_sound_q(sound, per, vol)
	G.E_MANAGER:add_event(Event({
		func = function()
			play_sound(sound,per,vol)
			return true
		end
	}))
end

--again, taken from jen to make omega chance work outside
local function chance_for_omega(is_soul)
	if is_soul and type(is_soul) == 'string' then
		is_soul = (is_soul or '') == 'soul'
	end
	local chance = (Jen.config.omega_chance * (is_soul and Jen.config.soul_omega_mod or 1)) - 1
	if #SMODS.find_card('j_jen_apollo') > 0 then
		for _, claunecksmentor in ipairs(SMODS.find_card('j_jen_apollo')) do
			if is_soul then
				chance = chance / (((claunecksmentor.ability.omegachance_amplifier < Jen.config.soul_omega_mod and 1 or 0) + claunecksmentor.ability.omegachance_amplifier) / Jen.config.soul_omega_mod)
			else
				chance = chance / claunecksmentor.ability.omegachance_amplifier
			end
		end
	end
	if G.GAME and G.GAME.obsidian then chance = chance / 2 end
	return chance + 1
end

local ccr = create_card
--Omega replacement, copied from jens but designed to work with these omegas via omega_replacement key
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	local card = ccr(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	if G.STAGE ~= G.STAGES.MAIN_MENU and card.gc then
        local omegaReplacement = nil
        if card.config.center.key == 'c_cry_Timantii' then
            omegaReplacement = 'c_unik_ruutu_omega'
        end
		if card and omegaReplacement and jl.chance('omega_replacement', chance_for_omega(v), true) then
            G.E_MANAGER:add_event(Event({trigger = 'after', blockable = false, blocking = false, func = function()
                if card and not card.no_omega then
                    card:set_ability(G.P_CENTERS[omegaReplacement])
                    card:set_cost()
                    if chance_for_omega(v) > 10 then play_sound('jen_omegacard', 1, 0.4) end
                    card:juice_up(1.5, 1.5)
                    if omegas_found <= 0 then
                        Q(function() play_sound_q('jen_chime', 1, 0.65); jl.a('Omega!' .. (omegas_found > 1 and (' x ' .. number_format(omegas_found)) or ''), G.SETTINGS.GAMESPEED, 1, G.C.jen_RGB); jl.rd(1); omegas_found = 0; return true end)
                    end
                    omegas_found = omegas_found + 1
                end
                return true
            end }))
        end
	end
	return card
end