--Used to prevent hand from scorng if exceeding 2.5x requirements, 
--now it's a conditional version of The Tax, where hands exceeding 2.5x reqs get their score multiplied by 0.05x, meaning its possible to brute force if scoring really high.
SMODS.Blind{

    key = 'unik_the_poppy',
    config = {},
	boss = {
		min = 1,
	},
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 6},
    boss_colour= HEX("ff4a64"),
    dollars = 5 ,
    mult = 2,
	loc_vars = function(self, info_queue, card)
		return { vars = { 2.5 * get_blind_amount(G.GAME.round_resets.ante) * 2 * G.GAME.starting_params.ante_scaling } } -- no bignum?
	end,
	collection_loc_vars = function(self)
		return { vars = { localize("k_unik_poppy_placeholder") } }
	end,
	set_blind = function(self)
		G.GAME.unik_killed_by_poppy = true
		--G.GAME.unik_poppy_ceil = true
	end,
	disable = function(self)
		G.GAME.unik_killed_by_poppy = nil
		--G.GAME.unik_poppy_ceil = nil
	end,
	-- --The tax's functionality is used here instead. Pray it only activates if outside 2.5x reqs.
	-- cry_cap_score = function(self, score)
	-- 	if score > 2.5 * G.GAME.blind.chips then
    --         G.GAME.blind.triggered = true
    --         G.GAME.blind:wiggle()
	-- 		return 0.03 * score
	-- 	end
	-- end,
	-- unik_cap_score = function(self,score)
	-- 	if to_big(score) > to_big(2.5 * G.GAME.blind.chips) then
    --         G.GAME.blind.triggered = true
    --         G.GAME.blind:wiggle()
	-- 		return 0.03 * score
	-- 	end
	-- end,
	defeat = function(self)
		G.GAME.unik_killed_by_poppy = nil
		--G.GAME.unik_poppy_ceil = nil
	end,
}

-- local capper = SMODS.calculate_round_score
-- function SMODS.calculate_round_score()
-- 	local ret = capper()
-- 	if G.GAME and G.GAME.blind then
-- 		return ret * (G.GAME.blind:unik_cap_score(ret) or 1)
-- 	else
-- 		return ret
-- 	end
	
-- end
