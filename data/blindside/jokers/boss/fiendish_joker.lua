--All payout is capped at -$1. This includes the payout menu!

BLINDSIDE.Joker({
    key = 'unik_blindside_fiendish_joker',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=17},
    boss_colour = HEX('8A71E1'),
    mult = 20,
    base_dollars = -1, --hahahahahahahahahahhaaa
    order = 1,
    boss = {min = 3},
    active = true,

    death_card = {
        card = (next(SMODS.find_mod("Bunco")) and 'j_bunc_fiendish') or 'j_unik_blindside_fiendish_joker_bunc', 
        mod_card = function(self, card) --used to apply editions and/or stickers
            
        end,
        quotes = {'unik_blindside_fiendish_joker_lose'},
        say_times = 6,
    },
    blindside_joker = true,
    calculate = function(self, blind, context)
        if context.unik_dollar_mod and context.mod ~= 0 and not G.GAME.blind.disabled then
            G.E_MANAGER:add_event(Event({
                        trigger='immediate',
                        delay=1,
                        func = (function()
                        return true
                        end)
                    }))
            -- delay(1)
             G.E_MANAGER:add_event(Event({
                        trigger='after',
                        delay=0.1,
                        func = (function()
    ease_dollars(-math.ceil(G.GAME.dollars/3), true,true)
            blind:wiggle()
            G.GAME.playing_with_fire_num = G.GAME.playing_with_fire_num + 1
            G.GAME.playing_with_fire_each = G.GAME.used_vouchers.v_bld_swearjar and "bld_playing_with_fire_each_2" or "bld_playing_with_fire_each_1"
            G.GAME.playing_with_fire = G.GAME.playing_with_fire + 1 + (G.GAME.used_vouchers.v_bld_swearjar and 1 or 0)
                        return true
                        end)
                    }))
                    
            return {
                
            }
        end
    end,
})

local dollar_ease = ease_dollars
function ease_dollars(mod, instant,stop_mod)
    
    -- if G.GAME.unik_fiendish_cap then
    --     if mod > -2 then
    --         if G.GAME.blind and G.hand and G.hand.cards and G.GAME.blind.in_blind then
    --             G.E_MANAGER:add_event(Event({
    --                 func = (function()
    --                 G.GAME.blind:wiggle()
    --                 return true
    --                 end)
    --             }))
                
    --             G.GAME.playing_with_fire_num = G.GAME.playing_with_fire_num + 1
    --             G.GAME.playing_with_fire_each = G.GAME.used_vouchers.v_bld_swearjar and "bld_playing_with_fire_each_2" or "bld_playing_with_fire_each_1"
    --             G.GAME.playing_with_fire = G.GAME.playing_with_fire + 1 + (G.GAME.used_vouchers.v_bld_swearjar and 1 or 0)
    --         end
            
    --     end
    --     mod = math.min(-2,mod)
    -- end
    dollar_ease(mod,instant)
    
    if not G.GAME.suppress_dollar_mod and not stop_mod then
        G.GAME.suppress_dollar_mod  = true
        SMODS.calculate_context({unik_dollar_mod = true, mod = mod, instant = instant})
        G.GAME.suppress_dollar_mod  = nil
    end
end