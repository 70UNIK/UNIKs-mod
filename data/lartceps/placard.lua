--add permadebuffed and eternal to all cards
SMODS.Consumable{
    set = 'unik_lartceps', 
	atlas = 'unik_lartceps',
    cost = 0,
	pos = {x = 1, y = 0},
	key = 'unik_placard',
    config = {extra = {base = 3, odds = 4}},
    no_doe = true,
    no_grc = true,
	no_ccd = true,
    can_use = function(self, card)
		return true
	end,
    loc_vars = function(self, info_queue, center)
        local new_numerator, new_denominator = SMODS.get_probability_vars(center, center.ability.extra.base, center.ability.extra.odds, 'unik_placard')
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_ultradebuffed" }
        return {vars = {new_numerator,new_denominator}}
	end,
	use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            for i,v in pairs(G.hand.cards) do
                v.skip_this = true
                if SMODS.pseudorandom_probability(card, 'unik_placard', card.ability.extra.base, card.ability.extra.odds, 'unik_placard') then
                    
                    G.E_MANAGER:add_event(Event({func = function()
                        v.ability.unik_ultradebuffed = true
                        v.ability.unik_taw = true
                        v.unik_taw = true
                    card:juice_up()
                    v:juice_up()
                    play_sound('cancel', 0.8+ (0.9 + 0.2*math.random())*0.2, 1)
                    return true end })) 
                    delay(0.2)
                    
                end
            end
            G.E_MANAGER:add_event(Event({func = function()
                for i,v in pairs(G.playing_cards) do
                    if not v.skip_this and SMODS.pseudorandom_probability(card, 'unik_placard', card.ability.extra.base, card.ability.extra.odds, 'unik_placard') then
                        v.ability.unik_ultradebuffed = true
                        v.ability.unik_taw = true
                        v.unik_taw = true
                    end
                end
            return true end })) 
            G.E_MANAGER:add_event(Event({trigger = 'after',func = function()
                for i,v in pairs(G.playing_cards) do
                    v.skip_this = nil
                end
            return true end })) 

        return true end })) 
    end,
    in_pool = function()
		return lartcepsCheck()
	end,
}