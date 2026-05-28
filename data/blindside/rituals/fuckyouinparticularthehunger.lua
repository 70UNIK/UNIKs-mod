--yearh this is a vent ritual.
--cause black deck starts with this
SMODS.Consumable {
    key = 'unik_fuck_the_worst_fucking_thing_that_is_the_hunger',
    set = 'bld_obj_ritual',
    atlas = 'placeholders',
	pos = { x = 2, y = 1 },
    can_use = function (self, card)
        return true
    end,
    in_pool = function(self)
        for i,v in pairs(G.playing_cards) do
            if v.ability and v.ability.extra and type(v.ability.extra) == 'table' and v.ability.extra.stubborn then
                return true
            end
        end
        return false
    end,
    -- config = {extra = {base = 2, odds = 5,x_chips = 0.25, x_mult = 0.25, money = 2}},
    use = function(self, card, area)
        for i,v in pairs(G.playing_cards) do
            if v.ability and v.ability.extra and type(v.ability.extra) == 'table' and v.ability.extra.stubborn then
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    func = function()
                        if not G.GAME.banned_keys then
                        G.GAME.banned_keys = {}
                        end
                        if not G.GAME.cry_banished_keys then
                            G.GAME.cry_banished_keys = {}
                        end
                        G.GAME.cry_banished_keys[card.config.center.key] = true
                        G.E_MANAGER:add_event(Event({
                            trigger="immediate",
                            func = function()
                            
                            card:gore6_break()
                        return true end }))
                        return true
                    end
                }))
            end
           
        end
    
        delay(0.6)
        G.E_MANAGER:add_event(Event({
            func = function ()
                if not G.GAME.banned_keys then
                G.GAME.banned_keys = {}
                end
                if not G.GAME.cry_banished_keys then
                    G.GAME.cry_banished_keys = {}
                end
                G.GAME.cry_banished_keys[card.config.center.key] = true
                G.E_MANAGER:add_event(Event({
                    trigger="immediate",
                    func = function()
                    
                    card:gore6_break()
                return true end }))
                return true
            end
        }))
    end,
    loc_vars = function(self, info_queue, card)
        --local n,d = SMODS.get_probability_vars(card, card.ability.extra.base, card.ability.extra.odds,"unik_erosion")
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_banishing" }
        info_queue[#info_queue + 1] = { set = "Other", key = "bld_stubborn" }
        info_queue[#info_queue+1] = G.P_CENTERS['m_bld_hunger']
    end,
}