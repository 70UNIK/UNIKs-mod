--doubled up infuriating notes
--X(current note Xmult)^2, future copies are multiplied by X1.44 Mult 
BLINDSIDE.Joker({
    blindside_joker = true,
    get_assist = function(self)
        return G.P_BLINDS["bl_unik_blindside_infuriating_notes2"]
    end,
    key = 'unik_blindside_infuriating_notes',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=20},
    boss_colour = HEX("b18b6d"),
    mult = 10,
    base_dollars = 12,
    order = 1,
    big = {min = -66},
    active = true,
    loc_vars = function(self,blind)
        G.GAME.unik_infuriating_xmult = G.GAME.unik_infuriating_xmult or 1.2
        return { vars = { G.GAME.unik_infuriating_xmult^2 .. "", 1.2^2 .. "" } }
    end,
    collection_loc_vars = function(self)
        return { vars = { 1.2^2 .. "", 1.2^2 .. "" } }
    end,
    pool_override = function()
        return  (G.GAME.modifiers.enable_bld_elites and G.GAME.round_resets.ante == 5) or G.GAME.round_resets.ante > 7
    end,
    calculate = function(self, blind, context)
        if context.setting_blind and G.GAME.modifiers.enable_bld_deplete_hands and G.GAME.current_round.hands_left > 1 then
            ease_hands_played(-1)
        end
        if (context.after) and not G.GAME.blind.disabled then
            G.GAME.unik_infuriating_xmult = G.GAME.unik_infuriating_xmult or 1.2
            if G.GAME.unik_infuriating_xmult > 1 then
                BLINDSIDE.chipsmodifyV2({x_mult = (G.GAME.unik_infuriating_xmult^2)^(BLINDSIDE.has_canvas(context) and 0.95 or 1)})   
                BLINDSIDE.change_fire_amount({amount = 3})
                        BLINDSIDE.add_fire()
            end
            
        end
    end,
})

BLINDSIDE.Joker({
    key = 'unik_blindside_infuriating_notes2',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=20},
    boss_colour = HEX("b18b6d"),
    mult = 10,
    base_dollars = 12,
    order = 1,
    big = {min = -66},
    active = true,
    is_assistant = true,
    loc_vars = function(self,blind)
        G.GAME.unik_infuriating_xmult = G.GAME.unik_infuriating_xmult or 1.2
        return { vars = { G.GAME.unik_infuriating_xmult^2 .. "", 1.2^2 .. "" } }
    end,
    collection_loc_vars = function(self)
        return { vars = { 1.2^2 .. "", 1.2^2 .. "" } }
    end,
})
