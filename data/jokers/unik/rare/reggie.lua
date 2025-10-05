SMODS.Atlas {
	key = "unik_reggie",
	path = "unik_reggie.png",
	px = 71,
	py = 95
}

local reggie_quotes = {
	normal = {
		'k_unik_reggie_normal1',
		'k_unik_reggie_normal2',
		'k_unik_reggie_normal3',
        'k_unik_reggie_normal4',
	},
    trigger = {
		'k_unik_reggie_trigger1',
		'k_unik_reggie_trigger2',
		'k_unik_reggie_trigger3',
    },
}
SMODS.Joker {
    key = "unik_reggie",
    atlas = 'unik_reggie',
    rarity = 3,
    cost = 7,
    pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    config = {extra = {rescore = 1}, immutable = {max_rescores = 10}},
    pronouns = "he_him",
    enhancement_gate = 'm_unik_pink',
    loc_vars = function(self, info_queue, center)
        local quoteset = 'normal'
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
        info_queue[#info_queue + 1] = G.P_CENTERS.m_unik_pink
        return { 
           vars = {math.min(center.ability.extra.rescore,center.ability.immutable.max_rescores),localize(reggie_quotes[quoteset][math.random(#reggie_quotes[quoteset])] .. "")} }
	end,
    calculate = function(self, card, context)
        if context.unik_kite_experiment and context.scoring_hand then
            local validCards = {}
            for i,v in pairs(context.scoring_hand) do
                if SMODS.has_enhancement(v,'m_unik_pink') then
                    validCards[#validCards+1] = v;
                end
            end
            if #validCards > 0 then
                if not context.blueprint_card then
                    local quoteset = 'trigger'
                    return {
                        target_cards = validCards,
                        rescore = math.min(card.ability.extra.rescore,card.ability.immutable.max_rescores),
                        card = card,
                        message = localize(reggie_quotes[quoteset][math.random(#reggie_quotes[quoteset])].. ""),
                        colour = HEX('fe4df1'),
                    }
                else
                    return {
                        target_cards = validCards,
                        rescore = math.min(card.ability.extra.rescore,card.ability.immutable.max_rescores),
                        card = card,
                        message = '+1',
                    }
                end
            end   
        end
    end
}
