BLINDSIDE.Joker({
    blindside_joker = true,
    key = 'unik_blindside_fruity_joker',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=18},
    boss_colour = HEX("b270c9"),
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
                if (v).edition then
                    seals = seals+ 1
                end
            end
            if seals >= 5 then
                return true
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
                2
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                2
            }
        }
    end,
    calculate = function(self, blind, context)
        if context.scoring_hand and context.full_hand and context.poker_hands and G.STATE == G.STATES.SELECTING_HAND and not G.GAME.blind.disabled then
            local triggered = false
            for i,v in pairs(context.full_hand) do
                if v.edition then
                    triggered = true
                    break
                end
            end
            if triggered then
                BLINDSIDE.alert_debuff(self, true, localize('k_unik_edition_warning'))
            else
                BLINDSIDE.alert_debuff(self, false)
            end
        end

        if context.pre_discard or context.before then
            BLINDSIDE.alert_debuff(self, false)
        end
        if context.scoring_hand and context.individual and context.cardarea == G.play and not G.GAME.blind.disabled then
            if tableContains(context.other_card, context.scoring_hand) and (context.other_card).edition  and context.other_card.facing ~= 'back' then
                return {
                    message = "+" .. 2 .. localize('k_unik_jmult'),
                    colour = G.C.BLACK,
                    focus = context.other_card,
                    func = function ()
                        G.GAME.playing_with_fire_num = G.GAME.playing_with_fire_num + 1
                        G.GAME.playing_with_fire_each = G.GAME.used_vouchers.v_bld_swearjar and "bld_playing_with_fire_each_3" or "bld_playing_with_fire_each_2"
                        G.GAME.playing_with_fire = G.GAME.playing_with_fire + 2 + (G.GAME.used_vouchers.v_bld_swearjar and 1 or 0)
                         BLINDSIDE.chipsmodify(2, 0, 0)
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
