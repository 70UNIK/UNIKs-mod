--weird, wacky and shitty way to detect pairs, 3 of a kinds, etc... while held in hand
local function jankerfix(pokerhands)
    local hierarchy = {
        bld_blind_all_in = {"bld_blind_flush","bld_blind_4oak","bld_blind_3oak",'bld_blind_2oak'},
        bld_blind_flush = {"bld_blind_4oak","bld_blind_3oak",'bld_blind_2oak'},
        bld_blind_4oak = {"bld_blind_3oak",'bld_blind_2oak'},
        bld_blind_3oak = {'bld_blind_2oak'},
        bld_blind_fullhouse = {'bld_blind_2pair'},
    }
    local newPokerHands = {}
    for i,v in pairs(pokerhands) do
        newPokerHands[i] = true
    end
    for i,v in pairs(pokerhands) do
        if hierarchy[i] then
            for j = 1, #hierarchy[i] do
                newPokerHands[hierarchy[i][j]] = true
            end
        end
    end
    if newPokerHands['bld_blind_2oak'] and (newPokerHands['bld_blind_4oak'] or newPokerHands['bld_blind_flush'] or newPokerHands['bld_blind_all_in']) then
        newPokerHands['bld_blind_fullhouse'] = true
    end
    return newPokerHands
end
local function localizerList(eval)
    local count = 0
    local pokerhands = {}
    --print(eval)
    for i,v in ipairs(G.handlist) do
        if next(eval[v])  then
            pokerhands[v] = true
            
        end 
    end
    local string = ""
    --print(pokerhands)
    local newTable = jankerfix(pokerhands)
    --print(newTable)
    for i,v in pairs(newTable) do
        if G.GAME.hands[i].level > 1 then
            count = count + 1
            string = string .. localize(i, "poker_hands") .. ', '
        end
        
    end
    return string, count
end


BLINDSIDE.Joker({
    blindside_joker = true,
    key = 'unik_blindside_goob',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=14},
    boss_colour = HEX("608BF4"),
    mult = 14,
    base_dollars = 8,
    order = 1,
    boss = {min = 2},
    active = true,
    death_card = {
        card = UNIK.has_bos() and 'j_' .. UNIK.get_bos_prefix() .. '_goob' or 'j_unik_blindside_taunt_goob_pwx', 
        mod_card = function(self, card) --used to apply editions and/or stickers
            
        end,
        quotes = {'unik_blindside_goob_lose'},
        say_times = 6,
    },
    calculate = function(self, blind, context)
        if context.scoring_hand and context.poker_hands and G.STATE == G.STATES.SELECTING_HAND and not G.GAME.blind.disabled and G.hand then
            local validCards = {}
            for i,v in pairs(G.hand.highlighted) do
                v.ignore_goob = true
            end
            for i,v in pairs(G.hand.cards) do
                if not v.ignore_goob then
                    validCards[#validCards+1] = v
                end
                v.ignore_goob = nil
            end
            if #G.hand.highlighted < 1 then
                BLINDSIDE.alert_debuff(self, false)
            else
                 local eval = evaluate_poker_hand(validCards)
                local string, amount = localizerList(eval)
                if not G.SETTINGS.paused then --crash fix
                    if amount > 0 then
                        BLINDSIDE.alert_debuff(self, false)
                        BLINDSIDE.alert_debuff(self, true, string .. localize("k_unik_goob_warning"))
                    else
                        BLINDSIDE.alert_debuff(self, false)
                    end
                end
            end
               
                
                
        end
        if context.pre_discard and not  G.SETTINGS.paused then
            BLINDSIDE.alert_debuff(self, false)
        end
        if context.before and not G.GAME.blind.disabled and context.scoring_name then
            BLINDSIDE.alert_debuff(self, false)
            G.GAME.unik_true_hand_after = context.scoring_name
            local eval = evaluate_poker_hand(G.hand.cards)
            local pokerhands = {}
            if G.GAME.hands then
                for i,v in ipairs(G.handlist) do
                    if next(eval[v]) then
                        pokerhands[v] = true
                    end
                end
            end
            local updatedTable = jankerfix(pokerhands)
            for v,g in pairs(updatedTable) do
                if G.GAME.hands[v].level > 1 then
                    self.triggered = true
                    
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                        G.GAME.blind:wiggle()
                        return true
                        end)
                    }))
                    --print(v .. " LOWERED!")
                    BLINDSIDE.change_fire_amount({amount = 2})
                    BLINDSIDE.add_fire()
                    level_up_hand(G.GAME.blind.children.animatedSprite or self.children.animatedSprite, v, nil, -1)
                end 
            end
            -- --print(eval)
            -- if G.GAME.hands then
            --     for i,v in ipairs(G.handlist) do
            --         --print(v)
                    
 

            --     end
            -- end
            -- update_hand_text({sound = 'chips2'}, {chips = hand_chips, mult = mult, })

        end
    end,
})

