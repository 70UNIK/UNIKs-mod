--Gains +#1# Mult after hand, increase this by +1 for every 3 rounds
BLINDSIDE.Joker({
    blindside_joker = true,
    key = 'unik_blindside_game_bro',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=34},
    boss_colour = HEX("5A7942"),
    mult = 8,
    base_dollars = 6,
    order = 1,
    big = {min = 1},
    active = true,
    --can spawn if at least 5 blinds with editions are in deck.
    in_pool = function(self, args)
        if G.GAME.selected_back.effect.center.config.extra and G.playing_cards then
            if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
            return math.floor(G.GAME.round/3) >= 1 and G.GAME.blindside_banana_generated  and not (G.GAME.modifiers.enable_bld_elites and G.GAME.round_resets.ante == 5) and G.GAME.modifiers.enable_bld_tough_jokers
        else
        return false
        end
    end,
   pool_override = function()
        return  G.GAME.blindside_banana_generated  and not (G.GAME.modifiers.enable_bld_elites and G.GAME.round_resets.ante == 5) and G.GAME.modifiers.enable_bld_tough_jokers
    end,
     loc_vars = function (self)
        return {
            vars = {
                math.floor(G.GAME.round/3),1,3
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                0,1,3
            }
        }
    end,
    calculate = function(self, blind, context)
        if context.setting_blind and G.GAME.modifiers.enable_bld_deplete_hands and G.GAME.current_round.hands_left > 1 then
            ease_hands_played(-1)
        end
        if context.after and not G.GAME.blind.disabled then
            G.GAME.playing_with_fire_num = G.GAME.playing_with_fire_num + 1
            G.GAME.playing_with_fire_each = G.GAME.used_vouchers.v_bld_swearjar and "bld_playing_with_fire_each_2" or "bld_playing_with_fire_each_1"
            G.GAME.playing_with_fire = G.GAME.playing_with_fire + 1 + (G.GAME.used_vouchers.v_bld_swearjar and 1 or 0)
            BLINDSIDE.chipsmodify(math.floor(G.GAME.round/3) / (BLINDSIDE.has_canvas(context) and 2 or 1), 0, 0)
        end
    end,
})
