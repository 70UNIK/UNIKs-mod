--reduces the rank of 2 selected cards by 1
SMODS.Consumable{
    set = "Tarot",
   	key = "unik_weakness",
	pos = { x = 1, y = 2 },
	config = { rank_shift = 1, max_highlighted = 2 },
	atlas = "placeholders",
	attributes = {'modify_card', 'rank'},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted,card.ability.rank_shift} }
    end,
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(
			G.localization.misc.dictionary.bunc_mysterious_tarot,
			get_type_colour(self or card.config, card),
			nil,
			1.2
		)
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    -- SMODS.modify_rank will increment/decrement a given card's rank by a given amount
                    assert(SMODS.modify_rank(G.hand.highlighted[i], -card.ability.rank_shift))
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
}