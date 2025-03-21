SMODS.Joker {
    key = 'unik_yes_nothing',
    atlas = 'unik_uncommon',
    rarity = 2,
	pos = { x = 2, y = 0 },
    cost = 4,
    blueprint_compat = false,
    perishable_compat = true,
	eternal_compat = true,
    --config = { extra = { Xmult = 1.32} },
    -- loc_vars = function(self, info_queue, center)
	-- 	return { vars = {center.ability.extra.Xmult} }
	-- end,\
    --ortalab has woo all 1s, hence its redundant on modest
    gameset_config = {
		modest = { disabled = (SMODS.Mods["ortalab"] or {}).can_load },
	},
    loc_vars = function(self, info_queue, center)
		return { 
			key = Cryptid.gameset_loc(self, { modest = "modest"}), 
		}
	end,
    add_to_deck = function(self, card, from_debuff)
        local yesNothingExists = 0
        for _, v in pairs(G.jokers.cards) do
            --print("Joker in set:")
            --print(v.ability.name)
            if v.ability.name == "j_unik_yes_nothing" then
                --print("checkSlots")
                --print("happyFound")
                yesNothingExists = yesNothingExists + 1
                --CheckSlots(v,v.ability.extra.slotLimit)
            end
        end
        if yesNothingExists <= 0 then
            --print("reduce")
            for k, v in pairs(G.GAME.probabilities) do 
                if  Card.get_gameset(card) ~= "modest" then
                    G.GAME.probabilities[k] = v/1e100
                else
                    G.GAME.probabilities[k] = v/2
                end
            end
        end
	end,
	-- Inverse of above function.
	remove_from_deck = function(self, card, from_debuff)
        local yesNothingExists = 0
        for _, v in pairs(G.jokers.cards) do
            --print("Joker in set:")
            --print(v.ability.name)
            if v.ability.name == "j_unik_yes_nothing" then
                --print("checkSlots")
                --print("happyFound")
                yesNothingExists = yesNothingExists + 1
                --CheckSlots(v,v.ability.extra.slotLimit)
            end
        end
        if yesNothingExists <= 0 then
            --print("add")
            for k, v in pairs(G.GAME.probabilities) do 
                if  Card.get_gameset(card) ~= "modest" then
                    G.GAME.probabilities[k] = v*1e100
                else
                    G.GAME.probabilities[k] = v*2
                end
            end
        end
	end,
}