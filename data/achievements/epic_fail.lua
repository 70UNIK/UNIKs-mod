--Score under -1.79e308 chips in a single hand
SMODS.Achievement{
    key = "unik_epic_fail",
    order = 1,
    bypass_all_unlocked = true,
    atlas = "cry_achievements",
    pos = { x = 3, y = 0 },
    --reset_on_startup = true,
    unlock_condition = function(self, args)
        if args.type == "chip_score" and to_big(args.chips) <= -1 * (to_big(2) ^ to_big(1024)) then
            return true
        end
    end,
}
