--Gains +#1# Mult after hand, increase this by +2 for every 3 rounds
BLINDSIDE.Joker({
    blindside_joker = true,
    key = 'unik_blindside_game_brothers',
    get_assist = function(self)
        return G.P_BLINDS["bl_unik_blindside_game_brothers2"]
    end,
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=34},
    boss_colour = HEX("5A7942"),
    mult = 10,
    base_dollars = 12,
    order = 1,
    big = {min = -66},
    active = true,
    --can spawn if at least 5 blinds with editions are in deck.
    in_pool = function(self, args)
        if G.GAME.selected_back.effect.center.config.extra and G.playing_cards then
            if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
            return math.floor(G.GAME.round*2/3) >= 1 and (G.GAME.modifiers.enable_bld_elites and G.GAME.round_resets.ante == 5) or G.GAME.round_resets.ante > 7
        else
        return false
        end
    end,
   pool_override = function()
        return  (G.GAME.modifiers.enable_bld_elites and G.GAME.round_resets.ante == 5) or G.GAME.round_resets.ante > 7
    end,
     loc_vars = function (self)
        return {
            vars = {
                math.floor(G.GAME.round*2/3),2,3
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                0,2,3
            }
        }
    end,
    calculate = function(self, blind, context)
        if context.setting_blind and G.GAME.modifiers.enable_bld_deplete_hands and G.GAME.current_round.hands_left > 1 then
            ease_hands_played(-1)
        end
        if context.after and not G.GAME.blind.disabled then
            BLINDSIDE.change_fire_amount({amount = 3})
            BLINDSIDE.add_fire()
            BLINDSIDE.chipsmodify(math.floor(G.GAME.round*2/3) / (BLINDSIDE.has_canvas(context) and 2 or 1), 0, 0)
        end
    end,
})

BLINDSIDE.Joker({
    key = 'unik_blindside_game_brothers2',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=34},
    boss_colour = HEX("5A7942"),
    mult = 10,
    base_dollars = 12,
    order = 1,
    big = {min = -66},
    active = true,
    is_assistant = true,
     loc_vars = function (self)
        return {
            vars = {
                math.floor(G.GAME.round*2/3),2,3
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                0,2,3
            }
        }
    end,
})
