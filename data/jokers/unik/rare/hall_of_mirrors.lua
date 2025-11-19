--rescore all scored glass cards
SMODS.Joker {
    key = "unik_hall_of_mirrors",
    atlas = 'unik_rare',
    rarity = 3,
    cost = 7,
    pos = { x = 1, y = 2 },
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    config = {extra = {rescore = 1}, immutable = {max_rescores = 10}},
    pronouns = "it_its",
    enhancement_gate = 'm_glass',
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return { 
           vars = {math.min(center.ability.extra.rescore,center.ability.immutable.max_rescores)} }
	end,
    calculate = function(self, card, context)
        if context.unik_kite_experiment and context.scoring_hand then
            local validCards = {}
            for i,v in pairs(context.scoring_hand) do
                if SMODS.has_enhancement(v,'m_glass') then
                    validCards[#validCards+1] = v;
                end
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