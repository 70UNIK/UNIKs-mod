--want to trim excess card from a group but prerve the rest?
SMODS.Consumable{
    set = "Tarot",
   	key = "unik_excommunicated",
	pos = { x = 0, y = 2 },
	config = {  max_highlighted = 2 },
	atlas = "unik_tarots",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set = 'Other', key = 'bunc_linked_group'}

		return { vars = { card and card.ability.max_highlighted or self.config.max_highlighted } }
	end,
    	    unlocked = true,
    discovered = true,
     use = function(self, card)
        local cards = G.hand.highlighted
        for i = #cards, 1, -1 do
            if SMODS.is_eternal(cards[i],self) then
                table.remove(cards,i)
            end
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            unlink_cards(cards)
            SMODS.destroy_cards(cards)
            card:juice_up(0.3, 0.5)
        return true end }))
     end,
     update = function(self, card)
        if card.highlighted then
            if G.GAME then G.GAME.unik_excommunication = true end
        end
    end,
    in_pool = function(self)
        return hasLinks()
    end,
    set_badges = function (self, card, badges)
      SMODS.create_mod_badges({ mod = SMODS.find_mod("Bunco")[1] }, badges)
    end,
}


function hasLinks()
    for i,v in pairs(G.playing_cards) do
        if v.ability and v.ability.group then
            return true
        end
    end
    return false
end