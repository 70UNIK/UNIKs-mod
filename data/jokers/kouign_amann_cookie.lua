
SMODS.Atlas {
	key = "unik_kouign_amann_cookie",
	path = "unik_kouign_amann_cookie.png",
	px = 71,
	py = 95
}
local k_amann_quotes = {
	normal = {
		'k_k_amann_normal1',
		'k_k_amann_normal2',
		'k_k_amann_normal3',
		'k_k_amann_normal4',
        'k_k_amann_normal5',
	},
    trigger = {
        'k_k_amann_trigger1',
        'k_k_amann_trigger2',
        'k_k_amann_trigger3',
        'k_k_amann_trigger4',
    }
}
SMODS.Joker {
    key = 'unik_kouign_amann_cookie',
    atlas = 'unik_kouign_amann_cookie',
	pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    config = { extra = {retriggers = 1,decrease = 0.1},immutable = {max_retriggers = 50, max_decrease = 0.5} },
    loc_vars = function(self, info_queue, center)
        local quoteset = 'normal'
        return { 
            vars = {math.min(center.ability.extra.retriggers,center.ability.immutable.max_retriggers),1-math.min(center.ability.extra.decrease,center.ability.immutable.max_decrease)
        ,localize(k_amann_quotes[quoteset][math.random(#k_amann_quotes[quoteset])] .. ""),
        } 
        }
	end,
    enhancement_gate = 'm_cry_light',
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card,'m_cry_light') then
                local rep = math.min(card.ability.extra.retriggers,card.ability.immutable.max_retriggers)
                local decrease = 1-math.min(card.ability.extra.decrease,card.ability.immutable.max_decrease)
                local card2 = context.other_card
                if decrease < 1 and not context.blueprint_card and not context.retrigger_joker then
                    card2.ability.extra.req = card2.ability.extra.req*decrease
                end
                if card2.ability.extra.current > card2.ability.extra.req then
                    card2.ability.extra.current = card2.ability.extra.req
                end
                -- card2.ability.extra.current = card2.ability.extra.current^decrease
                if rep > 0 then
                    --only do the quote if its specifically for her.
                    if not context.blueprint_card then
                        return {
                            -- message = localize(pseudorandom_element(k_amann_quotes['trigger'], pseudoseed("k_amann_quotes_trigger")) .. ""),
                            message = localize("k_again_ex"),
                            repetitions = to_number(
                                rep
                            ),
                            colour = HEX("fa7aa6"),
                            card = card,
                        }
                    else
                        return {
                            message = localize("k_again_ex"),
                            repetitions = to_number(
                                rep
                            ),
                            colour = HEX("fa7aa6"),
                            card = card,
                        }
                    end
                end
            end
        end
    end,
}