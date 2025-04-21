-- Start with an AP joker, mr bones and  but,
-- All blinds are boss blinds
-- and showdown blinds can appear anywhere
-- must win ante 12 to win
-- the last blind is ALWAYS obsidian ORB
SMODS.Challenge{
	key = "unik_boss_rush_2",
	rules = {
		custom = {
			{ id = "cry_rush_hour_ii" },
			{ id = "cry_no_tags" },
            { id = "cry_big_showdown"},
            { id = "unik_ante_12_victory"},
			{ id = "unik_legendary_at_any_time"},
		},
		modifiers = {                
            {id = 'joker_slots', value = 6},
            {id = 'consumable_slots', value = 3},
    },
	},
	jokers = {
		{ id = "j_cry_apjoker", stickers = { "cry_absolute" } },
        { id = "j_mr_bones", stickers = { "eternal" }, edition = "negative" },
	},
	deck = {
		type = "Challenge Deck",
	},
	restrictions = {
		banned_cards = {
			{ id = "j_luchador" },
			{ id = "j_chicot" },
			{ id = "j_throwback" },
			{ id = "j_diet_cola" },
			{ id = "v_directors_cut" },
			{ id = "v_retcon" },
			{ id = "j_cry_pickle" },
			{ id = "v_cry_copies" },
			{ id = "v_cry_tag_printer" },
			{ id = "v_cry_clone_machine" },
		},
		banned_other = {},
	},

}


local gnb2 = get_new_boss
function get_new_boss()
	--Fix an issue with adding bosses mid-run
	for k, v in pairs(G.P_BLINDS) do
		if not G.GAME.bosses_used[k] then
			G.GAME.bosses_used[k] = 0
		end
	end
	--stolen from nostalgic deck CODE, this involves forcing obsidian orb to be at the final ante boss, cause THE FINAL BOSS.
	local bl = gnb2()
	if (G.GAME.modifiers.unik_obsidian_showdown or G.GAME.modifiers.unik_obsidian_swarm) and G.GAME.unik_its_orbin_time then
		return "bl_cry_obsidian_orb"
	elseif G.GAME.modifiers.unik_all_video_poker then
		return "bl_unik_video_poker"
	end
	return bl
end
-- set ante victory to 12
local initializerAnte10 = Game.start_run
function Game:start_run(args)
    local inl = initializerAnte10(self,args)
    if self.GAME and self.GAME.modifiers then
        if self.GAME.modifiers.unik_ante_12_victory then
            self.GAME.win_ante = 10
            --print("BE PREPARED FOR SUFFERING.")
		elseif self.GAME.modifiers.unik_ante_13_victory then
            self.GAME.win_ante = 13
            --print("BE PREPARED FOR SUFFERING.")
        end
		if self.GAME.modifiers.unik_purple_scaling then
			self.GAME.modifiers.scaling = 3
		end
    end
    return inl
end