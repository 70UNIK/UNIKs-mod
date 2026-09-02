SMODS.Tag {
    key = "unik_blindside_tent_camp_relic",
    config = {
        relic = true
    },
    hide_ability = false,
    atlas = 'unik_tags',
    pos = {x = 4, y = 2},
    in_pool = function(self, args)
        return false
    end,
}