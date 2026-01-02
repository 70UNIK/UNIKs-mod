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
	death_message="special_lose_unik_tall_poppy_syndrome",
	unik_mod_final_score = function(self,sum)
		if to_big(sum) > to_big(G.GAME.blind.chips) * 2.5 then
			return {mod_score = 0.03}
		end 
		return nil
	end,
}

local smods_calculate_round_score_stuff = SMODS.calculate_round_score
function SMODS.calculate_round_score(flames)
	
	local ret = smods_calculate_round_score_stuff(flames)
	if G.GAME and G.GAME.blind and G.GAME.blind.unik_mod_final_score then
		local table = G.GAME.blind:unik_mod_final_score(ret)
		if table and table.mod_score and type(table.mod_score) == 'number' then
			ret = ret * table.mod_score
		end
	end
	
	return ret
end