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

--Blossom

SMODS.Joker {
    key = "unik_blossom",
    atlas = 'unik_blossom',
    rarity = 3,
    cost = 7,
    pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    config = {extra = {left_rescore = 2, right_rescore = 1}, immutable = {max_rescores = 10}},
    pronouns = "she_her",
    pools = {["character"] = true },
    loc_vars = function(self, info_queue, center)
        local quoteset = 'normal'
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
        return { 
           vars = {math.min(center.ability.extra.left_rescore,center.ability.immutable.max_rescores), math.min(center.ability.extra.right_rescore,center.ability.immutable.max_rescores),localize(blossom_quotes[quoteset][math.random(#blossom_quotes[quoteset])] .. "")} }
	end,
    calculate = function(self, card, context)
        if context.unik_kite_experiment and context.scoring_hand then
            local validCards = {}
            for i = 1, math.max(card.ability.extra.left_rescore,card.ability.extra.right_rescore) do
                local strct = {}
                for j = 1, #context.scoring_hand do
                    
                    if j == 1 and i <= card.ability.extra.left_rescore then
                        strct[#strct+1] = context.scoring_hand[j]
                    end
                    if j == #context.scoring_hand and i <= card.ability.extra.right_rescore then
                        strct[#strct+1] = context.scoring_hand[j]
                    end
                end
                strct.unik_scoring_segment = true
                validCards[#validCards+1] = strct
            end
            
            if #validCards > 0 then
                --Complex structure:
                --target cards = {{card,card}{card}}
                --
                if not context.blueprint_card then
                    local quoteset = 'trigger'
                    return {
                        target_cards = validCards,
                        -- rescore = {math.min(card.ability.extra.left_rescore,card.ability.immutable.max_rescores),math.min(card.ability.extra.right_rescore,card.ability.immutable.max_rescores)},
                        card = card,
                        message = localize(blossom_quotes[quoteset][math.random(#blossom_quotes[quoteset])].. ""),
                        colour = HEX('F16C74'),
                    }
                else
                    return {
                        target_cards = validCards,
                        -- rescore = {math.min(card.ability.extra.left_rescore,card.ability.immutable.max_rescores),math.min(card.ability.extra.right_rescore,card.ability.immutable.max_rescores)},
                        card = card,
                        message = '+1',
                    }
                end
            end   
        end
    end
}