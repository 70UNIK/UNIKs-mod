--Earn $1 per bill card played, increase this by $1 per bill card in scoring hand.
--The US dollar bill this time
SMODS.Enhancement {
	atlas = 'unik_enhancements',
	pos = {x = 1, y = 1},
	key = 'unik_bill',
    config = { extra = { money = 1, money_mod = 1} },
    weight = 1,
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.money,card.ability.extra.money_mod}
        }
    end,
	calculate = function(self, card, context, effect)
		if context.cardarea == G.play and context.main_scoring then
            local dollars = 0
            for i,v in pairs(context.scoring_hand) do
                if v ~= card and SMODS.has_enhancement(v,'m_unik_bill') then
                    dollars = dollars + 1
                    G.E_MANAGER:add_event(Event({
                    trigger = "before",
                    delay = 0.2,
                    func = function()
                        v:juice_up()
                        card:juice_up()
                        play_sound('chips1', 0.8+ (0.9 + 0.2*math.random())*0.2, 1)
                        -- ease_dollars(card.ability.cash)
                        return true
                    end,
                    }))
                end
            end

            return {
                p_dollars = card.ability.extra.money + card.ability.extra.money_mod*dollars, 
                card = card,
            }
		end
	end,
}