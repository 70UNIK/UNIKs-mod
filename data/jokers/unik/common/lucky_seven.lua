--Reverse the probabilities
SMODS.Joker {
    key = 'unik_lucky_seven',
    atlas = 'unik_common',
    rarity = 1,
	pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    demicoloncompat = true,
    config = { extra = {odds1 = 1,odds2 = 1, mult=7,odds_mult = 2, p_dollars = 7, odds_money = 4} },
    --ONLY DISABLE if extracredit is installed
    loc_vars = function(self, info_queue, center)
        local new_numerator2, new_denominator2 = SMODS.get_probability_vars(center, center.ability.extra.odds2, center.ability.extra.odds_money, 'unik_lucky_seven_cash')
        return { 
            vars = {center.ability.extra.mult,
            new_numerator2, new_denominator2,center.ability.extra.p_dollars} }
	end,
    
    pools = {["unik_seven"] = true },
    calculate = function(self, card, context)
        if context.forcetrigger then
            return {
                p_dollars = card.ability.extra.p_dollars,
                mult = card.ability.extra.mult,
                card = card,
            }
        end
        if context.individual and context.cardarea == G.play then
            -- if a seven
            if context.other_card:get_id() == 7 then
                local multTrue = false
                local moneyTrue = false
                multTrue = true
                if SMODS.pseudorandom_probability(card, 'unik_lucky_seven_cash', card.ability.extra.odds2, card.ability.extra.odds_money, 'unik_lucky_seven_cash') then
                    moneyTrue = true
                end
                if multTrue and moneyTrue then
                    return {
                        p_dollars = card.ability.extra.p_dollars,
                        mult = card.ability.extra.mult,

                    }
                elseif multTrue and moneyTrue == false then
                    return {
                        mult = card.ability.extra.mult,

                    }
                elseif multTrue == false and moneyTrue then
                    return {
                        p_dollars = card.ability.extra.p_dollars,

                    }
                end
			end
        end
    end,
}
-- if JokerDisplay then
-- 	JokerDisplay.Definitions["j_unik_lucky_seven"] = {
--         text = {
-- 			{ text = "+", colour = G.C.MULT },
-- 			{ ref_table = "card.ability.extra", ref_value = "mult", colour = G.C.MULT, retrigger_type = "mult" },
-- 			{ text = " $", colour = G.C.GOLD },
-- 			{ ref_table = "card.ability.extra", ref_value = "p_dollars", colour = G.C.GOLD, retrigger_type = "mult" },
--         },
--         extra = {
--             {
--                 {
--                     ref_table = "card.joker_display_values",
--                     ref_value = "odds1",
--                     colour = G.C.GREEN,
--                     scale = 0.3,
--                 },		
--                 {text = " "},
--                 {
--                     ref_table = "card.joker_display_values",
--                     ref_value = "odds2",
--                     colour = G.C.GREEN,
--                     scale = 0.3,
--                 },	
-- 			},
-- 		},
--         calc_function = function(card)
--          
--         end
-- 	}
-- end
