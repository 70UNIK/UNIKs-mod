SMODS.Blind{
    key = 'unik_epic_xenomorph_queen',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 12},
    boss_colour= HEX("1c5607"), 
    dollars = 13,
    mult = 0.5,
    ignore_showdown_check = true,
	loc_vars = function(self)
        local new_numerator, new_denominator = SMODS.get_probability_vars(self, 1,4, 'unik_xenomorph_queen')
		return { vars = { new_numerator, new_denominator } }
	end,
	collection_loc_vars = function(self)
         local new_numerator, new_denominator = SMODS.get_probability_vars(self, 1,4, 'unik_xenomorph_queen')
		return { vars = { new_numerator, new_denominator } }
	end,
    debuff = {
        akyrs_blind_difficulty = "epic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
    get_loc_debuff_text = function(self)
		return localize("k_unik_debuffed_card_only")
	end,
    death_message = "special_lose_unik_epic_xenomorph",
	unik_kill_hand = function(self, cards, hand, handname, check)
		for k, v in ipairs(cards) do
			if not v.debuff then
				return true
			end
		end
        return false
	end,
    stay_flipped = function(self, area, card)
		if SMODS.pseudorandom_probability(self, pseudoseed('unik_xenomorph_queen'), 1, 4, 'unik_xenomorph_queen')  then
            card:set_debuff(true)
            G.GAME.blind.triggered = true
            G.GAME.blind:wiggle()
            
        end
	end,
    set_blind = function(self, reset, silent)
        if not reset then
            -- G.GAME.unik_xenomorph_debuff = true
            local text = localize('k_unik_xenomorph_start')
            attention_text({
                scale = 0.75, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = HEX("1c5607")
            })
        end
    end,
	in_pool = function(self)
        return CanSpawnEpic()
	end,
    -- disable = function(self)
    --     G.GAME.unik_xenomorph_debuff = nil
    -- end,
}

