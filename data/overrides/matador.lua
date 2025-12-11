
SMODS.Joker:take_ownership("j_matador",{
    config = { extra = 10},
    loc_vars = function(self, info_queue, center)
        
		return { vars = {center.ability.extra} }
	end,
    blueprint_compat = true,
	calculate = function(self, card, context)
		if context.blind_wiggler then
            return {
                 dollars = to_number(card.ability.extra),
            }
        end
	end,
},true)

local wiggler = Blind.wiggle
function Blind:wiggle()
    if not G.GAME.unik_wiggle_consumed then
        SMODS.calculate_context({blind_wiggler = true})
        
        G.GAME.unik_wiggle_consumed = true
    end
    
    wiggler(self)
end

local juice2 = SMODS.juice_up_blind
function SMODS.juice_up_blind()
    if not G.GAME.unik_wiggle_consumed then
        SMODS.calculate_context({blind_wiggler = true})
        G.GAME.unik_wiggle_consumed = true
    end
    juice2()
end

