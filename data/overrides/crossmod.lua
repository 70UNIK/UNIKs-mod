--register hypercom
SMODS.Joker:take_ownership("j_mf_unregisteredhypercam",{
    rarity = 2
}, true)
--apostle of wands: blacklist epic, exotics,legendary blinds,

SMODS.Consumable:take_ownership("c_paperback_apostle_of_wands",{
    use = function(self, card, area, copier)
    PB_UTIL.use_consumable_animation(card, nil, function()
		if #G.jokers.cards < G.jokers.config.card_limit then
			G.SETTINGS.paused = true

			local selectable_jokers = {}

			for _, v in ipairs(G.P_CENTER_POOLS.Joker) do
			-- Only shows discovered non-legendary and non-owned jokers
			if v.discovered and v.rarity ~= 4 and v.rarity ~= 'unik_ancient' and v.rarity ~= 'cry_epic' and v.rarity ~= 'cry_exotic' and v.rarity ~="unik_legendary_blind_finity" and (not (SMODS.Mods["Cryptid"] or {}).can_load or ((SMODS.Mods["Cryptid"] or {}).can_load and not Cryptid.pin_debuff[v.rarity])) and not next(SMODS.find_card(v.key)) then
				selectable_jokers[#selectable_jokers + 1] = v
			end
			end

			-- If the list of jokers is empty, we want at least one option so the user can leave the menu
			if #selectable_jokers <= 0 then
			selectable_jokers[#selectable_jokers + 1] = G.P_CENTERS.j_joker
			end

			G.FUNCS.overlay_menu {
			config = { no_esc = true },
			definition = PB_UTIL.apostle_of_wands_collection_UIBox(
				selectable_jokers,
				{ 5, 5, 5 },
				{
				no_materialize = true,
				modify_card = function(other_card, center)
					other_card.sticker = get_joker_win_sticker(center)
					PB_UTIL.create_select_card_ui(other_card, G.jokers)
				end,
				h_mod = 1.05,
				}
			),
			}
		end
		end)
	end
}, true)

--Rift, Wheel of Fortune!: Blacklist detrimental editions.
if Entropy then
	SMODS.Consumable:take_ownership("c_entr_rift",{
	use = function(self, card2)
        local cards = Entropy.GetHighlightedCards({G.jokers, G.consumeables, G.hand}, card2, 1, card2.ability.num)
        Entropy.FlipThen(cards, function(card)
            card:juice_up()
            card:set_edition(Entropy.pseudorandom_element(G.P_CENTER_POOLS.Edition, pseudoseed("rift"),function(e)
                return G.GAME.banned_keys[e.key] or e.no_doe or e.detrimental
            end).key)
        end)
    end,
}, true)
end

SMODS.Edition:take_ownership("e_gb_temporary",{
	detrimental = true,
}, true)
SMODS.Edition:take_ownership("e_Bakery_Carbon",{
	detrimental = true,
}, true)

local blacklisted_editions = {
    "e_base", -- oops
    "e_jen_bloodfoil", "e_jen_blood", "e_jen_moire", -- "e_jen_unreal"
	"e_unik_bloated","e_unik_positive","e_unik_fuzzy","e_unik_halfjoker","e_unik_corrupted",
	"e_gb_temporary","e_Bakery_Carbon",
  }

SMODS.Consumable:take_ownership("c_mf_rot_wheel",{
	use = function(self, card, area, copier)
		local used_tarot = copier or card
		if pseudorandom("evil_wheel") < G.GAME.probabilities.normal/card.ability.chance then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			local over = false
			local eligible_card = pseudorandom_element(card.eligible_strength_jokers, pseudoseed("evil_wheel_roll"))
			local edition_pool = {}
			for _, ed in pairs(G.P_CENTER_POOLS["Edition"]) do
				for _, bl_ed in pairs(blacklisted_editions) do
				if ed.key == bl_ed then
					goto wof_continue
				end
				end
				edition_pool[#edition_pool + 1] = ed.key
				::wof_continue::
			end
			local edition = pseudorandom_element(edition_pool, pseudoseed("evil_wheel_roll"))
			eligible_card:set_edition(edition, true)
			check_for_unlock({type = 'have_edition'})
			used_tarot:juice_up(0.3, 0.5)
			return true end }))
		else
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			attention_text({
				text = localize('k_nope_ex'),
				scale = 1.3, 
				hold = 1.4,
				major = used_tarot,
				backdrop_colour = G.C.SECONDARY_SET.Tarot,
				align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
				offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
				silent = true
				})
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
				play_sound('tarot2', 0.76, 0.4);return true end}))
				play_sound('tarot2', 1, 0.4)
				used_tarot:juice_up(0.3, 0.5)
			return true end }))
		end
	end,
	loc_vars = function(self, info_queue, card)
		for _, thing in pairs(G.P_CENTER_POOLS["Edition"]) do
			for _, bl_ed in pairs(blacklisted_editions) do
			if thing.key == bl_ed then
				goto wof_loc_continue
			end
			end
			info_queue[#info_queue + 1] = thing
			::wof_loc_continue::
		end
		return { vars = {
			G.GAME.probabilities.normal,
			card.ability.chance
		} }
	end
}, true)

--Deadringer: Fix for pink cards
SMODS.Joker:take_ownership("j_paperback_deadringer",{
    config = {
		extra = {
			ace_seven = 1, nines = 2,
		}
	},
	loc_vars = function(self, info_queue, card)
    return {
			vars = {
				localize("Ace", 'ranks'),
				localize("7", 'ranks'),
				localize("9", 'ranks'),
				card.ability.extra.ace_seven,
				card.ability.extra.nines,
			}
		}
	end,
	calculate = function(self, card, context)
        
        if context.repetition and context.cardarea == G.play then
            if context.other_card:get_id() == 7 or context.other_card:get_id() == 14 then
                return {
					message = localize("k_again_ex"),
					repetitions = to_number(
						card.ability.extra.ace_seven
					),
					card = card,
				}
            elseif context.other_card:get_id() == 9 then
				return {
					message = localize("k_again_ex"),
					repetitions = to_number(
						card.ability.extra.nines
					),
					card = card,
				}
			end
		end
    end,
}, true)

if next(SMODS.find_mod("Bunco")) then
	SMODS.Stake:take_ownership('bunc_magenta', {
		unlocked_stake = 'unik_persimmon',
	})
end
