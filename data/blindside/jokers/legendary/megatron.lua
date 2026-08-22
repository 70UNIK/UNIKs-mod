
BLINDSIDE.Joker({
    key = 'unik_blindside_megatron',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=28},
    boss_colour = HEX('6E6E6E'),
    mult = 16,
    base_dollars = 10,
    boss = {min = 1, showdown = true},
    order = 22,
    active = true,
    in_pool = function(self, args)
        if G.GAME.selected_back.effect.center.config.extra then
            if not G.GAME.selected_back.effect.center.config.extra.blindside and G.GAME.round_resets.ante%6 == 0 then return false end
            return true
        else
        return false
        end
    end,
    death_card = {
        card = 'j_unik_megatron', 
        mod_card = function(self, card) --used to apply editions and/or stickers
            
        end,
        quotes = {'unik_blindside_megatron_lose'},
    },
    calculate = function(self, blind, context)
        if context.mod_probability and not context.blueprint and not G.GAME.blind.disabled then
            return {
                numerator = context.denominator 
            }
        end
        if context.pseudorandom_result and context.result and not G.GAME.blind.disabled then
            -- blind.triggered = true
            -- BLINDSIDE.chipsmodify(1, 0, 0)
            
            BLINDSIDE.change_fire_amount({amount = 3})
                BLINDSIDE.add_fire()
            local validJokers = {}
                            for i,v in pairs(G.jokers.cards) do
                                if not SMODS.is_eternal(v,self) and not v.ability.destroyed_by_megatron then
                                    validJokers[#validJokers+1] = v
                                end
                            end
            if #validJokers > 0 then
                local select = pseudorandom_element(validJokers, pseudoseed("unik_megatron_rage"))
                select.ability.destroyed_by_megatron = true
                print(context.identifier)
                   
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        select:gore6_break()
                        blind:wiggle()
                            
                    return true end }))
                else
                    BLINDSIDE.chipsmodifyV2({x_mult = 1.75})  
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                
                    blind:wiggle()
                return true end }))
                end
            
        end
        if context.after and blind.triggered and not G.GAME.blind.disabled then
            for i,v in pairs(G.jokers.cards) do
                v.ability.destroyed_by_megatron = nil
            end
        end
    end,
})