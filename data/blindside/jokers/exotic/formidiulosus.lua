SMODS.Atlas({ 
    key = "unik_blindside_formidiulosus", 
    atlas_table = "ANIMATION_ATLAS", 
    path = "unik_blindside_formidiulosus.png", 
    px = 34, 
    py = 34, 
frames = 21 })

BLINDSIDE.Joker({
    key = 'unik_blindside_formidiulosus',
    atlas = 'unik_blindside_formidiulosus',
    pos = {x=0, y=0},
    boss_colour = HEX("585859"),
    mult = 66,
    base_dollars = 16,
    order = 999999,
    boss = {min = 1,showdown = true,exotic = true},
    active = true,
    in_pool = function(self, args)
        return UNIK.hasBlindside() and CanSpawnExotic()
    end,
    debuff = {
        akyrs_blind_difficulty = "unik_blindside_exotic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
    glitchy_anim = {min = 0, max = 5},
    death_card = {
        card = 'j_cry_formidiulosus' and (SMODS.Mods["Cryptid"] or {}).can_load or 'j_unik_blindside_formidiulosus_cry', 
        mod_card = function(self, card) --used to apply editions and/or stickers
            
        end,
        quotes = {'unik_blindside_formidi_lose'},
        say_times = 6,
    },
    loc_vars = function(self,blind)
        G.GAME.unik_blind_e_mult = G.GAME.unik_blind_e_mult or 1
        return { vars = { G.GAME.unik_blind_e_mult, 0.15 .. "" } }
    end,
    collection_loc_vars = function(self)
        return { vars = { 1 .. "", 0.15 .. "" } }
    end,
    calculate = function(self, blind, context)
        if not context.disabled and not G.GAME.blind.disabled then
            local crudes = 0
            for i,v in pairs(G.playing_cards) do
                if v.config.center.curse then
                    crudes = crudes + 1
                end
            end
            G.GAME.unik_blind_e_mult = 1 + crudes*0.15
        end
        
        if context.setting_blind and not context.disabled and not G.GAME.blind.disabled then
            G.GAME.unik_dynamic_text_realtime = true
            G.GAME.unik_blind_e_mult = 1
            local crudes = 0
            for i,v in pairs(G.playing_cards) do
                if v.config.center.curse then
                    crudes = crudes + 1
                end
            end
            G.GAME.unik_blind_e_mult = 1 + crudes*0.15
        end
        if (context.after) and not G.GAME.blind.disabled then
            G.GAME.unik_blind_e_mult = 1
            local crudes = 0
            for i,v in pairs(G.playing_cards) do
                if v.config.center.curse then
                    crudes = crudes + 1
                end
            end
for i = 1, #G.hand.cards do
                
                if not G.hand.cards[i].config.center.curse and not G.hand.cards[i].ability.formidi_original then
                    G.hand.cards[i].ability.formidi_original = copy3(G.hand.cards[i].ability)
                    G.hand.cards[i].ability.formidi_originaltype = G.hand.cards[i].config.center.key
                    local args = {}
                    args.guaranteed = true
                    args.options = G.P_CENTER_POOLS.bld_obj_blindcard_generate
                    args.cursed = true
                    local cardtype = BLINDSIDE.poll_enhancement(args)
                    local upgrade =G.hand.cards[i].ability.extra.upgraded
                    
                    
                    G.GAME.playing_with_fire_num = G.GAME.playing_with_fire_num + 1
                    G.GAME.playing_with_fire_each = G.GAME.used_vouchers.v_bld_swearjar and "bld_playing_with_fire_each_3" or "bld_playing_with_fire_each_2"
                    G.GAME.playing_with_fire = G.GAME.playing_with_fire + 4 + (G.GAME.used_vouchers.v_bld_swearjar and 1 or 0)
                    
                    G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.1, func = function() 
                        play_sound('cancel', 0.8+ (0.9 + 0.2*math.random())*0.2, 1)
                        G.hand.cards[i]:set_ability(cardtype)
                        G.GAME.blind:wiggle()
                    G.hand.cards[i]:juice_up()
                        if upgrade then
                            upgrade_blinds({G.hand.cards[i]}, true, true)
                        end
                    return true end })) 
                    delay(0.1)
                    crudes = crudes + 1
                end
                
            end
            for i = 1, #G.play.cards do
                if not G.play.cards[i].config.center.curse and not G.play.cards[i].ability.formidi_original then
                    G.play.cards[i].ability.formidi_original = copy3(G.play.cards[i].ability)
                    G.play.cards[i].ability.formidi_originaltype = G.play.cards[i].config.center.key
                    local args = {}
                    args.guaranteed = true
                    args.options = G.P_CENTER_POOLS.bld_obj_blindcard_generate
                    args.cursed = true
                    local cardtype = BLINDSIDE.poll_enhancement(args)
                    local upgrade =G.play.cards[i].ability.extra.upgraded
                    
                   
                    G.GAME.playing_with_fire_num = G.GAME.playing_with_fire_num + 1
                    G.GAME.playing_with_fire_each = G.GAME.used_vouchers.v_bld_swearjar and "bld_playing_with_fire_each_3" or "bld_playing_with_fire_each_2"
                    G.GAME.playing_with_fire = G.GAME.playing_with_fire + 4 + (G.GAME.used_vouchers.v_bld_swearjar and 1 or 0)
                    
                    G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.1, func = function() 
                        play_sound('cancel', 0.8+ (0.9 + 0.2*math.random())*0.2, 1)
                        G.play.cards[i]:set_ability(cardtype)
                         G.GAME.blind:wiggle()
                    G.play.cards[i]:juice_up()
                        if upgrade then
                            upgrade_blinds({G.play.cards[i]}, true, true)
                        end
                    return true end })) 
                    delay(0.1)
                    crudes = crudes + 1
                end
                
            end
            --print(crudes)
            G.GAME.unik_blind_e_mult = 1 + crudes*0.15
            G.GAME.unik_dynamic_text_realtime = true
            G.GAME.unik_blind_e_mult = G.GAME.unik_blind_e_mult or 1
            if G.GAME.unik_blind_e_mult > 1 then
                UNIK.blindside_chips_modifyV2({e_mult = G.GAME.unik_blind_e_mult})   
                G.GAME.playing_with_fire_num = G.GAME.playing_with_fire_num + 1
                G.GAME.playing_with_fire_each = G.GAME.used_vouchers.v_bld_swearjar and "bld_playing_with_fire_each_3" or "bld_playing_with_fire_each_2"
                G.GAME.playing_with_fire = G.GAME.playing_with_fire + 4 + (G.GAME.used_vouchers.v_bld_swearjar and 1 or 0)
            end
            
           
            
        end
        
    end,
    -- press_play = function(self)
        
	-- end,
    disable = function()
        for key, value in pairs(G.playing_cards) do
            if value and  value.ability and value.ability.formidi_original then
                value:set_ability(value.ability.formidi_originaltype)
                value.ability = copy3(value.ability.formidi_original)
                value.ability.formidi_original = nil
            end
        end
        G.GAME.unik_blind_e_mult = 1
        G.GAME.unik_dynamic_text_realtime = nil
    end,
    joker_defeat = function()
        for key, value in pairs(G.playing_cards) do
            if value and value.ability and value.ability.formidi_original then
                value:set_ability(value.ability.formidi_originaltype)
                value.ability = copy3(value.ability.formidi_original)
                value.ability.formidi_original = nil
            end
        end
        G.GAME.unik_blind_e_mult = 1
        G.GAME.unik_dynamic_text_realtime = nil
    end
})