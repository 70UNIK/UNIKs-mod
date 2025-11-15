--All rental stickers are removed from owned Jokers. Lose $3 per rental sticker removed.
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_tax_haven',
    atlas = 'unik_uncommon',
    rarity = 2,
	pos = { x = 0, y = 2 },
    cost = 5,
	blueprint_compat = false,
    perishable_compat = true,
	eternal_compat = true,
    config = { extra = {cash_loss = 3} },
    in_pool = function(self)
        for i,v in pairs(G.jokers.cards) do 
            if v.ability.rental then
                return true
            end
        end
		if G.GAME.modifiers.enable_rentals_in_shop then
			return true
		end
		return false
	end,
	loc_vars = function(self, info_queue, center)
		-- return { vars = {
		-- 	 center.ability.extra.cash_loss
		-- } }
        if not center.ability.rental then
            info_queue[#info_queue + 1] = { set = "Other", key = "rental" }
        end
	end,
    update = function(self,card,dt)
        if card.added_to_deck and G.jokers and G.playing_cards and G.consumeables then
             for i,v in pairs(G.jokers.cards) do
                if v.ability and v.ability.rental then
                    v.ability.rental = nil
                    ease_dollars(-card.ability.extra.cash_loss)
                end
            end
            for i,v in pairs(G.playing_cards) do
                if v.ability and v.ability.rental then
                    v.ability.rental = nil
                    ease_dollars(-card.ability.extra.cash_loss)
                end
            end
            for i,v in pairs(G.consumeables.cards) do
                if v.ability and v.ability.rental then
                    v.ability.rental = nil
                    ease_dollars(-card.ability.extra.cash_loss)
                    
                end
            end
        end
       
    end
}