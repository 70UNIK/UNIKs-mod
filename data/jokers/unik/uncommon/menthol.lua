--Rescore all cards for the next 8 hands
--If seltzer exists, Menthol should exist as well cause CRK
SMODS.Joker {
    key = "unik_menthol",
    atlas = 'placeholders',
	pos = { x = 1, y = 0 },
    rarity = 3,
    cost = 7,
	soul_pos = { x = 1, y = 0 },
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    config = {extra = {rescore = 1,hands = 10}, immutable = {max_rescores = 10}},
    pronouns = "he_him",
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
        return { 
           vars = {math.min(center.ability.extra.rescore,center.ability.immutable.max_rescores),center.ability.extra.hands} }
	end,
    pools = {["Food"] = true},
    calculate = function(self, card, context)
        if context.unik_kite_experiment and context.scoring_hand then
            local validCards = {}
            for i,v in pairs(context.scoring_hand) do
                validCards[#validCards+1] = v;
            end
            if #validCards > 0 then
                return {
                    target_cards = validCards,
                    rescore = math.min(card.ability.extra.rescore,card.ability.immutable.max_rescores),
                    card = card,
                    message = '+1',
                }
            end   
        end
    end
}
