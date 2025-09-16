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
     use = function(self, card)
        local cards = G.hand.highlighted
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            unlink_cards_and_groups(cards)
            play_sound("timpani")
            card:juice_up(0.3, 0.5)
        return true end }))
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
