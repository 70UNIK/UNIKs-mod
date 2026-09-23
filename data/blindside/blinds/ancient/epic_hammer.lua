--retriggers the first (or last) scored blind once for every 3 blinds held in hand, +1 Hand Size when held in hand
BLINDSIDE.Blind({
    key = 'unik_blindside_epic_hammer',
    atlas = 'unik_blindside_epic_blinds',
    pos = {x = 0, y = 8},
    config = {
        extra = {
            value = 1,
            interval = 2,
            hand_size = 1,
        }},
    hues = {"Faded","Green"},
    calculate = function(self, card, context) 
        if context.unik_kite_experiment and context.scoring_hand and context.cardarea == G.play and ((not context.cardarea and not context.main_eval) or context.main_eval) and card.area == G.hand then
            local validCards = {}
            local rescores = math.floor((#G.hand.cards - #G.hand.highlighted)/card.ability.extra.interval)
            for i = 1, math.floor(rescores) do
                local strct = {}
                strct[#strct+1] = context.scoring_hand[1]
                if card.ability.extra.upgraded then
                    strct[#strct+1] = context.scoring_hand[#context.scoring_hand]
                end
                strct.unik_scoring_segment = true
                validCards[#validCards+1] = strct
            end
            
            if #validCards > 0 then
                return {
                    target_cards = validCards,
                    card = context.blueprint_card or card,
                    message = '+1',
                    colour = HEX('F6EEF8'),
                }
            end   
            
        end
        if G.hand.cards and card and card.ability.extra.hand_size and tableContains(card, G.hand.cards) and not card.ability.extra.unik_hand_size_added and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED and not context.blueprint then
            card.ability.extra.unik_hand_size_added = true
            G.GAME.bellows_hs_tracker = G.GAME.bellows_hs_tracker or 0
            G.GAME.bellows_hs_tracker =G.GAME.bellows_hs_tracker + 1
            --add_tag(Tag('tag_bld_toss'))
            G.hand:change_size(card.ability.extra.hand_size)
            print("hand_mod: " .. G.GAME.bellows_hs_tracker)
            
        end
        if G.hand.cards and card and card.ability.extra.hand_size and not tableContains(card, G.hand.cards) and card.ability.extra.unik_hand_size_added and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED and not context.blueprint then
            card.ability.extra.unik_hand_size_added = nil
            G.hand:change_size(-card.ability.extra.hand_size)
            G.GAME.bellows_hs_tracker = G.GAME.bellows_hs_tracker or 0
            G.GAME.bellows_hs_tracker =G.GAME.bellows_hs_tracker - 1
            print("hand_mod: " .. G.GAME.bellows_hs_tracker)
        end
    end,
    unik_ancient = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bld_retain', set = 'Other'}
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
        local triggers = 0
        if G.hand and G.hand.cards then
            triggers = math.floor((#G.hand.cards - #G.hand.highlighted)/card.ability.extra.interval)
        end
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_epic_hammer_upgraded' or 'm_unik_blindside_epic_hammer',
            vars = {
                card.ability.extra.interval,triggers,card.ability.extra.hand_size
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
        card.ability.extra.upgraded = true
        end
    end
})