BLINDSIDE.Joker({
    key = 'unik_blindside_white_lily_cookie',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=3},
    boss_colour = HEX("D9EDF0"),
    mult = 25,
    base_dollars = 16,
    order = 999999,
    boss = {min = 1,showdown = true,ancient = true},
    active = true,
    in_pool = function(self, args)
        return UNIK.hasBlindside() and CanSpawnAncient()
    end,
    loc_vars = function(self,blind)
        G.GAME.blinds_destroyed_this_run = G.GAME.blinds_destroyed_this_run or 0
        G.GAME.blinds_burned_this_run = G.GAME.blinds_burned_this_run  or 0
        G.GAME.unik_blind_e_mult = G.GAME.unik_blind_e_mult or 1
        return { vars = { G.GAME.unik_blind_e_mult, 0.02 .. "" , G.GAME.blinds_destroyed_this_run + G.GAME.blinds_burned_this_run  .. ""} }
    end,
    collection_loc_vars = function(self)
        return { vars = { 1 .. "",0.02 .. "", 0 .. ""} }
    end,
    debuff = {
        akyrs_blind_difficulty = "unik_blindside_ancient",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
    death_card = {
        card = 'j_unik_white_lily_cookie', 
        mod_card = function(self, card) --used to apply editions and/or stickers
            
        end,
        quotes = {'unik_blindside_white_lily_lose1','unik_blindside_white_lily_lose2','unik_blindside_white_lily_lose3'},
        say_times = 6,
    },
    joker_set = function ()
        G.GAME.unik_blind_e_mult  = 1
        G.GAME.unik_dynamic_text_realtime = true
        G.GAME.blinds_burned_this_run =  G.GAME.blinds_burned_this_run  or 0
        G.GAME.blinds_destroyed_this_run = G.GAME.blinds_destroyed_this_run or 0
        local cards_added = {}
        for i = 1, G.GAME.blinds_destroyed_this_run + G.GAME.blinds_burned_this_run do
            G.E_MANAGER:add_event(Event({
                delay = 0.1,
                func = function()
                    local enhancement = 'm_unik_blindside_lily'
                    local card = SMODS.create_card { set = "Base", enhancement = enhancement, area = G.discard }
                    if math.floor(i/2) ~= i then play_sound('card1') end
                    table.insert(G.playing_cards, card)
                    G.deck:emplace(card)
                    G.GAME.blind.triggered = true
                    G.GAME.blind:wiggle()
                    card.ability.added_by_white_lily = true
                    cards_added[#cards_added+1] = card
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
                delay = 0.1,
                trigger="after",
                func = function()
                    for i,v in pairs(G.playing_cards) do
                        if v.config.center.key == 'm_unik_blindside_lily' then
                            G.GAME.unik_blind_e_mult = G.GAME.unik_blind_e_mult + 0.02
                        end
                    end
                    SMODS.calculate_context({ playing_card_added = true, cards = cards_added })
                    return true
                end
            }))
        
        

    end,
    calculate = function(self, blind, context)
         if (context.after) and not G.GAME.blind.disabled then
            G.GAME.unik_dynamic_text_realtime = true
            G.GAME.unik_blind_e_mult  = 1
            for i,v in pairs(G.playing_cards) do
                if v.config.center.key == 'm_unik_blindside_lily' then
                    G.GAME.unik_blind_e_mult = G.GAME.unik_blind_e_mult + 0.02
                end
            end
            G.HUD_blind:recalculate(true)
            if G.GAME.unik_blind_e_mult  > 1 then
                UNIK.blindside_chips_modifyV2({e_mult = G.GAME.unik_blind_e_mult })   
                G.GAME.playing_with_fire_num = G.GAME.playing_with_fire_num + 1
                G.GAME.playing_with_fire_each = G.GAME.used_vouchers.v_bld_swearjar and "bld_playing_with_fire_each_3" or "bld_playing_with_fire_each_2"
                G.GAME.playing_with_fire = G.GAME.playing_with_fire + 2 + (G.GAME.used_vouchers.v_bld_swearjar and 1 or 0)
            end
           G.GAME.blind:set_text()
            
        end
    end,
    disable = function(self)
        G.GAME.unik_blind_e_mult  = 1
        for i,v in pairs(G.playing_cards) do
            if v.ability.added_by_white_lily then
                v:start_dissolve()
            end
        end
        G.GAME.unik_dynamic_text_realtime = nil
    end,
    joker_defeat = function()
        G.GAME.unik_blind_e_mult  = 1
        for i,v in pairs(G.playing_cards) do
            if v.ability.added_by_white_lily then
                v:start_dissolve()
            end
        end
        G.GAME.unik_dynamic_text_realtime = nil
    end,
})

local remove_ref = Card.remove
function Card.remove(self)
    if not G.GAME.ignore_delete_context then
        if self.ability.set == 'Enhanced' and UNIK.hasBlindside() and (not self.unik_dissolve_sell_flag) and 
        (self.area == G.hand or self.area == G.discard or self.area == G.exhaust or self.area == G.deck or self.area == G.play or tableContains(G.playing_cards,self))
        then
            G.GAME.blinds_destroyed_this_run = G.GAME.blinds_destroyed_this_run or 0
            G.GAME.blinds_destroyed_this_run = G.GAME.blinds_destroyed_this_run + 1
            SMODS.calculate_context({ unik_blind_destroyed = true, blind = self })
            --print("Destroyed: " .. G.GAME.blinds_destroyed_this_run)
            print("REMOVED!")
            if self.ability and self.ability.extra and type(self.ability.extra) == 'table' and self.ability.extra.unik_hand_size_added then
                self.ability.extra.unik_hand_size_added = nil
                print("REMOVED BY OTHER MEANS!")
                G.hand:change_size(-self.ability.extra.hand_size)
                G.GAME.bellows_hs_tracker = G.GAME.bellows_hs_tracker or 0
                G.GAME.bellows_hs_tracker =G.GAME.bellows_hs_tracker - 1
                print("hand_mod: " .. G.GAME.bellows_hs_tracker)
            end
        end
    end
    local ret = remove_ref(self)
    return ret
end