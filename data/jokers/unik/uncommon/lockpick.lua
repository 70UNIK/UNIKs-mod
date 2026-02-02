--Always negative
--You can sell eternal jokers.
--Self destructs after selling an eternal joker
SMODS.Joker {
    key = 'unik_lockpick',
    atlas = 'unik_uncommon',
    rarity = 2,
	pos = { x = 4, y = 1 },
    cost = 5,
    blueprint_compat = false,
    perishable_compat = true,
	eternal_compat = false,
    calculate = function(self, card, context)
        if
			context.selling_card and not context.blueprint
		then
			if SMODS.is_eternal(context.card,self) then
                --explode if  trying to sell megatron or whitenight
                if context.card.config.center.key == 'j_unik_megatron' or context.card.config.center.key == "j_paperback_white_night" 
                or (card.config.center.paperback and card.config.center.paperback.permanently_eternal) or card.ability.unik_taw
                then
                    if not G.GAME.banned_keys then
                    G.GAME.banned_keys = {}
                    end
                    if not G.GAME.cry_banished_keys then
                        G.GAME.cry_banished_keys = {}
                    end
                    G.GAME.cry_banished_keys[card.config.center.key] = true
                    card.ability.destroyed_by_megatron = true
                    G.E_MANAGER:add_event(Event({
                        trigger="immediate",
                        func = function()
                        
                        card:gore6_break()
                    return true end }))
                else
                    context.card.sell_cost = -context.card.sell_cost
                    if not G.GAME.banned_keys then
                        G.GAME.banned_keys = {}
                    end
                    if not G.GAME.cry_banished_keys then
                        G.GAME.cry_banished_keys = {}
                    end
                    G.GAME.cry_banished_keys[context.card.config.center.key] = true
                end
            end
		end
    end,
    in_pool = function(self)
        for i,v in pairs(G.jokers.cards) do 
            if v.ability.eternal then
                return true
            end
        end
		if G.GAME.modifiers.enable_eternals_in_shop then
			return true
		end
		return false
	end,
	loc_vars = function(self, info_queue, center)
		-- return { vars = {
		-- 	 center.ability.extra.cash_loss
		-- } }
        if not SMODS.is_eternal(center,self) then
            info_queue[#info_queue + 1] = { set = "Other", key = "eternal" }
        end
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_banishing" }
	end,
}

local sellingHook = Card.sell_card
function Card:sell_card()
    if (self.config.center.key == "j_unik_megatron" or self.config.center.key == "j_paperback_white_night") and SMODS.is_eternal(self,self) or 
    (self.config.center.paperback and self.config.center.paperback.permanently_eternal)
    then
        
    else
        sellingHook(self)
    end
    
end