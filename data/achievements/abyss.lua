--rig an evocation and use it
SMODS.Achievement{
    key = "unik_abyss",
    order = 1,
    bypass_all_unlocked = true,
    hidden_text = true,
    atlas = "achievements",
    pos = { x = 3, y = 1 },
    --reset_on_startup = true,
    unlock_condition = function(self, args)
		if args.type == "lose_to_specific_blind" and (
            args.blind == "bl_unik_legendary_magnet" or 
            args.blind == "bl_unik_legendary_vessel" or 
            args.blind == "bl_unik_legendary_sword" or 
            args.blind == "bl_unik_legendary_tornado" or 
            args.blind == "bl_unik_legendary_nuke" or 
            args.blind == "bl_unik_legendary_pentagram" 
        )then
			return true
		end
    end,
}