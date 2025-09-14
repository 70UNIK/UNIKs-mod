--PAVED Joker but better
--Rankless/Suitless cards can fill gaps of 1 in straights, flushes, spectrums and of a kind hands
SMODS.Joker {
    key = 'unik_pavement_joker',
    atlas = 'unik_uncommon',
	pos = { x = 2, y = 2 },
    rarity = 2,
    cost = 6,
    perishable_compat = true,
	eternal_compat = true,
    config = {extra = {stones = 1}},
    in_pool = function()
        local stoneCards = 0
        if G.deck then 
            for i, w in pairs(G.deck.cards) do
                if SMODS.has_no_suit(w) and SMODS.has_no_rank(w) then
                    stoneCards = stoneCards + 1
                end
            end
        end
        if stoneCards >= 1 then
            return true
        end
        return false
	end,
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.stones} }
	end,
	--too laggy
    -- calculate = function(self, card, context)
    --     if context.unik_pavement then
    --         return {
    --             req_reduction_max = card.ability.extra.stones
    --         }
    --     end
    -- end,
}

local fourHook = SMODS.four_fingers
function SMODS.four_fingers(hand_type)
    local ret = fourHook(hand_type)
    return math.max(math.ceil(ret - UNIK.paved_calc()),0)
end

function UNIK.paved_calc()
    local stones = 0
    local maxStones = 0
	for i,v in pairs(G.jokers.cards) do
		if v.config.center.key == 'j_unik_pavement_joker' then
			maxStones = maxStones + v.ability.extra.stones
		end
	end
    for i, v in pairs(G.hand.highlighted or {}) do
        if SMODS.has_no_rank(v) and SMODS.has_no_suit(v) then
            stones = stones + 1
        end
    end
    for i, v in pairs(G.play.cards or {}) do
        if SMODS.has_no_rank(v) and SMODS.has_no_suit(v) then
            stones = stones + 1
        end
    end
    return math.floor(math.min(stones,maxStones))
end

--StraightCalc
local get_straight_ref = get_straight
function get_straight(hand, min_length, skip, wrap)
	local permutations = {}
	local ranks = {}
	local cards = {}
	local stones = UNIK.paved_calc()
	if stones > 0 then
		for i, v in pairs(hand) do
			if not SMODS.has_no_suit(v) and SMODS.has_no_rank(v) then
				cards[#cards + 1] = v
				for i, v in pairs(UNIK.next_ranks(v:get_id(), nil, stones)) do --this means its inaccurate in some situations like K S S S S but its fine there isnt a better way
					ranks[v] = true
				end
			end
			if v:get_id() >= 11 then
				new_ranks = {
					"Ace",
					"King",
					"Queen",
					"Jack",
					10,
				}
				for i, v in pairs(new_ranks) do
					ranks[v] = true
				end
			end
		end
		local rranks = {}
		for i, v in pairs(ranks) do
			rranks[#rranks + 1] = i
		end
		for i, v in UNIK.unique_combinations(rranks) do
			if #i == stones then
				permutations[#permutations + 1] = i
			end
		end
		for i, v in ipairs(permutations) do
			local actual = {}
			local ranks = {}
			for i, v in pairs(cards) do
				actual[#actual + 1] = v
				ranks[v:get_id()] = true
			end
			for i, p in pairs(v) do
				local d = UNIK.create_dummy_from_stone(p)
				if not ranks[d:get_id()] then
					actual[#actual + 1] = d
				end
			end
			local ret = get_straight_ref(actual, min_length + stones, skip, true)
			if ret and #ret > 0 then
				return ret
			end
		end
	end

	return get_straight_ref(hand, min_length + stones, skip, wrap)
end
--Nextranks
function UNIK.next_ranks(key, start, recurse)
	key = ({
		["14"] = "Ace",
		["13"] = "King",
		["12"] = "Queen",
		["11"] = "Jack",
	})[tostring(key)] or key
	local rank = SMODS.Ranks[tostring(key)]
	local ret = {}
	if not rank or (not start and not wrap and rank.straight_edge) then
		return ret
	end
	for _, v in ipairs(rank.next) do
		ret[#ret + 1] = v
		local curr = #ret
		if recurse and recurse > 0 then
			for i, v in pairs(UNIK.next_ranks(ret[#ret], start, recurse - 1)) do
				ret[#ret + 1] = v
			end
		end
	end
	return ret
end

local function append(t, new)
	local clone = {}
	for _, item in ipairs(t) do
		clone[#clone + 1] = item
	end
	clone[#clone + 1] = new
	return clone
end

--Copied again
function UNIK.unique_combinations(tbl, sub, min)
	sub = sub or {}
	min = min or 1
	local wrap, yield = coroutine.wrap, coroutine.yield
	return wrap(function()
		if #sub > 0 then
			yield(sub) -- yield short combination.
		end
		if #sub < #tbl then
			for i = min, #tbl do -- iterate over longer combinations.
				for combo in UNIK.unique_combinations(tbl, append(sub, tbl[i]), i + 1) do
					yield(combo)
				end
			end
		end
	end)
end

function UNIK.create_dummy_from_stone(rank)
	local r = tostring(rank)
	rank = SMODS.Ranks[r].id
	return {
		get_id = function()
			return rank
		end,
		config = {
			center = {},
		},
		ability = {},
		base = {
			id = rank,
			value = rank >= 11 and "Queen" or "10",
		},
	}
end

--Problematic cause sometimes the hook for get_
local XsameHook = get_X_same
function get_X_same(num, hand, or_more)
	local stones = UNIK.paved_calc()
	if stones > 0 then
		local vals = {}
		for i = 1, SMODS.Rank.max_id.value do
			vals[i] = {}
		end
		for i = 1, #G.ENHANCEMENT_OVERRIDE_RANKS do
			vals[#vals + 1] = {}
		end
		for i=#hand, 1, -1 do
			local curr = {}
			table.insert(curr, hand[i])
			local tempstones = stones
			for j=1, #hand do
				if (hand[i]:get_id() == hand[j]:get_id()) and i ~= j then
					table.insert(curr, hand[j])
				end
				if (tempstones > 0 and (SMODS.has_no_rank(hand[i]) or SMODS.has_no_rank(hand[j]) )) and i ~= j then
					table.insert(curr, hand[j])
					tempstones = tempstones - 1
				end
			end
			if or_more and (#curr >= num) or (#curr == num) then
			vals[curr[1]:get_id()] = curr
			end
		end
		local ret = {}
		for i=#vals, 1, -1 do
			if next(vals[i]) then table.insert(ret, vals[i]) end
		end
		return ret
	end
    return XsameHook(num, hand, or_more)
end