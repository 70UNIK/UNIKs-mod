--When a [random blind] is played, it permanently gains +1 retrigger, debuffs said blind 
BLINDSIDE.Joker({
    blindside_joker = true,
    key = 'unik_blindside_blacklist',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=22},
    boss_colour = HEX("bfc7d5"),
    mult = 18,
    base_dollars = 8,
    order = 1,
    cursed = {min = -66},
    active = true,
    in_pool = function(self, args)
        if G.GAME.selected_back.effect.center.config.extra then
            if not UNIK.hasBlindside() then return false end
            return true
        else
        return false
        end
    end,
     loc_vars = function (self)
        return {
            vars = {
                localize({key = G.GAME.unik_blindside_blacklist_blind or "m_bld_sharp", type = 'name_text', set = 'Enhanced'}),1
                
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                localize('k_unik_random_blind'),1
            }
        }
    end,
    unik_before_play = function(self)
        
        for i,v in pairs(G.hand.cards) do
            if v.facing ~= 'back' and v.debuff then
                v:flip()
                v.flipped_by_blacklist = true
            end
        end
    end,
    debuff = {
        akyrs_blind_difficulty = "unik_blindside_cursed",
    },
    disable = function(self)
        for i,v in pairs(G.playing_cards) do
            SMODS.recalc_debuff(v)
        end
    end,
    joker_defeat = function()
    end,
    calculate = function(self, blind, context)
         if context.setting_blind and not context.disabled then
            blind.active = true
        end
        if context.before then
            for i,v in pairs(G.play.cards) do
                if v.facing ~= 'back' and v.debuff then
                    v:flip()
                end
            end
        end
        if context.after and not G.GAME.blind.disabled  then
            
            G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0, func = function()
                    
            for i=1, #G.hand.cards do
                local carder = G.hand.cards[i]
                
                if carder.flipped_by_blacklist and carder.facing == 'back' and (not carder.ability.extra or (carder.ability.extra and not carder.ability.extra.flipped)) then
                    carder:flip()
                    carder.flipped_by_blacklist = nil
                end
            end
            for i,v in pairs(G.playing_cards) do
                v.flipped_by_blacklist = nil
            end
                        return true
                    end}))
        end
        if not G.GAME.blind.disabled then
            if context.debuff_card then
                if G.GAME.unik_blindside_blacklist_blind  and context.debuff_card.config.center.key == G.GAME.unik_blindside_blacklist_blind 
                
                and context.debuff_card:bld_can_debuff_card_externally() then
                    return {
                        debuff = true
                    }
                end
            end
            if context.final_scoring_step then
                blind.prepped = true
              --  print(#G.play.cards)
               -- print(G.play.cards[1].config.center.key)
                if #G.play.cards == 1 and G.play.cards[1].config.center.key == G.GAME.unik_blindside_blacklist_blind then
                    G.GAME.playing_with_fire_num = G.GAME.playing_with_fire_num + 1
                    G.GAME.playing_with_fire_each = G.GAME.used_vouchers.v_bld_swearjar and "bld_playing_with_fire_each_3" or "bld_playing_with_fire_each_2"
                    G.GAME.playing_with_fire = G.GAME.playing_with_fire + 2 + (G.GAME.used_vouchers.v_bld_swearjar and 1 or 0)
                     G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        func = function()
                            
                            
                            blind:wiggle()
                            return true
                        end
                    }))
                    G.play.cards[1].ability["perma_repetitions"] = G.play.cards[1].ability["perma_repetitions"] or 0
                    G.play.cards[1].ability["perma_repetitions"] = G.play.cards[1].ability["perma_repetitions"] + 1
                    card_eval_status_text(G.play.cards[1], "extra", nil, nil, nil, {
                        message = localize({
                            type = "variable",
                            key = "a_retriggers",
                            vars = { number_format(G.play.cards[1].ability["perma_repetitions"]) },
                        }),
                        card=G.play.cards[1],
                        delay = 1,
                    })
                    
                end
            end
            if context.hand_drawn then
                G.GAME.unik_dynamic_text_realtime = true
                if blind.prepped then

                    for i,v in pairs(G.playing_cards) do
                        if v:bld_can_debuff_card_externally() then
                            SMODS.recalc_debuff(v)
                            if v.config.center.key == G.GAME.unik_blindside_blacklist_blind  then
                                v:juice_up()
                            end
                        end

                    end
                    blind:wiggle()
                end
            end
            if context.hand_drawn then
                blind.prepped = nil
            end
        end
    end,
})


local function  reset_blacklist_blind()
    local card = "m_bld_sharp"
    if G.playing_cards then
        local cards = pseudorandom_element(G.playing_cards, pseudoseed('blacklist_blindside'..G.GAME.round_resets.ante))
        if cards then
            card = cards.config.center.key
        end
        
    end
    G.GAME.unik_blindside_blacklist_blind = card
   -- print( G.GAME.unik_blindside_blacklist_blind)
end

--After defeating the final boss blind (ignoring ante) or at start, reset the ranks
local resetReedRanks = reset_blinds
function reset_blinds()
    if G.GAME.round_resets.blind_states.Boss == "Defeated" then
        reset_blacklist_blind()
    end
    resetReedRanks()
end
local start_run_boss_override = Game.start_run
function Game:start_run(args)
    start_run_boss_override(self,args)
    local saveTable = args.savetext or nil
    if not saveTable then
         G.E_MANAGER:add_event(Event({
            func = function() 
                reset_blacklist_blind()
                return true
            end}))
    
        
    end
end
-- local gameStart = Game.start_run
-- function Game:start_run(args)
--     local vars = gameStart(self,args)
--      G.E_MANAGER:add_event(Event({
--                             func = function() 
--                                 reset_blacklist_blind()
--                                 return true
--                             end}))
    
--     return vars
-- end