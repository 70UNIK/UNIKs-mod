--rig an evocation and use it
SMODS.Achievement{
    key = "unik_stupid_summoning",
    order = 1,
    bypass_all_unlocked = true,
    hidden_text = true,
    atlas = "achievements",
    pos = { x = 3, y = 0 },
    --reset_on_startup = true,
    unlock_condition = function(self, args)
        if args.type == "unik_guaranteed_summon_cursed" then
			return true
		end
    end,
}
