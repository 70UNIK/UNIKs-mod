--literally ://delete or expel
SMODS.Consumable {
    key = 'unik_blindside_kill',
    set = 'bld_obj_ritual',
    atlas = 'placeholders',
	pos = { x = 2, y = 1 },
    cost = 4,
    config = {max_card = 1 },
    loc_vars = function(self, info_queue, center)
            info_queue[#info_queue + 1] = { set = "Other", key = "unik_banishing" }
    end,
    can_use = function(self, card)
        local shop_jokers = G.shop_jokers and #G.shop_jokers.highlighted or 0
        local booster_cards = G.pack_cards and #G.pack_cards.highlighted or 0
        local consumables = G.consumeables and #G.consumeables.highlighted or 0
        local jokers = G.jokers and #G.jokers.highlighted or 0
        local boosters = G.shop_booster and #G.shop_booster.highlighted or 0
        local vouchers = G.shop_vouchers and #G.shop_vouchers.highlighted or 0
        local cards = G.hand and G.hand.highlighted and #G.hand.highlighted or 0
        --Exclude currently selected card
        if G.hand then
            for i,v in pairs(G.hand.highlighted) do
                if v == card then
                    cards = cards - 1
                    break
                end
            end
        end
        if G.consumeables then
            for i,v in pairs(G.consumeables.highlighted) do
                if v == card then
                    consumables = consumables - 1
                    break
                end
            end
        end
        if G.pack_cards then
            for i,v in pairs(G.pack_cards.highlighted) do
                if v == card then
                    booster_cards = booster_cards - 1
                    break
                end
            end
        end
        if G.shop_jokers then
          for i,v in pairs(G.shop_jokers.highlighted ) do
                if v == card then
                    shop_jokers = shop_jokers - 1
                    break
                end
            end
        end
        --weird edge scenarios such as in the voucher or a booster slot
        if G.shop_booster then
          for i,v in pairs(G.shop_booster.highlighted) do
                if v == card then
                    boosters = boosters - 1
                    break
                end
            end
        end
        if G.shop_vouchers then
          for i,v in pairs(G.shop_vouchers.highlighted) do
                if v == card then
                    vouchers = vouchers - 1
                    break
                end
            end
        end
        if (shop_jokers + booster_cards + consumables + jokers + boosters + vouchers + cards == 1) then
            return true
        end
        return false
    end,
    use = function(self, card, area, copier)
       
        
        
         if not G.GAME.cry_banned_pcards then
			G.GAME.cry_banned_pcards = {}
		end
        if not G.GAME.banned_keys then
            G.GAME.banned_keys = {}
            end
        local c = nil
        --Exclude currently selected card
        if G.hand and #G.hand.highlighted >= 1 then
            for i,v in pairs(G.hand.highlighted) do
                if v ~= card then
                    c = v
                    break
                end
            end
        end
        if G.consumeables and #G.consumeables.highlighted >= 1 then
            for i,v in pairs (G.consumeables.highlighted) do
                if v ~= card then
                    c = v
                    --print(c.config.center.key)
                    break
                end
                --print(v.config.center.key)
            end
        end
        if G.pack_cards and #G.pack_cards.highlighted >= 1 then
            for i,v in pairs (G.pack_cards.highlighted) do
                if v ~= card then
                    c = v
                    --print(c.config.center.key)
                    break
                end
                --print(v.config.center.key)
            end
        end
        --weird edge scenario
        if G.shop_jokers and #G.shop_jokers.highlighted >= 1 then
            for i,v in pairs (G.shop_jokers.highlighted) do
                if v ~= card then
                    c = v
                    --print(c.config.center.key)
                    break
                end
                --print(v.config.center.key)
            end
        end
        if G.shop_booster and #G.shop_booster.highlighted >= 1 then
            for i,v in pairs (G.shop_booster.highlighted) do
                if v ~= card then
                    c = v
                    --print(c.config.center.key)
                    break
                end
                --print(v.config.center.key)
            end
        end
        if G.shop_vouchers and #G.shop_vouchers.highlighted >= 1 then
            for i,v in pairs (G.shop_vouchers.highlighted) do
                if v ~= card then
                    c = v
                    --print(c.config.center.key)
                     if c.shop_voucher and G.GAME.selected_back.effect.center.config.extra and G.GAME.selected_back.effect.center.config.extra.blindside then 
                    G.GAME.current_round.voucher = SMODS.get_next_vouchers()
                    G.GAME.round_resets.tags_bought = G.GAME.round_resets.tags_bought + 1
                    for _, key in ipairs(G.GAME.current_round.voucher or {}) do
                        if G.P_CENTERS[key] and G.GAME.current_round.voucher.spawn[key] then
                            SMODS.add_voucher_to_shop(key)
                            G.shop_vouchers.cards[1].cost = math.max(G.shop_vouchers.cards[1].cost + 5*G.GAME.round_resets.tags_bought - (G.GAME.used_vouchers['v_bld_treasurechest'] and 20 or 0), 0)
                        end
                    end
                end
                    break
                end
                --print(v.config.center.key)
            end
           
        end
        -- c = G.shop_jokers and G.shop_jokers.highlighted[1] or c
        -- c = G.shop_booster and G.shop_booster.highlighted[1] or c
        -- c = G.shop_vouchers and  G.shop_vouchers.highlighted[1] or c


        c = G.jokers and G.jokers.highlighted[1] or c
        if c then
            G.GAME.current_round.trinket.spawn[c.config.center_key] = false
        end
        
        if c and c ~= nil and (c.config.center.key == 'j_unik_megatron' or c.config.center.key == "j_paperback_white_night" 
            or (c.config and c.config.center and c.config.center.paperback and c.config.center.paperback.permanently_eternal) or c.ability.unik_taw)
            then
                if not G.GAME.banned_keys then
                G.GAME.banned_keys = {}
                end
                if not G.GAME.cry_banished_keys then
                    G.GAME.cry_banished_keys = {}
                end
                G.GAME.cry_banished_keys[card.config.center.key] = true
                G.E_MANAGER:add_event(Event({
                    trigger="immediate",
                    func = function()
                    
                    card:gore6_break()
                return true end }))
        elseif c and c ~= nil then
             G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()

            if  G.shop_vouchers and G.shop_vouchers.highlighted[1] and c.shop_voucher then
                G.GAME.current_round.voucher.spawn[c.config.center.key] = nil
            end
            if not G.GAME.cry_banished_keys then
                G.GAME.cry_banished_keys = {}
            end
            G.GAME.cry_banished_keys[c.config.center.key] = true

            if not not c.base.value then -- is there a case where ~= nil would fail here?
                for k, v in pairs(G.P_CARDS) do
                    -- bans a specific rank AND suit
                    if v.value == c.base.value and v.suit == c.base.suit then
                        G.GAME.cry_banned_pcards[k] = true
                    end
                end
            end
            c:gore6_break()
            return true end })) 
        else
            error("No item found! Either it is trying to destroy an item in an unrecognized card area or its just programmed wrong...")
        end
    end,
}

-- fallback blinds if blinds have been banished out of existence:
--starter: the blank
--simple: the hat
--premium: the wall
--crude; AI SLOP!!!
--legenary: violet vessel
--ancient: epic wall

UNIK.backup_blindside_rarities = {
    [3] = 'm_unik_blindside_ai_brainrot',
    [0] = 'm_bld_hat',
    [1] = 'm_bld_air',
    [4] = 'm_bld_violet_vessel',
    [2] = 'm_bld_blank',
    [-1] = 'm_bld_blank',
}

-- local poller =  BLINDSIDE.poll_enhancement
-- function BLINDSIDE.poll_enhancement(args)
--     local ret = poller(args)
--     local rarity = 0
--     if not ret then
--         if args.shop then
--             if G.GAME.modifiers.enable_shop_curses and pseudorandom(pseudoseed('bld_blind_curse_in_shop')) > 0.9 then
--                 rarity = 3
--             else
--                 if (rand < 0.85) then
--                     rarity = 0
--                 elseif rand <= 1 then --(rand < 0.999) then
--                     rarity = 1
--                 else
--                     rarity = 2
--                 end
--             end
--         elseif args.cursed then
--             rarity = 3
--         elseif args.unik_ancient then
--             rarity = 70
--         elseif args.unik_exotic then
--             rarity = 99
--         elseif args.legendary then
--             rarity = 4
--         else
--             if (rand < 0.85) then
--             rarity = 0
--             elseif rand <= 1 then --(rand < 0.999) then
--                 rarity = 1
--             else
--                 rarity = 2
--             end
--         end
--     end
-- end
