SMODS.Voucher {
    key = 'unik_blindside_sapient_sacrifice',
    atlas = 'unik_blindside_consumables',
    pos = {x = 3, y = 3},
    cost = 10,
    in_pool = function(self, args)
        return UNIK.hasBlindside()
    end,
    set_card_type_badge = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_relic'), G.C.RED, G.C.WHITE, 1.2 )
    end,
    redeem = function(self, card)
        add_tag(Tag('tag_unik_blindside_sapient_sacrifice_relic'))
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.bld_obj_ritual_rate = 1
                return true
            end
        }))
    end,
}