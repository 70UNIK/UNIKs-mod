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
            G.GAME.unik_blind_xmult = 1
        end
        if (context.after) and not G.GAME.blind.disabled then
            G.GAME.unik_blind_xmult = G.GAME.unik_blind_xmult or 1
            if G.GAME.unik_blind_xmult > 1 then
                UNIK.blindside_chips_modifyV2({x_mult = G.GAME.unik_blind_xmult})   
                G.GAME.playing_with_fire_num = G.GAME.playing_with_fire_num + 1
                G.GAME.playing_with_fire_each = G.GAME.used_vouchers.v_bld_swearjar and "bld_playing_with_fire_each_3" or "bld_playing_with_fire_each_2"
                G.GAME.playing_with_fire = G.GAME.playing_with_fire + 2 + (G.GAME.used_vouchers.v_bld_swearjar and 1 or 0)
            end
           
            
        end
        if not blind.disabled and context.discard then
            G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.3, func = function()
                G.GAME.blind:set_text()
                blind:wiggle()
                G.GAME.unik_blind_xmult= G.GAME.unik_blind_xmult + 0.05
                return true
            end}))
            
            return {
                message = "+X" .. 0.1 .. localize('k_unik_jmult'),
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