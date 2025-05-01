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
    config = { extra = {odds = 1,mult=20,odds_mult = 5, p_dollars = 20, odds_money = 15} },
    --ONLY DISABLE if extracredit is installed
    gameset_config = {
		modest = { disabled = (SMODS.Mods["extracredit"] or {}).can_load },
	},
    loc_vars = function(self, info_queue, center)
        return { 
            key = Cryptid.gameset_loc(self, { modest = "modest"}), 
            vars = {center and cry_prob(center.ability.cry_prob,center.ability.extra.odds_money,center.ability.cry_rigged)or 1, 
        center.ability.extra.mult,center.ability.extra.odds_mult,center.ability.extra.p_dollars,center.ability.extra.odds_money} }
	end,
    
    pools = {["unik_seven"] = true },
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and Card.get_gameset(card) ~= "modest" then
            -- if a seven
            if context.other_card:get_id() == 7 then
                local multTrue = false
                local moneyTrue = false
                if pseudorandom('unik_lucky_seven') < cry_prob(card.ability.cry_prob,card.ability.extra.odds_money,card.ability.cry_rigged)/card.ability.extra.odds_money then
                    moneyTrue = true
                end
                if pseudorandom('unik_lucky_seven') < cry_prob(card.ability.cry_prob,card.ability.extra.odds_mult,card.ability.cry_rigged)/card.ability.extra.odds_mult then
                    multTrue = true
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
        if context.check_enhancement and SMODS.Ranks[context.other_card.base.value].key == "7" and Card.get_gameset(card) == "modest" then
            return{
                m_lucky = true
            }
        end
    end,
}
if JokerDisplay then
	JokerDisplay.Definitions["j_unik_lucky_seven"] = {
        text = {
			{ text = "+", colour = G.C.MULT },
			{ ref_table = "card.ability.extra", ref_value = "mult", colour = G.C.MULT, retrigger_type = "mult" },
			{ text = " $", colour = G.C.GOLD },
			{ ref_table = "card.ability.extra", ref_value = "p_dollars", colour = G.C.GOLD, retrigger_type = "mult" },
        },
        extra = {
            {
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "odds1",
                    colour = G.C.GREEN,
                    scale = 0.3,
                },		
                {text = " "},
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "odds2",
                    colour = G.C.GREEN,
                    scale = 0.3,
                },	
			},
		},
        calc_function = function(card)
            card.joker_display_values.odds1 = localize { type = 'variable', key = "jdis_odds", vars = { cry_prob(card.ability.cry_prob,card.ability.extra.odds_mult,card.ability.cry_rigged) or 1, card.ability.extra.odds_mult } }
            card.joker_display_values.odds2 = localize { type = 'variable', key = "jdis_odds", vars = { cry_prob(card.ability.cry_prob,card.ability.extra.odds_money,card.ability.cry_rigged) or 1, card.ability.extra.odds_money } }
        end
	}
end
