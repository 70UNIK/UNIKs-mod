--Adds a linked group to the card on the left, a la death
SMODS.Consumable{
    set = "Tarot",
   	key = "unik_chains",
	pos = { x = 1, y = 2 },
	atlas = "placeholders",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set = 'Other', key = 'bunc_linked_group'}
	end,
    config = {
        max_highlighted = 2,
    },
    use = function(self, card)
        local cards = UNIK.get_sorted_by_position(G.hand)
        local rightmostCard = cards[#cards]
        local id = nil
        local source = nil
        if rightmostCard.ability and rightmostCard.ability.group then
            id = rightmostCard.ability.group.id
            source = rightmostCard.ability.group.source
        end
        if #cards > 1 and id and source then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                for i=1, #cards do
                    local percent = 1.15 - (i-0.999)/(#cards-0.998)*0.3
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() cards[i]:flip();play_sound('card1', percent);cards[i]:juice_up(0.3, 0.3);return true end }))
                end
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
                    for i = 1, #cards do
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
                            cards[i].ability.group = {id = id, source = source or 'unknown'}
                        return true end }))
                    end
                    for i=1, #cards do
                        local percent = 0.85 + (i-0.999)/(#cards-0.998)*0.3
                        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() cards[i]:flip();play_sound('tarot2', percent, 0.6);cards[i]:juice_up(0.3, 0.3);return true end }))
                    end
                    card:juice_up(0.3, 0.5)
                return true end })) 
            return true end })) 
        end
    end,
    in_pool = function(self)
        if G.GAME.last_card_group then
            return true
        end
        return false
    end,
     update = function(self, card)
        if card.highlighted then
            if G.GAME then G.GAME.unik_excommunication = true end
        end
    end,
    --rightmost card must be a linked group
    can_use = function(self, card)
        local cards = UNIK.get_sorted_by_position(G.hand)
        local rightmostCard = cards[#cards]
        local id = nil
        local source = nil
        if rightmostCard.ability and rightmostCard.ability.group then
            id = rightmostCard.ability.group.id
            source = rightmostCard.ability.group.source
        end
        if id and #G.hand.highlighted <= card.ability.max_highlighted then
            return true
        end
        return false
    end,
        set_badges = function (self, card, badges)
      SMODS.create_mod_badges({ mod = SMODS.find_mod("Bunco")[1] }, badges)
    end,
}

function UNIK.get_sorted_by_position(area)
  local cards = {}

  for i = 1, #area.highlighted do
    cards[i] = area.highlighted[i]
  end

  table.sort(cards, function(a, b)
    return a.T.x < b.T.x
  end)

  return cards
end