--X1 mult per hand, incraese this by X0.1 per blind discarded this round
BLINDSIDE.Joker({
    blindside_joker = true,
    key = 'unik_blindside_recycle_bin',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=9},
    boss_colour = HEX("dfa400"),
    mult = 12,
    base_dollars = 8,
    order = 1,
    boss = {min = 1},
    active = true,
    loc_vars = function(self,blind)
        G.GAME.unik_blind_xmult = G.GAME.unik_blind_xmult or 1
        return { vars = { G.GAME.unik_blind_xmult, 0.05 .. "" } }
    end,
    collection_loc_vars = function(self)
        return { vars = { 1 .. "", 0.05 .. "" } }
    end,
    
    calculate = function(self, blind, context)
        if context.setting_blind and not context.disabled and not G.GAME.blind.disabled then
            G.GAME.unik_dynamic_text_realtime = true
            G.GAME.unik_blind_xmult = 1
        end
        if (context.after) and not G.GAME.blind.disabled then
            G.GAME.unik_dynamic_text_realtime = true
            G.GAME.unik_blind_xmult = G.GAME.unik_blind_xmult or 1
            G.HUD_blind:recalculate(true)
            if G.GAME.unik_blind_xmult > 1 then
                BLINDSIDE.chipsmodifyV2({x_mult = G.GAME.unik_blind_xmult})   
                BLINDSIDE.change_fire_amount({amount = 2})
                BLINDSIDE.add_fire()
            end
           G.GAME.blind:set_text()
            
        end
        if not blind.disabled and context.discard then
            G.GAME.unik_dynamic_text_realtime = true
            G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.3, func = function()
                blind:wiggle()
                G.GAME.unik_blind_xmult= G.GAME.unik_blind_xmult + 0.05
                G.HUD_blind:recalculate(true)
                return true
            end}))
            
            return {
                message = "+X" .. 0.05 .. localize('k_unik_jmult'),
                colour = G.C.BLACK,
                focus = context.other_card,
            }
        end
    end,
    disable = function(self)
        G.GAME.unik_dynamic_text_realtime = nil
        G.GAME.unik_blind_xmult = 1
    end,
    joker_defeat = function()
        G.GAME.unik_dynamic_text_realtime = nil
        G.GAME.unik_blind_xmult = 1
    end
})