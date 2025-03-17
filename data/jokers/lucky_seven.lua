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
    loc_vars = function(self, info_queue, center)
        return { vars = {center and cry_prob(center.ability.cry_prob,center.ability.extra.odds_money,center.ability.cry_rigged)or 1, 
        center.ability.extra.mult,center.ability.extra.odds_mult,center.ability.extra.p_dollars,center.ability.extra.odds_money} }
	end,
    
    pools = {["unik_seven"] = true },
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
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
    end,
}