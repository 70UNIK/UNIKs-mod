--First hearts card is rescored 2 times
SMODS.Atlas {
	key = "unik_blossom",
	path = "unik_blossom.png",
	px = 71,
	py = 95
}

local blossom_quotes = {
	normal = {
		'k_unik_blossom_normal1',
		'k_unik_blossom_normal2',
		'k_unik_blossom_normal3',
        'k_unik_blossom_normal4',
	},
    trigger = {
		'k_unik_blossom_trigger1',
		'k_unik_blossom_trigger2',
		'k_unik_blossom_trigger3',
        'k_unik_blossom_trigger4',
    },
}

SMODS.Joker {
    key = "unik_blossom",
    atlas = 'unik_blossom',
    rarity = 3,
    pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    config = {extra = {rescores = 2}, immutable = {max_rescores = 10}},
    pronouns = "she_her",
    loc_vars = function(self, info_queue, center)
        local quoteset = 'normal'
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
        return { 
           vars = {localize('Hearts', 'suits_plural'), math.min(center.ability.extra.rescores,center.ability.immutable.max_rescores),localize(blossom_quotes[quoteset][math.random(#blossom_quotes[quoteset])] .. "")} }
	end,
    calculate = function(self, card, context)
        if context.unik_kite_experiment and context.scoring_hand then
            local validCards = {}
            for i,v in pairs(context.scoring_hand) do
                validCards[#validCards+1] = v
                break
            end
            if #validCards > 0 then
                if not context.blueprint_card then
                    local quoteset = 'trigger'
                    return {
                        target_cards = validCards,
                        rescore = math.min(card.ability.extra.rescores,card.ability.immutable.max_rescores),
                        card = card,
                        message = localize(blossom_quotes[quoteset][math.random(#blossom_quotes[quoteset])].. ""),
                        colour = HEX('F16C74'),
                    }
                else
                    return {
                        target_cards = validCards,
                        rescore = math.min(card.ability.extra.rescores,card.ability.immutable.max_rescores),
                        card = card,
                        message = '+1',
                    }
                end
            end   
        end
    end
}
