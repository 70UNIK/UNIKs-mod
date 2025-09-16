--want to trim excess card from a group but prerve the rest?
SMODS.Consumable{
    set = "Tarot",
   	key = "unik_excommunicated",
	pos = { x = 1, y = 2 },
	config = {  max_highlighted = 2 },
	atlas = "placeholders",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set = 'Other', key = 'bunc_linked_group'}

		return { vars = { card and card.ability.max_highlighted or self.config.max_highlighted } }
	end,
    	    unlocked = true,
    discovered = true,
     use = function(self, card)
        local cards = G.hand.highlighted
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
        if G.GAME.last_card_group then
            return true
        end
        return false
    end,
    set_badges = function (self, card, badges)
      SMODS.create_mod_badges({ mod = SMODS.find_mod("Bunco")[1] }, badges)
    end,
}

--Ban discarding while selecting excommunicaiton
local excommunicationHighlight = G.FUNCS.can_discard
G.FUNCS.can_discard = function(e)
    if G.GAME.unik_excommunication then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        excommunicationHighlight(e)
    end
end