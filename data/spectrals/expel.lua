--Banish a selected shop item, consumable or joker, bypasses eternal.
SMODS.Consumable {
    key = 'unik_expel',
    set = 'Spectral',
	atlas = "unik_spectrals",
    pos = { x = 2, y = 0 },
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
        local c = nil
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
        c = G.shop_jokers and G.shop_jokers.highlighted[1] or c
        c = G.shop_booster and G.shop_booster.highlighted[1] or c
        c = G.shop_vouchers and  G.shop_vouchers.highlighted[1] or c
        c = G.jokers and G.jokers.highlighted[1] or c
        if c and c ~= nil and (c.config.center.key == 'j_unik_megatron' or c.config.center.key == "j_paperback_white_night" 
            or (c.config and c.config.center and c.config.center.paperback and c.config.center.paperback.permanently_eternal))
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
            error("No item found!")
        end
    end,
}

  -- special thanks to John Cryptid for this
  -- and Betmma, apparently
  G.FUNCS.can_reserve_card2 = function(e)
    if #G.consumeables.cards < G.consumeables.config.card_limit then
      e.config.colour = G.C.GREEN
      e.config.button = "reserve_card2"
    else
      e.config.colour = G.C.UI.BACKGROUND_INACTIVE
      e.config.button = nil
    end
  end
  G.FUNCS.reserve_card2 = function(e)
    local c1 = e.config.ref_table
    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.1,
      func = function()
        c1.area:remove_card(c1)
        c1:add_to_deck()
        if c1.children.price then
          c1.children.price:remove()
        end
        c1.children.price = nil
        if c1.children.buy_button then
          c1.children.buy_button:remove()
        end
        c1.children.buy_button = nil
        remove_nils(c1.children)
        G.consumeables:emplace(c1)
        G.GAME.pack_choices = G.GAME.pack_choices - 1
        if G.GAME.pack_choices <= 0 then
          G.FUNCS.end_consumeable(nil, delay_fac)
        end
        return true
      end,
    }))
  end

local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
  function G.UIDEF.use_and_sell_buttons(card)
    if (card.area == G.pack_cards and G.pack_cards) and card.ability.consumeable then --Add a use button
      if card.config.center.key == 'c_unik_expel' then
        return {
          n = G.UIT.ROOT,
          config = { padding = -0.1, colour = G.C.CLEAR },
          nodes = {
            {
              n = G.UIT.R,
              config = {
                ref_table = card,
                r = 0.08,
                padding = 0.1,
                align = "bm",
                minw = 0.5 * card.T.w - 0.15,
                minh = 0.7 * card.T.h,
                maxw = 0.7 * card.T.w - 0.15,
                hover = true,
                shadow = true,
                colour = G.C.UI.BACKGROUND_INACTIVE,
                one_press = true,
                button = "use_card",
                func = "can_reserve_card2",
              },
              nodes = {
                {
                  n = G.UIT.T,
                  config = {
                    text = localize("b_take"),
                    colour = G.C.UI.TEXT_LIGHT,
                    scale = 0.55,
                    shadow = true,
                  },
                },
              },
            },
          },
        }
      end
    end
    return G_UIDEF_use_and_sell_buttons_ref(card)
  end