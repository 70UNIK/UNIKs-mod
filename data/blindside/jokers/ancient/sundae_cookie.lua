--literally Niko but only purple blinds
--OR: niko but cannot play red, yellow or faded blinds (Exclusionary, so no wild blinds)
BLINDSIDE.Joker({
    key = 'unik_blindside_sundae_cookie',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=4},
    boss_colour = HEX("991A79"),
    mult = 16,
    base_dollars = 16,
    order = 999999,
    boss = {min = 1,showdown = true,ancient = true},
    active = true,
    in_pool = function(self, args)
        return UNIK.hasBlindside() and CanSpawnAncient()
    end,
    loc_vars = function(self,blind)
        G.GAME.unik_blind_xmult = G.GAME.unik_blind_xmult or 2
        return { vars = { G.GAME.unik_blind_xmult } }
    end,
    collection_loc_vars = function(self)
        return { vars = { 2 } }
    end,
    get_loc_debuff_text = function(self)
        return localize("k_unik_all_purple")
		
	end,
    debuff = {
        akyrs_blind_difficulty = "unik_blindside_ancient",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
    death_card = {
        card = 'j_unik_sundae_cookie', 
        mod_card = function(self, card) --used to apply editions and/or stickers
            
        end,
        quotes = {'unik_blindside_sundae_lose1','unik_blindside_sundae_lose2'},
        say_times = 6,
    },
    calculate = function(self, blind, context)
        if context.setting_blind and not context.disabled and not G.GAME.blind.disabled then
            G.GAME.unik_blind_xmult = 2
            G.GAME.unik_dynamic_text_realtime = true
        end
        if context.scoring_hand and context.individual and context.cardarea == G.play and not G.GAME.blind.disabled then
            if context.other_card:is_color('Purple') and context.other_card.facing ~= 'back' then
                return {
                    message = "X" ..  G.GAME.unik_blind_xmult .. localize('k_unik_jmult'),
                    colour = G.C.BLACK,
                    focus = context.other_card,
                    func = function ()
                        G.GAME.unik_blind_xmult = G.GAME.unik_blind_xmult * 2
                        G.HUD_blind:recalculate(true)
                        BLINDSIDE.chipsmodifyV2({x_mult = G.GAME.unik_blind_xmult})  
                        G.GAME.playing_with_fire_num = G.GAME.playing_with_fire_num + 1
                        G.GAME.playing_with_fire_each = G.GAME.used_vouchers.v_bld_swearjar and "bld_playing_with_fire_each_3" or "bld_playing_with_fire_each_2"
                        G.GAME.playing_with_fire = G.GAME.playing_with_fire + 4 + (G.GAME.used_vouchers.v_bld_swearjar and 1 or 0)
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
    debuff_hand = function(self, cards, hand, handname, check)
        for i,v in pairs(cards) do
            if not v:is_color('Purple') then
                return true
            end
        end
        return false
    end,
    disable = function(self)
        G.GAME.unik_blind_xmult = 1
        G.GAME.unik_dynamic_text_realtime = nil
    end,
    joker_defeat = function()
        G.GAME.unik_blind_xmult = 1
        G.GAME.unik_dynamic_text_realtime = nil
    end
})
