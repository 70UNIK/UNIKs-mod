BLINDSIDE.Joker({
    blindside_joker = true,
    key = 'unik_blindside_hashtur',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=25},
    boss_colour = HEX("C0A21A"),
    mult = 27,
    base_dollars = 8,
    order = 1,
    cursed = {min = -66},
    active = true,
    in_pool = function(self, args)
        if G.GAME.selected_back.effect.center.config.extra then
            if not UNIK.hasBlindside() then return false end
            return true
        else
        return false
        end
    end,
    debuff = {
        akyrs_blind_difficulty = "unik_blindside_cursed",
    },
    disable = function(self)
    end,
    joker_defeat = function()
    end,
    calculate = function(self, blind, context)
        if context.before and context.scoring_hand and not G.GAME.blind.disabled then
            local triggered = false
             G.E_MANAGER:add_event(Event({
                        func = function()
                            for i,v in pairs(context.scoring_hand) do
                                if v:is_color('Yellow') then
                                    G.GAME.playing_with_fire_num = G.GAME.playing_with_fire_num + 1
                                    G.GAME.playing_with_fire_each = G.GAME.used_vouchers.v_bld_swearjar and "bld_playing_with_fire_each_2" or "bld_playing_with_fire_each_1"
                                    G.GAME.playing_with_fire = G.GAME.playing_with_fire + 1 + (G.GAME.used_vouchers.v_bld_swearjar and 1 or 0)
                                    triggered = true
                                    v.ability["perma_mult"] = v.ability["perma_mult"] or 0
                                    v.ability["perma_mult"] = v.ability["perma_mult"] + 2
                                    v:juice_up()
                                    
                                
                                end
                            end
                            if triggered then
                                G.GAME.blind:wiggle()
                                
                            end
                                            
                            
                            return true
                        end
                    }))
            
        end
    end,
})