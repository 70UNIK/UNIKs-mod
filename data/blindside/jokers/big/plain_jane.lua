--+2 Mult whenever an untrimmed blind is scored
BLINDSIDE.Joker({
    blindside_joker = true,
    key = 'unik_blindside_plain_jane',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=19},
    boss_colour = HEX("dcdcdc"),
    mult = 8,
    base_dollars = 6,
    order = 1,
    big = {min = 1},
    active = true,
    --can spawn if at least 5 blinds with editions are in deck.
    in_pool = function(self, args)
        if G.GAME.selected_back.effect.center.config.extra and G.playing_cards then
            if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
            local seals = 0
            for i,v in pairs(G.playing_cards) do
                if (v).seal then
                    seals = seals+ 1
                end
            end
            if seals >= 5 then
                return G.GAME.blindside_banana_generated  and not (G.GAME.modifiers.enable_bld_elites and G.GAME.round_resets.ante == 5) and G.GAME.modifiers.enable_bld_tough_jokers
            end
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
                1
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                1
            }
        }
    end,
    calculate = function(self, blind, context)
        if context.setting_blind and G.GAME.modifiers.enable_bld_deplete_hands and G.GAME.current_round.hands_left > 1 then
            ease_hands_played(-1)
        end
        if context.scoring_hand and context.full_hand and context.poker_hands and G.STATE == G.STATES.SELECTING_HAND and not G.GAME.blind.disabled then
            local triggered = false
            for i,v in pairs(context.full_hand) do
                if not v.seal then
                    triggered = true
                    break
                end
            end
            if triggered then
                BLINDSIDE.alert_debuff(self, true, localize('k_unik_trim_warning'))
            else
                BLINDSIDE.alert_debuff(self, false)
            end
        end

        if context.pre_discard or context.before then
            BLINDSIDE.alert_debuff(self, false)
        end
        if context.scoring_hand and context.individual and context.cardarea == G.play and not G.GAME.blind.disabled then
            if tableContains(context.other_card, context.scoring_hand) and not (context.other_card).seal  and context.other_card.facing ~= 'back' then
                return {
                    message = "+" .. 1 .. localize('k_unik_jmult'),
                    colour = G.C.BLACK,
                    focus = context.other_card,
                    func = function ()
                        BLINDSIDE.change_fire_amount({amount = 1})
                        BLINDSIDE.add_fire()
                         BLINDSIDE.chipsmodify(1 - (BLINDSIDE.has_canvas(context) and 0.5 or 0), 0, 0)
                        G.E_MANAGER:add_event(Event({
                            func = (function()
                            G.GAME.blind:wiggle()
                            return true
                            end)
                        }))
                        G.E_MANAGER:add_event(Event({
                            trigger = 'before',
                            delay = 0.8,
                            func = function ()
                                return true
                            end
                        }))
                    end
                }
            end
        end
    end,
})
