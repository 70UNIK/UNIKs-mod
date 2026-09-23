--+
BLINDSIDE.Joker({
    blindside_joker = true,
    key = 'unik_blindside_chelsea_ramirez',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=30},
    boss_colour = HEX("d19bff"),
    mult = 15,
    base_dollars = 8,
    order = 1,
    boss = {min = 2},
    active = true,
    loc_vars = function(self,blind)
        G.GAME.unik_blind_xchips = G.GAME.unik_blind_xchips or 1
        return { vars = { G.GAME.unik_blind_xchips, 0.1 .. "" } }
    end,
    collection_loc_vars = function(self)
        return { vars = { 1 .. "", 0.1 .. "" } }
    end,
    death_card = {
        card = 'j_unik_jsab_chelsea', 
        mod_card = function(self, card) --used to apply editions and/or stickers
            
        end,
        quotes = {'unik_blindside_chelsea_lose'},
        say_times = 7,
    },
    calculate = function(self, blind, context)
        if context.setting_blind and not context.disabled and not G.GAME.blind.disabled then
            G.GAME.unik_dynamic_text_realtime = true
            G.GAME.unik_blind_xchips = 1
        end
        if (context.after) and not G.GAME.blind.disabled then
            G.GAME.unik_dynamic_text_realtime = true
            G.GAME.unik_blind_xchips = G.GAME.unik_blind_xchips or 1
            G.HUD_blind:recalculate(true)
            if G.GAME.unik_blind_xchips > 1 then
                BLINDSIDE.chipsmodifyV2({x_chips = G.GAME.unik_blind_xchips})   
                BLINDSIDE.change_fire_amount({amount = 2})
                BLINDSIDE.add_fire()
            end
           G.GAME.blind:set_text()
            
        end
        if context.unik_chelsea_trigger and context.card and not G.GAME.blind.disabled then
                    G.GAME.unik_dynamic_text_realtime = true
                    G.GAME.unik_blind_xchips= G.GAME.unik_blind_xchips + 0.1
                    G.HUD_blind:recalculate(true)
            return {
                message = "+X" .. 0.1 .. localize('k_unik_jchips'),
                colour = G.C.BLACK,
                focus = context.other_card,
            }
        end
    end,
    disable = function(self)
        G.GAME.unik_dynamic_text_realtime = nil
        G.GAME.unik_blind_xchips = 1
    end,
    joker_defeat = function()
        G.GAME.unik_dynamic_text_realtime = nil
        G.GAME.unik_blind_xchips = 1
    end
})