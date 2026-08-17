--scored blinds permanently lose 4 chips and add +X0.1 base chips to Joker
BLINDSIDE.Joker({
    blindside_joker = true,
    key = 'unik_blindside_chipped_joker',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=35},
    boss_colour = HEX("81CEFD"),
    mult = 8,
    base_dollars = 6,
    order = 1,
    big = {min = 3},
    active = true,
    --can spawn if at least 5 blinds with editions are in deck.
   pool_override = function()
        return  G.GAME.blindside_banana_generated  and not (G.GAME.modifiers.enable_bld_elites and G.GAME.round_resets.ante == 5) and G.GAME.modifiers.enable_bld_tough_jokers
    end,
     loc_vars = function (self)
        return {
            vars = {
                3,0.1
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                3,0.1
            }
        }
    end,
    calculate = function(self, blind, context)
        if context.setting_blind and G.GAME.modifiers.enable_bld_deplete_hands and G.GAME.current_round.hands_left > 1 then
            ease_hands_played(-1)
        end
        if context.scoring_hand and context.individual and context.cardarea == G.play then
            if tableContains(context.other_card, context.scoring_hand) and context.other_card.facing ~= 'back' then
                G.GAME.playing_with_fire_num = G.GAME.playing_with_fire_num + 1
                G.GAME.playing_with_fire_each = G.GAME.used_vouchers.v_bld_swearjar and "bld_playing_with_fire_each_2" or "bld_playing_with_fire_each_1"
                G.GAME.playing_with_fire = G.GAME.playing_with_fire + 1 + (G.GAME.used_vouchers.v_bld_swearjar and 1 or 0)
                 context.other_card.ability["perma_bonus"] = context.other_card.ability["perma_bonus"] or 0
                context.other_card.ability["perma_bonus"] = context.other_card.ability["perma_bonus"] - 3 + (BLINDSIDE.has_canvas(context) and 1 or 0)
                return {
                    message = "+X" .. 0.1 .. " " .. localize('k_unik_jchips_base'),
                    colour = G.C.BLACK,
                    focus = context.other_card,
                    func = function ()
                        UNIK.blindside_chips_modifyV2({chips_base = 0.1 - (BLINDSIDE.has_canvas(context) and 0.05 or 0)}) 
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
