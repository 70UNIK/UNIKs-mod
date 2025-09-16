SMODS.Consumable{ -- The 8
    set = 'Polymino', 
    atlas = 'unik_polyminos',
    key = 'unik_the_triple',
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'bunc_linked_group'}
    end,
    config = {
		max_highlighted = 3
	},
    can_use = function(self, card)
        local cards = G.hand.highlighted
        -- Group check:
        for i = 1, #cards do
            if cards[i].ability.group then return false end
        end
        if #cards > 1 and cards <= card.ability.max_highlighted then
            return true
        end
        return false
    end,
    use = function(self, card)
        link_cards(G.hand.highlighted, self.key)
        card:juice_up(0.3, 0.5)
    end,
    pos = {x = 0, y = 0,}
}