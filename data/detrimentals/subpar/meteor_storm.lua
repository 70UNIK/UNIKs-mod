-- Levels down 2 random poker hands on blind select, self destructs after playing a level 2 or higher poker hand 15 times.
UNIK.detriment{
    key = "unik_meteor_shower",
    atlas = "unik_detriments",
	pos = { x = 1, y = 5 },
    config = { extra = { poker_hands = 2,min_level = 2,hands = 0,hands_required = 15,applied = false} }, --why emult? 
    severity = 1,
    immutable = true,
    dongtong_compat = false,
    blueprint_compat = true,
    attributes = { 'detrimental','hand_type','space','hand_level','detriment'},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.poker_hands,card.ability.extra.min_level,card.ability.extra.hands_required,card.ability.extra.hands} }
	end,
    add_to_deck = function(self, card, from_debuff)
        if  G.GAME.blind.in_blind and not card.ability.extra.applied then
            card.ability.extra.applied = true
            local _poker_hands = {}
            local random_hands = {}
            for _, k in ipairs(G.handlist) do
                local v = G.GAME.hands[k]
                if v.visible and v.level > 1 then _poker_hands[#_poker_hands+1] = k end
            end
            if #_poker_hands > 0 then
                for i=1, math.min(#_poker_hands,card.ability.extra.poker_hands) do
                    local random_hand = pseudorandom_element(_poker_hands, pseudoseed('meteor_storm_unik')) or "High Card"
                    table.insert(random_hands,random_hand)
                    for i = #_poker_hands, 1, -1 do  
                        if _poker_hands[i] == random_hand then
                        table.remove(_poker_hands, i)
                        end
                    end
                end
            end
            
            if #random_hands > 0 then
                for i = 1, #random_hands do
                    SMODS.upgrade_poker_hands({
                        hands = random_hands[i],
                        level_up = -1,
                        from = card,
                        instant = nil,
                    })
                end
            end
        end
	end,
    calculate = function(self, card, context)
        if context.end_of_round then
            card.ability.extra.applied = false
        end
        if context.cardarea == G.unik_detriment_area and context.before then
            if G.GAME.hands[context.scoring_name].level <= card.ability.extra.min_level then
                card.ability.extra.hands = card.ability.extra.hands + 1
                if card.ability.extra.hands >= card.ability.extra.hands_required then
                    selfDestruction(card,"k_extinct_ex",G.C.BLACK)
                else
                    return{
                        message = card.ability.extra.hands .. "/" .. card.ability.extra.hands_required,
                        colour = G.C.BLACK,
                    }
                end
            end
        end
		if context.setting_blind then
             G.E_MANAGER:add_event(Event({
                func = function()
                    local _poker_hands = {}
                    local random_hands = {}
                    for _, k in ipairs(G.handlist) do
                        local v = G.GAME.hands[k]
                        if v.visible and v.level > 1 then _poker_hands[#_poker_hands+1] = k end
                    end
                    if #_poker_hands > 0 then
                        for i=1, math.min(#_poker_hands,card.ability.extra.poker_hands) do
                            local random_hand = pseudorandom_element(_poker_hands, pseudoseed('meteor_storm_unik')) or "High Card"
                            table.insert(random_hands,random_hand)
                            for i = #_poker_hands, 1, -1 do  
                                if _poker_hands[i] == random_hand then
                                table.remove(_poker_hands, i)
                                end
                            end
                        end
                    end
                    
                    if #random_hands > 0 then
                        for i = 1, #random_hands do
                            SMODS.upgrade_poker_hands({
                                hands = random_hands[i],
                                level_up = -1,
                                from = card,
                                instant = nil,
                            })
                        end
                    end
                    return true
                end,
            }))
            card.ability.extra.applied = true
            
            
        end
    end,
}