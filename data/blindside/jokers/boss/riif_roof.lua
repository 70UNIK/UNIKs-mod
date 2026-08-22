BLINDSIDE.Joker({
    blindside_joker = true,
    key = 'unik_blindside_riif_roof',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=11},
    boss_colour = HEX("ff2139"),
    mult = 6,
    base_dollars = 8,
    order = 1,
    boss = {min = 2},
    active = true,
    death_card = {
        card = 'j_unik_riif_roof', 
        mod_card = function(self, card) --used to apply editions and/or stickers
            
        end,
        quotes = {'unik_blindside_riif_roof_lose'},
        say_times = 6,
    },
     loc_vars = function (self)
        return {
            vars = {
                1.15
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                1.15
            }
        }
    end,
    calculate = function(self, blind, context)
        if (context.other_joker) then
            return {
                    message = "X" .. 1.15 .. localize('k_unik_jmult'),
                    colour = G.C.BLACK,
                    focus = context.other_card,
                    func = function ()
                        BLINDSIDE.change_fire_amount({amount = 2})
                        BLINDSIDE.add_fire()
                        BLINDSIDE.chipsmodifyV2({x_mult = 1.15})   
                        G.E_MANAGER:add_event(Event({
                            func = (function()
                            G.GAME.blind:wiggle()
                            return true
                            end)
                        }))
                        G.E_MANAGER:add_event(Event({
                            trigger = 'before',
                            delay = 0.8,
                            func = function ()
                                return true
                            end
                        }))
                    end
                }
        end
    
    end,
})
