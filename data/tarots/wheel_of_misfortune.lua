--4 in 5 chance of creating a cursed Joker,
-- otherwise turn 1 random Joker negative, Mosaic or Astral
--This is where Yes! Nothing* becomes very useful as it guarantees positive effects
--Oops all 6s and rigged will only guarantee negative effects
SMODS.Consumable{
    set = 'Tarot', 
	atlas = 'unik_tarots',
    cost = 4,
	pos = {x = 0, y = 0},
	key = 'unik_wheel_of_misfortune',
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
    config = { extra = { odds = 5 } },
    loc_vars = function(self, info_queue, card)
        if not card.edition or (card.edition and not card.edition.cry_mosaic) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_cry_mosaic
		end
		if not card.edition or (card.edition and not card.edition.negative) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		end
		if not card.edition or (card.edition and not card.edition.cry_astral) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_cry_astral
		end
		return {
			vars = {
				card and cry_prob(card.ability.cry_prob * 4 or 4, card.ability.extra.odds, card.ability.cry_rigged) or 4,
				card and card.ability.extra.odds or self.config.extra.odds,
			},
		}
	end,
    
	use = function(self, card, area, copier)
        local used_consumable = copier or card
        if pseudorandom(pseudoseed("unik_wheelmisfortune")) < cry_prob(card.ability.cry_prob * 4 or 4, card.ability.extra.odds, card.ability.cry_rigged)
		/ card.ability.extra.odds then --bad
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
					used_consumable:juice_up(0.3, 0.5)
                    local card2 = create_card("Joker", G.jokers, nil, "cry_cursed", nil, nil, nil, "unik_wheel_curse")
                    card2:add_to_deck()
                    G.jokers:emplace(card2)
                    card2:start_materialize()
					return true
				end,
			}))
        else --good
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                local eligible_card = pseudorandom_element(card.eligible_strength_jokers2, pseudoseed('unik_wheel_success'))
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					func = function()
						if eligible_card then
							local random_result = pseudorandom(pseudoseed("cry-Ritual"))
							if random_result >= 5 / 6 then
								eligible_card:set_edition({ cry_astral = true })
							else
								if random_result >= 1 / 2 then
									eligible_card:set_edition({ cry_mosaic = true })
								else
									eligible_card:set_edition({ negative = true })
								end
							end
						end
						return true
					end,
				}))
                card:juice_up(0.3, 0.5)
            return true end }))
        end
    end
}