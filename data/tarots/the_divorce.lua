--Bunco exclusive tarot, removes a linked group.
--tarot for better accessibility.
SMODS.Consumable{
    set = "Tarot",
   	key = "unik_divorce",
	pos = { x = 1, y = 2 },
	atlas = "placeholders",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set = 'Other', key = 'bunc_linked_group'}
	end,
    	    unlocked = true,
    discovered = true,
     use = function(self, card)
        local cards = G.hand.highlighted
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            unlink_cards_and_groups(cards)
            play_sound("timpani")
            card:juice_up(0.3, 0.5)
        return true end }))
     end,
    update = function(self, card)
        if card.highlighted then
            if G.GAME then G.GAME.unik_excommunication = true end
        end
    end,
     can_use = function(self, card)
        if G.hand then
            local cards = G.hand.highlighted
            -- Group check:
            for i = 1, #cards do
                if cards[i].ability.group then return true end
            end
        end
        return false
    end,
    in_pool = function(self)
        return hasLinks()
    end,
        set_badges = function (self, card, badges)
      SMODS.create_mod_badges({ mod = SMODS.find_mod("Bunco")[1] }, badges)
    end,
}
