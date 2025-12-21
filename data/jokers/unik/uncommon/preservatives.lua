--remove all perishable stickers on all jokers, perishables become eternal (when possible)
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_preservatives',
    atlas = 'unik_uncommon',
    rarity = 2,
	pos = { x = 2, y = 3 },
    cost = 5,
	blueprint_compat = false, --nope!
    perishable_compat = true,
	eternal_compat = true,
    in_pool = function(self)
        for i,v in pairs(G.jokers.cards) do 
            if v.ability.perishable then
                return true
            end
        end
		if G.GAME.modifiers.enable_perishables_in_shop then
			return true
		end
		return false
	end,
    config = {extra = {jokers = 6} },
    loc_vars = function(self, info_queue,card)
        info_queue[#info_queue + 1] = {key = 'perishable', set = 'Other', vars = {G.GAME.perishable_rounds or 1, G.GAME.perishable_rounds or G.GAME.perishable_rounds}}
        return {vars = {card.ability.extra.jokers }}
    end,
    pools = { ["Food"] = true},
    update = function(self,card,dt)
        if card.added_to_deck and G.jokers and G.playing_cards and G.consumeables then
             for i,v in pairs(G.jokers.cards) do
                if v.ability and v.ability.perishable then
                    v.ability.perishable = nil
                    v.debuff = false
                    card.ability.extra.jokers = card.ability.extra.jokers - 1
                    if (card.ability.extra.jokers <= 0) then
                        selfDestruction(card,'k_eaten_ex',G.C.PERISHABLE)
                    else
                         card_eval_status_text(card, 'extra', nil, nil, nil, { 
                        message = "" .. card.ability.extra.jokers,
                            colour = G.C.PERISHABLE,
                            card = card
                        })
                    end
                    
                end
            end
            -- for i,v in pairs(G.playing_cards) do
            --     if v.ability and v.ability.perishable then
            --         v.ability.perishable = nil
            --         v.ability.eternal = true
            --     end
            -- end
            -- for i,v in pairs(G.consumeables.cards) do
            --     if v.ability and v.ability.rental then
            --         v.ability.perishable = nil
            --         v.ability.eternal = true
            --     end
            -- end
        end
       
    end
}