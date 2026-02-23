--register hypercom
SMODS.Joker:take_ownership("j_mf_unregisteredhypercam",{
    rarity = 2
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

--crop circles, base nought suits give +1 mult
SMODS.Joker:take_ownership("j_bunc_crop_circles",{
	config = {extra = {fleuron_mult = 4, club_mult = 3, eight_mult = 2, nought = 1}},
	loc_vars = function(self, info_queue, card)
		local exotic = ""
		if (card.area and card.area.config.collection and G.P_CENTERS['b_bunc_fairy'].unlocked) or (G.GAME and G.GAME.Exotic) then
			exotic = "_exotic"
		end
		local noughts = ""
		if UNIK.suit_in_deck('unik_Noughts') then
			noughts = "_noughts"
		end
		return {
			key = "j_bunc_crop_circles" .. noughts .. exotic,
			vars = {
				card.ability.extra.club_mult,card.ability.extra.eight_mult,card.ability.extra.nought,card.ability.extra.fleuron_mult
			}
		}
	end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then

            local other_card = context.other_card

            local rank_mult = 0
            local suit_mult = 0

            if not SMODS.has_no_suit(other_card) then
                if other_card.base.suit == "bunc_Fleurons" then
                    suit_mult = suit_mult + 4
                elseif other_card.base.suit == "Clubs" then
                    suit_mult = suit_mult + 3
				elseif other_card.base.suit == "unik_Noughts" then
					suit_mult = suit_mult + 1
				end
            end

            if not SMODS.has_no_rank(other_card) then
                if other_card:get_id() == 8 then
                    rank_mult = rank_mult + 2
                elseif other_card:get_id() == 12 or other_card:get_id() == 10 or other_card:get_id() == 9 or other_card:get_id() == 6 then
                    rank_mult = rank_mult + 1
                end
            end

            if (suit_mult + rank_mult) > 0 then
                if not context.blueprint and BUNCOMOD.funcs.exotic_in_pool() then
					G.E_MANAGER:add_event(Event({
						func = function()
                            card.children.center:set_sprite_pos({x = 2, y = 7})
                            return true
                        end
					}))
                end
                return {
                    mult = suit_mult + rank_mult
                }
            end
        end
    end,
}, true)

--make trigger finger less buggy
SMODS.Joker:take_ownership("j_bunc_trigger_finger",{
	calculate = function(self, card, context)
        if context.unik_triggering then 
            if SMODS.pseudorandom_probability(card, 'trigger_finger'..G.SEED, 1, card.ability.extra.odds, 'bunc_trigger_finger') then
				if G.SETTINGS.SOUND.bunc_trigger_finger_volume ~= 0 then
					play_sound('bunc_gunshot',1,G.SETTINGS.SOUND.bunc_trigger_finger_volume/100)
					card:juice_up(1,1)
				end
                return {
					message = G.localization.misc.dictionary.bunc_pew,
					colour = G.C.RED,
					finger_triggered = true
				}
            end
		end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult,
            }
        end
    end
}, true)

--jesterman: now each card has an edition and a seal

SMODS.Joker:take_ownership("j_bunc_jmjb",{
	calculate = function(self, card, context)
        if context.open_booster and context.card.ability.name then
            if (context.open_booster and context.card.ability.name == 'Standard Pack' or
            context.open_booster and context.card.ability.name == 'Jumbo Standard Pack' or
            context.open_booster and context.card.ability.name == 'Mega Standard Pack') then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
                    delay = 0,
						func = function()
                        if G.pack_cards and G.pack_cards.cards and G.pack_cards.cards[1] and G.pack_cards.VT.y < G.ROOM.T.h then

                            for _, v in ipairs(G.pack_cards.cards) do
                                if v.config.center == G.P_CENTERS.c_base then
									local new_enhancement = SMODS.poll_enhancement({guaranteed = true})
                                    v:set_ability(G.P_CENTERS[new_enhancement])
                                end
								if not v.edition then
									local edition = poll_edition('standard_edition'..G.GAME.round_resets.ante, 2, true,true)
									v:set_edition(edition)
								end
								if not v.seal then
									v:set_seal(
										SMODS.poll_seal({ guaranteed = true, type_key = "standard" })
									)
								end
								v.ability.unik_shielded = true
								v.debuff = false
                            end

                            return true
                        end
                    end
					}))
            end
        end
    end
}, true)

--actually making astral bottle good
SMODS.Joker:take_ownership("j_cry_astral_bottle",{
	loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.cry_astral) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_cry_astral
		end
		return{
			key = "j_cry_astral_in_a_bottle_but_not_cursed",vars = {}
		}
	end,
	calculate = function(self, card, context)
		if (context.selling_self and not context.retrigger_joker and not context.blueprint) or context.forcetrigger then
			local jokers = {}
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] ~= card and not G.jokers.cards[i].debuff and not G.jokers.cards[i].edition then
					jokers[#jokers + 1] = G.jokers.cards[i]
				end
			end
			if #jokers >= 1 then
				local chosen_joker = pseudorandom_element(jokers, pseudoseed("astral_bottle"))
				chosen_joker:set_edition({ cry_astral = true })
				chosen_joker.ability.unik_limited_edition = true;
				chosen_joker.ability.limited_edition_tally = G.GAME.unik_limited_edition_rounds
				return nil, true
			else
				card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_no_other_jokers") })
			end
		end
	end,
}, true)

--fuck the filler
SMODS.Joker:take_ownership("j_cry_filler",{
    gameset_config = {
		modest = { disabled = true },
		mainline = { disabled = true },
		madness = { disabled = true },
		experimental = { disabled = true },
	},
}, true)

--garden of forking paths must be uncommon, its pretty bad for a rare.
SMODS.Joker:take_ownership("j_cry_gardenfork",{
	rarity = 2,
}, true)

SMODS.Joker:take_ownership("j_aij_mistake",{
    calculate = function(self, card, context)
		if (card.config.center.paperback and card.config.center.paperback.permanently_eternal) or card.ability.unik_taw then
			if not G.GAME.banned_keys then
				G.GAME.banned_keys = {}
				end
				if not G.GAME.cry_banished_keys then
					G.GAME.cry_banished_keys = {}
				end
				G.GAME.cry_banished_keys[card.config.center.key] = true
				card.ability.destroyed_by_megatron = true
				G.E_MANAGER:add_event(Event({
					trigger="immediate",
					func = function()
					
					card:gore6_break()
				return true end }))
		end
	end
}, true)