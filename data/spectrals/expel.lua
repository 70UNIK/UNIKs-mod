--Banish a selected shop item, consumable or joker, bypasses eternal.
SMODS.Consumable {
    key = 'unik_expel',
    set = 'Spectral',
    atlas = 'placeholders',
    pos = { x = 2, y = 2 },
    cost = 4,
    config = {max_card = 1 },
    can_use = function(self, card)
        local shop_jokers = G.shop_jokers and G.shop_jokers.highlighted or 0
        local booster_cards = G.pack_cards and #G.pack_cards.highlighted or 0
        local consumables = G.consumeables and #G.consumeables.highlighted or 0
        local jokers = G.jokers and #G.jokers.highlighted or 0
        local boosters = G.shop_booster and #G.shop_booster.highlighted or 0
        local vouchers = G.shop_vouchers and #G.shop_vouchers.highlighted or 0
        --Exclude currently selected card
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
        if (shop_jokers + booster_cards + consumables + jokers + boosters + vouchers == 1) then
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
        local consumable = nil
        if #G.consumeables.highlighted > 1 then
            for i,v in pairs (G.consumeables.highlighted) do
                if v ~= card then
                    consumable = v
                    break
                end
            end
        end
        if G.pack_cards and #G.pack_cards.highlighted > 1 then
            for i,v in pairs (G.pack_cards.highlighted) do
                if v ~= card then
                    consumable = v
                    break
                end
            end
        end


		local c = consumable or G.shop_jokers.highlighted[1] or G.shop_booster.highlighted[1] or G.shop_vouchers.highlighted[1] or G.pack_cards.highlighted[1] or G.jokers.highlighted[1]

        --immune to this.
        if c.config.center.key == 'j_unik_megatron' or c.config.center.key == "j_paperback_white_night" 
            or (self.config.center.paperback and self.config.center.paperback.permanently_eternal)
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
            else

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
        end
    end,
}