--Rescore all scored rankless and suitless cards
SMODS.Joker {
    key = "unik_boulder_colorado",
    atlas = 'unik_normal_jokers',
    rarity = 2,
    cost = 6,
    pos = { x = 3, y = 4 },
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    config = {extra = {rescore = 1}, immutable = {max_rescores = 10}},
    pronouns = "it_its",
    in_pool = function()
        local stoneCards = 0
        if G.deck then 
            for i, w in pairs(G.deck.cards) do
                if SMODS.has_no_suit(w) and SMODS.has_no_rank(w) then
                    stoneCards = stoneCards + 1
                end
            end
        end
        if stoneCards >= 1 then
            return true
        end
        return false
	end,
    attributes = { 'enhancements','rescore','rank','suit'},
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
        return { 
           vars = {math.min(center.ability.extra.rescore,center.ability.immutable.max_rescores)} }
	end,
    calculate = function(self, card, context)
        if context.unik_kite_experiment and context.scoring_hand then
            local validCards = {}
            for i,v in pairs(context.scoring_hand) do
                if SMODS.has_no_suit(v) and SMODS.has_no_rank(v) then
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
    end,
    unlocked = false,
  	discovered = false,
    check_for_unlock = function(self, args)
        if args.type == 'unik_poppy_repetitions' and args.total_repetitions >= 4 and args.card and SMODS.has_no_suit(args.card) and SMODS.has_no_rank(args.card) then
            return true
        end
    end,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
                4
            }
        }
    end,
}