BLINDSIDE.Joker({
    key = 'unik_blindside_whitenight',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=29},
    boss_colour = HEX('ffaca3'),
    mult = 16,
    base_dollars = 10,
    boss = {min = 1, showdown = true},
    order = 22,
    active = true,
    in_pool = function(self, args)
        if G.GAME.selected_back.effect.center.config.extra then
            if not G.GAME.selected_back.effect.center.config.extra.blindside and G.GAME.round_resets.ante%6 == 0 then return false end
            return true
        else
        return false
        end
    end,
    death_card = {
        card = (next(SMODS.find_mod("paperback")) and 'j_bunc_fiendish') or 'j_unik_blindside_whitenight_paperback', 
        mod_card = function(self, card) --used to apply editions and/or stickers
            
        end,
        quotes = {'unik_blindside_whitenight_lose'},
    },
    calculate = function(self, blind, context)
        if context.before and context.scoring_hand and not G.GAME.blind.disabled then
            local has_apostle = false
            for i,v in pairs(context.scoring_hand) do
                if v.config.center.key == 'm_unik_blindside_apostle' then
                    has_apostle = true
                    break
                end
            end
            if not has_apostle then
                
                G.GAME.playing_with_fire_num = G.GAME.playing_with_fire_num + 1
                G.GAME.playing_with_fire_each = G.GAME.used_vouchers.v_bld_swearjar and "bld_playing_with_fire_each_2" or "bld_playing_with_fire_each_1"
                G.GAME.playing_with_fire = G.GAME.playing_with_fire + 1 + (G.GAME.used_vouchers.v_bld_swearjar and 1 or 0)
                local cards = {}
                for i,v in pairs(G.jokers.cards) do
                    v.debuff = nil
                    cards[#cards+1] = v
                end
                blind:wiggle()
                --print(cards)
                if #cards > 0 then
                    local neck_banish = pseudorandom_element(cards, pseudoseed("unik_whitenight"))
                    neck_banish:gore6_break()
                    neck_banish.debuff = true
                    if not G.GAME.banned_keys then
                    G.GAME.banned_keys = {}
                    end
                    if not G.GAME.cry_banished_keys then
                        G.GAME.cry_banished_keys = {}
                    end
                    G.GAME.cry_banished_keys[neck_banish.config.center.key] = true
                    G.GAME.playing_with_fire_num = G.GAME.playing_with_fire_num + 1
                    G.GAME.playing_with_fire_each = G.GAME.used_vouchers.v_bld_swearjar and "bld_playing_with_fire_each_2" or "bld_playing_with_fire_each_1"
                    G.GAME.playing_with_fire = G.GAME.playing_with_fire + 1 + (G.GAME.used_vouchers.v_bld_swearjar and 1 or 0)
                    
                        
                else
                    for i,v in pairs(G.play.cards) do
                        v.config.center.blind_debuff(v, true)
                        
                    end
                end
            end
        end
        if context.after then
            for i,v in pairs(G.jokers.cards) do
                v.debuff = nil
            end
        end
    end,
    joker_set = function ()
        local cards_added = {}
        for i = 1, 12 do
            G.E_MANAGER:add_event(Event({
                delay = 0.1,
                func = function()
                    local enhancement = 'm_unik_blindside_apostle'
                    local card = SMODS.create_card { set = "Base", enhancement = enhancement, area = G.discard }
                    if math.floor(i/2) ~= i then play_sound('card1') end
                    table.insert(G.playing_cards, card)
                    G.deck:emplace(card)
                    G.GAME.blind.triggered = true
                    G.GAME.blind:wiggle()
                    card.ability.added_by_whitenight = true
                    cards_added[#cards_added+1] = card
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
                delay = 0.1,
                trigger="after",
                func = function()
                    SMODS.calculate_context({ playing_card_added = true, cards = cards_added })
                    return true
                end
            }))
    end,
    
     disable = function(self)
        G.GAME.unik_blind_e_mult  = 1
        for i,v in pairs(G.playing_cards) do
            if v.ability.added_by_whitenight then
                v:start_dissolve()
            end
        end
        G.GAME.unik_dynamic_text_realtime = nil
    end,
    joker_defeat = function()
        G.GAME.unik_blind_e_mult  = 1
        for i,v in pairs(G.playing_cards) do
            if v.ability.added_by_whitenight then
                v:start_dissolve()
            end
        end
        G.GAME.unik_dynamic_text_realtime = nil
    end,
})