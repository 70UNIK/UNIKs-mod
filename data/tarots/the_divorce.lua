--Bunco exclusive tarot, removes a linked group.
--tarot for better accessibility.
SMODS.Consumable{
    set = "Tarot",
   	key = "unik_divorce",
	pos = { x = 2, y = 5 },
	atlas = "unik_consumables",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set = 'Other', key = 'bunc_linked_group'}
	end,
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(
			G.localization.misc.dictionary.bunc_mysterious_tarot,
			get_type_colour(self or card.config, card),
			nil,
			1.2
		)
	end,
    	    unlocked = true,
    discovered = true,
    attributes = {'bunc_linked','modify_card'},
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
