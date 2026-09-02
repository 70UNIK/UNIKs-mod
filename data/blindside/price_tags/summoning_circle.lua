--create a cult tag after boss joker defeated
SMODS.Voucher {
    key = 'unik_blindside_summoning_circle',
    atlas = 'unik_blindside_consumables',
    pos = {x = 2, y = 3},
    cost = 10,
    in_pool = function(self, args)
        return UNIK.hasBlindside()
    end,
    set_card_type_badge = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_relic'), G.C.RED, G.C.WHITE, 1.2 )
    end,
    redeem = function(self, card)
        add_tag(Tag('tag_unik_blindside_summoning_circle_relic'))
    end,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_TAGS.tag_unik_blindside_cult
    end,
}