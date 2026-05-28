--create two heartbreak tags, an imprisonment tag and 2 shield tags
BLINDSIDE.Joker({
    key = 'unik_blindside_spy',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=21},
    boss_colour = HEX('df444f'),
    mult = 25,
    base_dollars = 8,
    order = 1,
    cursed = {min = -66},
    active = true,
    blindside_joker = true,
    in_pool = function(self, args)
        if G.GAME.selected_back.effect.center.config.extra then
            if not UNIK.hasBlindside() then return false end
            return true
        else
        return false
        end
    end,
    debuff = {
        akyrs_blind_difficulty = "unik_blindside_cursed",
    },
     joker_defeat = function()
        add_tag(Tag('tag_bld_heartbreak'))
            add_tag(Tag('tag_bld_heartbreak'))
            add_tag(Tag('tag_bld_imprisonment'))
            add_tag(Tag('tag_unik_blindside_shield'))
            add_tag(Tag('tag_unik_blindside_shield'))
    end,
})
