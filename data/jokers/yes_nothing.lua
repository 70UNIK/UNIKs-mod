SMODS.Joker {
    key = 'unik_yes_nothing',
    atlas = 'unik_uncommon',
    rarity = 2, --Abstract cards make this rare now.
    -- The wheel
    -- Turquoise tornado
    -- Maroon Magnet (unik)
    -- Coupon codes (dont redeem another) (unik)
    -- Cavendish
    -- glass cards breaking
    --banana stickers
    -- evocation (unik)
    -- demon tag (unik)
    -- disposable/niko consumeables (unik)
    -- broken arm (modest only) (unik)
    -- Ghost (albeit being unable to break)
    -- Monopoly money
    -- old blueprint breaking
    -- critical misses
    -- chocolate die's flickering chance
    -- chocolate die's lunar abyss
    -- chocolate die's bloodsucker
    -- (maybe in the future also abstracted cards breaking)
    -- its likely uncommon for now
	pos = { x = 2, y = 0 },
    cost = 4,
    blueprint_compat = false,
    perishable_compat = true,
	eternal_compat = true,
    immutable = true,
    --config = { extra = { Xmult = 1.32} },
    -- loc_vars = function(self, info_queue, center)
	-- 	return { vars = {center.ability.extra.Xmult} }
	-- end,\
    --ortalab has woo all 1s, hence its redundant on modest
    -- Now that Demon Tag exists, this should be rare, otherwise ppl will be keep on trying to get foundation a lot more easily.
    gameset_config = {
		modest = { disabled = (SMODS.Mods["ortalab"] or {}).can_load,center = { rarity = 2 } },
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
            if v.ability.name == "j_unik_yes_nothing" and v ~= card then
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
            if v.ability.name == "j_unik_yes_nothing" and v ~= card then
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