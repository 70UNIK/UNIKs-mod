SMODS.Voucher {
    key = 'unik_blindside_tent_camp',
    atlas = 'unik_blindside_consumables',
    pos = {x = 1, y = 3},
    cost = 10,
    in_pool = function(self, args)
        return UNIK.hasBlindside()
    end,
    set_card_type_badge = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_relic'), G.C.RED, G.C.WHITE, 1.2 )
    end,
    redeem = function(self, card)
        add_tag(Tag('tag_unik_blindside_tent_camp_relic'))
    end,
}