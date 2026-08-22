--X1.2 Chips to joker per Blind scored
BLINDSIDE.Joker({
    blindside_joker = true,
    key = 'unik_blindside_yokana_ramirez',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=31},
    boss_colour = HEX("86CAFE"),
    mult = 12,
    base_dollars = 8,
    order = 1,
    boss = {min = 4},
    active = true,
    death_card = {
        card = 'j_unik_jsab_yokana', 
        mod_card = function(self, card) --used to apply editions and/or stickers
            
        end,
        quotes = {'unik_blindside_yokana_lose'},
        say_times = 7,
    },
    calculate = function(self, blind, context)
        if context.scoring_hand and context.individual and context.cardarea == G.play and not G.GAME.blind.disabled then
            if tableContains(context.other_card, context.scoring_hand) and context.other_card.facing ~= 'back' then
                BLINDSIDE.change_fire_amount({amount = 2})
                BLINDSIDE.add_fire()
                return {
                    message = "X" .. 1.1 .. localize('k_unik_jchips'),
                    colour = G.C.BLACK,
                    focus = context.other_card,
                    func = function ()
                        BLINDSIDE.chipsmodifyV2({x_chips = 1.1})  
                        G.E_MANAGER:add_event(Event({
                            trigger = 'before',
                            delay = 0.8,
                            func = function ()
                                return true
                            end
                        }))
                        G.E_MANAGER:add_event(Event({
                            func = (function()
                            G.GAME.blind:wiggle()
                            return true
                            end)
                        }))
                    end
                }
            end
        end
    end,
})