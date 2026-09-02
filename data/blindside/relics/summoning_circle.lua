SMODS.Tag {
    key = "unik_blindside_summoning_circle_relic",
    config = {
        relic = true
    },
    hide_ability = false,
    atlas = 'unik_tags',
    pos = {x = 5, y = 2},
    in_pool = function(self, args)
        return false
    end,
    apply = function(self, tag, context)
        if context.type == 'eval' and (G.GAME.blind.boss or G.GAME.last_joker)  then
            add_tag(Tag('tag_unik_blindside_cult'))
        end
    end
}