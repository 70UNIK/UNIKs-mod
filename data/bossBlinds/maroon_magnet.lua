--+2 Hand Size Convert 3 in 5 unenhanced cards in deck to steel cards, hand must not hold any steel cards
SMODS.Blind{
    key = 'unik_maroon_magnet',
    config = {},
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 11},
    boss_colour= HEX("5c0007"),
    dollars = 8,
    mult = 2,
    loc_vars = function(self)
        local new_numerator, new_denominator = SMODS.get_probability_vars(self, 2,3, 'unik_maroon_magnet')
		return { vars = { new_numerator, new_denominator } }
	end,
	collection_loc_vars = function(self)
        local new_numerator, new_denominator = SMODS.get_probability_vars(self, 2,3, 'unik_maroon_magnet')
		return { vars = { new_numerator, new_denominator } }
	end,
	set_blind = function(self)
		G.GAME.unik_killed_by_magnet = true
        --Get all unenhanced cards
        if not reset then
            local text = localize('k_unik_magnet_start')
            attention_text({
                scale = 0.75, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
            })
            for i, w in pairs(G.deck.cards) do
                if w.config.center == G.P_CENTERS.c_base and (SMODS.pseudorandom_probability(self, pseudoseed('unik_maroon_magnet'), 2, 3, 'unik_maroon_magnet'))then
                    w:set_ability(G.P_CENTERS["m_steel"], nil, true)
                end
            end
            G.GAME.blind.triggered = true
            G.GAME.blind:wiggle()
            G.hand:change_size(2)
        end
	end,
    --Disable if no cards are enhanced and no steel cards present AND if alloy is obtained, also no gold cards
    in_pool = function()
        local goldenAlloy = false
        local steels = 0
        local unenhanced = 0
        if G.jokers then
            for _, v in pairs(G.jokers.cards) do
                if v.config.center.key == "j_ExtraCredit_alloy" then
                    goldenAlloy =true
                end
            end
        end
        if G.deck then 
            for i, v in pairs(G.deck.cards) do
                if SMODS.has_enhancement(v,'m_steel') or (goldenAlloy == true and v.config.center == G.P_CENTERS.m_gold) then
                    steels = steels + 1
                end
            end
            for i, w in pairs(G.deck.cards) do
                if w.config.center == G.P_CENTERS.c_base then
                    unenhanced = unenhanced + 1
                end
            end
        end
        if steels > 3 or unenhanced > 3 then
            return true
        end
        return false
    end,
    get_loc_debuff_text = function(self)
		return localize("k_unik_magnet_warning")
	end,
    --debuff hand if a steel card is held in hand and unselected
    debuff_hand = function(self, cards, hand, handname, check)
        --during initial selection
        if check then
            local goldenAlloy = false
            local steels = 0
            local steelsPlayed = 0
            --If alloy (extra credit) is present, treat GOLD cards as steel cards as well!
            for _, v in pairs(G.jokers.cards) do
                if v.config.center.key == "j_ExtraCredit_alloy" then
                    goldenAlloy =true
                end
            end
            for k, v in pairs(G.hand.cards) do
                if SMODS.has_enhancement(v,'m_steel') or (goldenAlloy == true and v.config.center == G.P_CENTERS.m_gold) then
                    steels = steels + 1
                end
            end
            for k, v in ipairs(cards) do
                if SMODS.has_enhancement(v,'m_steel') or (goldenAlloy == true and v.config.center == G.P_CENTERS.m_gold) then
                    steelsPlayed = steelsPlayed + 1
                end
            end
            if steels > steelsPlayed then
                G.GAME.blind.triggered = true
                return true
            else
                return false
            end
        else
            local goldenAlloy = false
            local steels = 0
            --If alloy (extra credit) is present, treat GOLD cards as steel cards as well!
            for _, v in pairs(G.jokers.cards) do
                if v.config.center.key == "j_ExtraCredit_alloy" then
                    goldenAlloy =true
                end
            end
            for k, v in pairs(G.hand.cards) do
                if SMODS.has_enhancement(v,'m_steel') or (goldenAlloy == true and v.config.center == G.P_CENTERS.m_gold) then
                    steels = steels + 1
                end
            end
            if steels > 0 then
                G.GAME.blind.triggered = true
                return true
            else
                return false
            end
        end

	end,
	disable = function(self)
        --avoid chicot permanently depleting hand size to 0 by only triggering if the killed by magnet flag is true
        if not G.GAME.blind.disabled then
            if G.GAME.unik_killed_by_magnet then
                G.hand:change_size(-2)
            end
            G.GAME.unik_killed_by_magnet = nil
        end
	end,
	defeat = function(self)
        if not G.GAME.blind.disabled then
            if G.GAME.unik_killed_by_magnet then
                G.hand:change_size(-2)
            end
            G.GAME.unik_killed_by_magnet = nil
        end
	end,
}