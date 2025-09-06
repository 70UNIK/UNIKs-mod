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
    config = { extra = {x_mult = 1.0,x_mult_mod = 0.15}, immutable = {x_mult_display = 1.0} },
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = UNIK.suit_tooltip('light')

        center.ability.immutable.x_mult_display = center.ability.extra.x_mult
        
        if G.hand and G.hand.cards and G.hand.highlighted and #G.hand.highlighted > 0 then
            local _,_,_,scoring_hand,_ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            for i,v in pairs(scoring_hand) do
                if UNIK.is_suit_type(v,'light') then
                    center.ability.immutable.x_mult_display = center.ability.immutable.x_mult_display + center.ability.extra.x_mult_mod
                end
            end
        elseif G.play and G.play.cards then
            center.ability.immutable.x_mult_display = center.ability.extra.x_mult
           local _,_,_,scoring_hand,_ = G.FUNCS.get_poker_hand_info(G.play.cards)
            for i,v in pairs(scoring_hand) do
                if UNIK.is_suit_type(v,'light') then
                    center.ability.immutable.x_mult_display = center.ability.immutable.x_mult_display + center.ability.extra.x_mult_mod
                end
            end
        end
        local quoteset = 'normal'
        return { 
            vars = {center.ability.immutable.x_mult_display,center.ability.extra.x_mult_mod,localize(k_amann_quotes[quoteset][math.random(#k_amann_quotes[quoteset])] .. ""),
        } 
        }
	end,
    calculate = function(self, card, context)
        if context.before then
            card.ability.extra.x_mult = 1
        end
        if context.individual and context.cardarea == G.play then
            local dispMult = card.ability.extra.x_mult
            for i,v in pairs(context.scoring_hand) do
                if UNIK.is_suit_type(v,'light') then
                    dispMult = dispMult + card.ability.extra.x_mult_mod
                end
            end
            if UNIK.is_suit_type(context.other_card,'light') then
                return {
                    x_mult = dispMult,
                    card = card
                }
            end
        end
        if context.after and not context.blueprint then
            card.ability.extra.x_mult = 1
        end
    end,
}
