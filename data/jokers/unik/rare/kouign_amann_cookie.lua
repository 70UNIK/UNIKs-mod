--X1.075 Mult per light suit scored, increases this by X0.075 Mult per light suit scored
--
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
    demicolon_compat = true,
    config = { extra = {x_mult = 1.075,x_mult_mod = 0.075,x_mult_base = 1.075} },
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = UNIK.suit_tooltip('light')
        local quoteset = 'normal'
        return { 
            vars = {tostring(math.floor(center.ability.extra.initial*300)/300),tostring(math.floor(center.ability.extra.increase*300)/300),localize(k_amann_quotes[quoteset][math.random(#k_amann_quotes[quoteset])] .. ""),
        } 
        }
	end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            -- Give the xMult if the current card is the required suit
            if UNIK.is_suit_type(context.other_card,'light') then
                SMODS.scale_card(card, {
                    ref_table =card.ability.extra,
                    ref_value = "x_mult",
                    scalar_value = "x_mult_mod",
                    message_key = "a_xmult",
                    message_colour = G.C.MULT,
                    no_message = true,
                })
            return {
                x_mult = card.ability.extra.x_mult,
                card = card
            }
            end
        end
        -- Quietly reset the xMult for the card at the end of played hand
        if context.after and not context.blueprint then
            card.ability.extra.x_mult = card.ability.extra.x_mult_base
        end
    end,
}
