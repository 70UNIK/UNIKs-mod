--The Evocation!
--3 in 5 chance to add a random detrimental edition. Otherwise add a random non-detrimental edition.
local blacklisted_editions = {
    "e_base", -- oops
    "e_jen_bloodfoil", "e_jen_blood", "e_jen_moire", -- "e_jen_unreal"
}
SMODS.Consumable{
    set = "Rotarot",
   	key = "unik_rot_wheel_of_misfortune",
	pos = { x = 1, y = 0 },
	atlas = "unik_rotarots",
	display_size = { w = 106, h = 106 },
    cost = 4,
    update = function(self,card,dt)
        if (G.jokers) then
            card.eligible_strength_jokers2 = EMPTY(card.eligible_strength_jokers2)
            for k, v in pairs(G.jokers.cards) do
                if v.ability.set == 'Joker' and (not v.edition) then
                    table.insert(card.eligible_strength_jokers2, v)
                end
            end
        end
    end,
    can_use = function(self, card)
        if next(card.eligible_strength_jokers2) then return true end
	end,
    config = { extra = { mischance = 3, odds = 4 } },
    loc_vars = function(self, info_queue, card)
        for _, thing in pairs(G.P_CENTER_POOLS["Edition"]) do
            local blacklisted = false
			for _, bl_ed in pairs(blacklisted_editions) do
                if thing.key == bl_ed then
                    blacklisted = true
                end
			end
            if not blacklisted then
                info_queue[#info_queue + 1] = thing
            end
		end
		local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.mischance, card.ability.extra.odds, 'unik_rotwheelmisfortune')
		return {
			vars = {new_numerator, new_denominator},
		}
	end,
    
	use = function(self, card, area, copier)
        local used_consumable = copier or card

        local bad_editions = {}
        local good_editions = {} ---not always good if not defined as detrimental = true

        for _, thing in pairs(G.P_CENTER_POOLS["Edition"]) do
            local blacklisted = false
            local bad = false
			for _, bl_ed in pairs(blacklisted_editions) do
                if thing.key == bl_ed then
                    blacklisted = true
                end
                if thing.detrimental then
                    bad = true
                end
			end
            if not blacklisted then
                if bad then
                    bad_editions[#bad_editions+1] = thing.key
                else
                    good_editions[#good_editions+1] = thing.key
                end
            end
		end
        if SMODS.pseudorandom_probability(card, 'unik_wheelmisfortune', card.ability.extra.mischance, card.ability.extra.odds, 'unik_rotwheelmisfortune')  then --bad
            G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function() --"borrowed" from Wheel Of Fortune
					attention_text({
						text = localize("k_unik_too_bad"),
						scale = 1.3,
						hold = 1.4,
						major = used_consumable,
						backdrop_colour = G.C.SECONDARY_SET.Tarot,
						align = (
							G.STATE == G.STATES.TAROT_PACK
							or G.STATE == G.STATES.SPECTRAL_PACK
							or G.STATE == G.STATES.SMODS_BOOSTER_OPENED
						)
								and "tm"
							or "cm",
						offset = {
							x = 0,
							y = (
								G.STATE == G.STATES.TAROT_PACK
								or G.STATE == G.STATES.SPECTRAL_PACK
								or G.STATE == G.STATES.SMODS_BOOSTER_OPENED
							)
									and -0.2
								or 0,
						},
						silent = true,
					})
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.06 * G.SETTINGS.GAMESPEED,
						blockable = false,
						blocking = false,
						func = function()
							play_sound("tarot2", 0.76, 0.4)
							return true
						end,
					}))
					play_sound("tarot2", 1, 0.4)
                    local eligible_card = pseudorandom_element(card.eligible_strength_jokers2, pseudoseed('unik_rotwheel_fail'))
                    local edition = pseudorandom_element(bad_editions, pseudoseed("unik_rotwheel_bad_roll"))
                    eligible_card:set_edition(edition, true,nil, true)
                    check_for_unlock({type = 'have_edition'})
                    used_consumable:juice_up(0.3, 0.5)

					return true
				end,
			}))
        else --good
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                local eligible_card = pseudorandom_element(card.eligible_strength_jokers2, pseudoseed('unik_rotwheel_success'))
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					func = function()
						if eligible_card then
                            local edition = pseudorandom_element(good_editions, pseudoseed("unik_rotwheel_good_roll"))
                            eligible_card:set_edition(edition, true,nil, true)
                            check_for_unlock({type = 'have_edition'})
						end
						return true
					end,
				}))
                card:juice_up(0.3, 0.5)
            return true end }))
        end
    end
}