--Gain Xmult equal to 1 + sum of scoring ranks /100
--If force triggered, produces xmult equal to sum of played ranks / 100 instead.
--Must have unstable compat (for instance, decimal cards, 161)
--Does not count ranks for rankless/custom ranks (abstract)
SMODS.Atlas {
	key = "unik_pibby",
	path = "unik_pibby.png",
	px = 71,
	py = 95
}
local pibby_quotes = {
	normal = {
		'k_unik_pibby_normal1',
		'k_unik_pibby_normal2',
        'k_unik_pibby_normal3',
	},
	-- drama = {
	-- 	'k_unik_pibby_scared1',
	-- 	'k_unik_pibby_scared2',
	-- },
	-- darkness = {
	-- 	'k_unik_pibby_darkness1',
	-- 	'k_unik_pibby_darkness2',
	-- }
}
SMODS.Joker {
    key = 'unik_pibby',
    atlas = 'unik_pibby',
    rarity = 3,
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
    cost = 8,
    blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = true,
    demicoloncompat = true,
    config = { extra = { divisor = 60,x_mult = 1} },
    gameset_config = {
		modest = { extra = { divisor = 100,x_mult = 1} },  
	},
    loc_vars = function(self, info_queue, center)
        local quoteset = 'normal'
		return { vars = {center.ability.extra.divisor,center.ability.extra.x_mult,localize(pibby_quotes[quoteset][math.random(#pibby_quotes[quoteset])] .. "")} }
	end,
    calculate = function(self, card, context)
        if context.forcetrigger then
            for k, v in ipairs(context.full_hand) do
                if SMODS.has_enhancement(v, "m_unik_pink") then
                    card.ability.extra.x_mult = card.ability.extra.x_mult + (7 / card.ability.extra.divisor)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end,
                    }))
                elseif v.base.nominal > 0 and not SMODS.has_no_rank(v) and not SMODS.has_enhancement(v, "m_cry_abstract") then
                    card.ability.extra.x_mult = card.ability.extra.x_mult + (v.base.nominal / card.ability.extra.divisor)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end,
                    }))
                end  
            end
            return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
				Xmult_mod = card.ability.extra.x_mult,
			}
        end
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            local triggered = false
            for k, v in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(v, "m_unik_pink") then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end,
                    }))
                    card.ability.extra.x_mult = card.ability.extra.x_mult + (7 / card.ability.extra.divisor)
                    triggered = true
                elseif v.base.nominal > 0 and not SMODS.has_no_rank(v) and not SMODS.has_enhancement(v, "m_cry_abstract") then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end,
                    }))
                    card.ability.extra.x_mult = card.ability.extra.x_mult + (v.base.nominal / card.ability.extra.divisor)
                    triggered = true
                end       
            end
            if triggered then
                return {
                    message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
                    colour = G.C.MULT,
                }
            end
        end
        if (context.joker_main and (to_big(card.ability.extra.x_mult) > to_big(1))) then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
				Xmult_mod = card.ability.extra.x_mult,
			}
		end
    end
}
