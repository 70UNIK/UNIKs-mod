--X(current note Xmult) Mult, future copies are multiplied by X1.2 Mult 
BLINDSIDE.Joker({
    blindside_joker = true,
    key = 'unik_blindside_infuriating_note',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=20},
    boss_colour = HEX("b18b6d"),
    mult = 10,
    base_dollars = 6,
    order = 1,
    big = {min = 1},
    active = true,
    loc_vars = function(self,blind)
        G.GAME.unik_infuriating_xmult = G.GAME.unik_infuriating_xmult or 1.2
        return { vars = { G.GAME.unik_infuriating_xmult .. "", 1.2 .. "" } }
    end,
    collection_loc_vars = function(self)
        return { vars = { 1.2 .. "", 1.2 .. "" } }
    end,
    pool_override = function()
        return  G.GAME.unik_banana_generated  and not (G.GAME.modifiers.enable_bld_elites and G.GAME.round_resets.ante == 5) and G.GAME.modifiers.enable_bld_tough_jokers
    end,
    calculate = function(self, blind, context)
        if (context.after) and not G.GAME.blind.disabled then
            G.GAME.unik_infuriating_xmult = G.GAME.unik_infuriating_xmult or 1.2
            if G.GAME.unik_infuriating_xmult > 1 then
                UNIK.blindside_chips_modifyV2({x_mult = G.GAME.unik_infuriating_xmult})   
                G.GAME.playing_with_fire_num = G.GAME.playing_with_fire_num + 1
                G.GAME.playing_with_fire_each = G.GAME.used_vouchers.v_bld_swearjar and "bld_playing_with_fire_each_3" or "bld_playing_with_fire_each_2"
                G.GAME.playing_with_fire = G.GAME.playing_with_fire + 2 + (G.GAME.used_vouchers.v_bld_swearjar and 1 or 0)
            end
            
        end
    end,
})