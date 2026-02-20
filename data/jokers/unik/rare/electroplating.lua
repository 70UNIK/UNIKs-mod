SMODS.Joker {
    key = 'unik_electroplating',
    atlas = 'placeholders',
	pos = { x = 2, y = 0 },
    rarity = 3,
    cost = 7,
    blueprint_compat = false,
    perishable_compat = true,
	eternal_compat = true,
    config = {extra = {rescores = 1}},
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_copper_seal" }
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
        return {vars = {center.ability.extra.rescores}}
	end,
    in_pool = function() --reduce frequency of it appearing
        for i,v in pairs(G.playing_cards) do
            if v.seal and v.seal == 'unik_copper' then
                return true
            end
        end
        return false
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint and not context.repetition and not context.retrigger_joker then
            --print("turn them happy")
            
            for i,v in pairs(context.scoring_hand) do
                if v.seal and v.seal == 'unik_copper' then
                    v.ability.perma_rescores = v.ability.perma_rescores or 0
                    v.ability.perma_rescores = v.ability.perma_rescores + 1
                    v:set_seal(nil, true, true)
                end
            end
            return{
               
            }
        end
    end,
}