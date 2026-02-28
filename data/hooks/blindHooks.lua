--Blind hooks


--Debuffs after scoring.
function Blind:unik_debuff_after_hand(poker_hands, scoring_hand,cards, check,sum)
	if not self.disabled then
		local obj = self.config.blind
		if obj.unik_debuff_after_hand and type(obj.unik_debuff_after_hand) == "function" then
			return obj:unik_debuff_after_hand(poker_hands, scoring_hand,cards, check,sum)
		end
	end
	return nil
end

--modifies the SMODS score
function Blind:unik_mod_final_score(sum)
	if not self.disabled then
		local obj = self.config.blind
		if obj.unik_mod_final_score and type(obj.unik_mod_final_score) == "function" then
			return obj:unik_mod_final_score(sum)
		end
	end
	return nil
end

--Context before play
function Blind:unik_before_play()
	if not self.disabled then
		local obj = self.config.blind
		if obj.unik_before_play and type(obj.unik_before_play) == "function" then
			return obj:unik_before_play()
		end
	end
end

--context after play
function Blind:unik_after_play()
	if not self.disabled then
		local obj = self.config.blind
		if obj.unik_after_play and type(obj.unik_after_play) == "function" then
			return obj:unik_after_play()
		end
	end
end

--Instead of merely debuffing a hand, it will KILL you if you play that hand
function Blind:unik_kill_hand(cards, hand, handname, check)
	if not self.disabled then
		local obj = self.config.blind
		if obj.unik_kill_hand and type(obj.unik_kill_hand) == "function" then
			return obj:unik_kill_hand(cards, hand, handname, check)
		end
	end
end

--Effects for after defeating a blind. Return true to kill the player. Return false to not do that
function Blind:unik_after_defeat(score,blind_size)
    if not self.disabled then
		local obj = self.config.blind
		if obj.unik_after_defeat and type(obj.unik_after_defeat) == "function" then
			return obj:unik_after_defeat(score,blind_size)
		end
	end
end



local killHook = Blind.debuff_hand
function Blind:debuff_hand(cards, hand, handname, check)
	local instakill = self:unik_kill_hand(cards, hand, handname, check)
	if killHook(self,cards, hand, handname, check) == true or instakill == true then
		if instakill == true then
			G.GAME.unik_instant_death_hand = true
		else
			G.GAME.unik_instant_death_hand = nil
		end
		return true
	else
		G.GAME.unik_instant_death_hand = nil
		return false
	end
end

--disabling hook
--Hooks taken from Jen's for Epic Blinds
local disblref2 = Blind.disable

function Blind:disable()
    
	local obj = self.config.blind
	if obj and obj.boss then
		if obj.boss.legendary or obj.boss.exotic then
			play_sound('cancel', 0.7 + 0.05, 0.7)
            local text = localize('k_unik_boss_immune')
            attention_text({
                scale = 1.0, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = G.C.UNIK_EYE_SEARING_RED
            })
            G.ROOM.jiggle = G.ROOM.jiggle + 7
			G.GAME.blind:wiggle()
			return true
        elseif obj.boss.epic then
            play_sound('cancel', 0.8, 1)
            local text = 'Blind is immune!'
            attention_text({
                scale = 0.9, text = text, hold = 0.75, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = obj.boss_colour or G.C.RED
            })
			G.GAME.blind:wiggle()
			return true
		elseif obj.boss.ancient then
            play_sound('cancel', 0.8, 1)
            local text = localize('k_unik_joker_immune')
            attention_text({
                scale = 0.9, text = text, hold = 0.75, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = obj.boss_colour or G.C.RED
            })
			G.GAME.blind:wiggle()
            return true
        end
        
	end
    G.GAME.unik_override_prince = true
    local ret = disblref2(self)
    G.GAME.unik_override_prince = true
    if SMODS and SMODS.OPENED_BOOSTER and SMODS.OPENED_BOOSTER.config and SMODS.OPENED_BOOSTER.config.center then
        local obj2 = SMODS.OPENED_BOOSTER.config.center
        if obj2 and obj2.unik_disablable and obj2.unik_disablable == true then
            G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                    G.GAME.disable_banish_FX = true
                    G.FUNCS.end_consumeable()
                    G.GAME.disable_banish_FX = nil
                                return true
                    end,
                }))
        end
    end
    return ret
end

--blindside rerollers
local bsreroll_boss = G.FUNCS.blind_reroll_boss
G.FUNCS.blind_reroll_boss = function(e) 
    local obj = G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss]
	if obj and obj.boss and (obj.boss.legendary or obj.boss.exotic) then
		play_sound('cancel', 0.7 + 0.05, 0.7)
        local text = localize('k_unik_boss_reroll_nope')
        attention_text({
            scale = 0.9, text = text, hold = 0.75, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = G.C.UNIK_EYE_SEARING_RED
        })
        G.ROOM.jiggle = G.ROOM.jiggle + 1.5
		--jl.a(localize('k_nope_ex'), G.SETTINGS.GAMESPEED * 2, 0.8, G.C.RED)
    elseif obj and obj.boss and (obj.boss.epic or obj.boss.ancient ) then
        play_sound('cancel', 0.8, 1)
        local text = localize('k_nope_ex')
        attention_text({
            scale = 0.9, text = text, hold = 0.75, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = obj.boss_colour or G.C.RED
        })
	else
		return bsreroll_boss(e)
	end
end
--big reroll
local bsreroll_big =  G.FUNCS.reroll_big
G.FUNCS.reroll_big = function(e) 
    local obj = G.P_BLINDS[G.GAME.round_resets.blind_choices.Big]
	if obj and obj.boss and (obj.boss.legendary or obj.boss.exotic) then
		play_sound('cancel', 0.7 + 0.05, 0.7)
        local text = localize('k_unik_boss_reroll_nope')
        attention_text({
            scale = 0.9, text = text, hold = 0.75, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = G.C.UNIK_EYE_SEARING_RED
        })
        G.ROOM.jiggle = G.ROOM.jiggle + 1.5
		--jl.a(localize('k_nope_ex'), G.SETTINGS.GAMESPEED * 2, 0.8, G.C.RED)
    elseif obj and obj.boss and (obj.boss.epic or obj.boss.ancient ) then
        play_sound('cancel', 0.8, 1)
        local text = localize('k_nope_ex')
        attention_text({
            scale = 0.9, text = text, hold = 0.75, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = obj.boss_colour or G.C.RED
        })
	else
		return bsreroll_big(e)
	end
end
--small_reroll
local bsreroll_small =    G.FUNCS.reroll_small
  G.FUNCS.reroll_small = function(e) 
    local obj = G.P_BLINDS[G.GAME.round_resets.blind_choices.Small]
	if obj and obj.boss and (obj.boss.legendary or obj.boss.exotic) then
		play_sound('cancel', 0.7 + 0.05, 0.7)
        local text = localize('k_unik_boss_reroll_nope')
        attention_text({
            scale = 0.9, text = text, hold = 0.75, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = G.C.UNIK_EYE_SEARING_RED
        })
        G.ROOM.jiggle = G.ROOM.jiggle + 1.5
		--jl.a(localize('k_nope_ex'), G.SETTINGS.GAMESPEED * 2, 0.8, G.C.RED)
    elseif obj and obj.boss and (obj.boss.epic or obj.boss.ancient ) then
        play_sound('cancel', 0.8, 1)
        local text = localize('k_nope_ex')
        attention_text({
            scale = 0.9, text = text, hold = 0.75, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = obj.boss_colour or G.C.RED
        })
	else
		return bsreroll_small(e)
	end
end



local gfrb2 = G.FUNCS.reroll_boss
G.FUNCS.reroll_boss = function(e)
	local obj = G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss]
	if obj and obj.boss and (obj.boss.legendary or obj.boss.exotic) then
		play_sound('cancel', 0.7 + 0.05, 0.7)
        local text = localize('k_unik_boss_reroll_nope')
        attention_text({
            scale = 0.9, text = text, hold = 0.75, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = G.C.UNIK_EYE_SEARING_RED
        })
        G.ROOM.jiggle = G.ROOM.jiggle + 1.5
		--jl.a(localize('k_nope_ex'), G.SETTINGS.GAMESPEED * 2, 0.8, G.C.RED)
    elseif obj and obj.boss and (obj.boss.epic or obj.boss.ancient ) then
        play_sound('cancel', 0.8, 1)
        local text = localize('k_nope_ex')
        attention_text({
            scale = 0.9, text = text, hold = 0.75, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = obj.boss_colour or G.C.RED
        })
	else
		return gfrb2(e)
	end
end

local bunco_hook = G.FUNCS.use_blind_card
G.FUNCS.use_blind_card = function(e)
    local obj = G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss]
    if obj and obj.boss and obj.boss.legendary then
		play_sound('cancel', 0.7 + 0.05, 0.7)
        local text = localize('k_unik_boss_reroll_nope')
        attention_text({
            scale = 0.9, text = text, hold = 0.75, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = G.C.UNIK_EYE_SEARING_RED
        })
        G.ROOM.jiggle = G.ROOM.jiggle + 1.5
		    local card = e.config.ref_table

        local boss = card.ability.blind_card.blind.key
        -- G.GAME.round_resets.blind_choices.Boss = boss

        -- play_sound('other1')

        e.config.button = nil

        -- if G.blind_select_opts.boss then
        --     bunc_refresh_boss_blind()
        -- end

        G.PROFILES[G.SETTINGS.profile].blind_cards_used = (G.PROFILES[G.SETTINGS.profile].blind_cards_used or 0) + 1
        if G.PROFILES[G.SETTINGS.profile].blind_cards_used then
            check_for_unlock({type = 'use_blind_card', blinds_total = G.PROFILES[G.SETTINGS.profile].blind_cards_used})
        end

        G.FUNCS.end_consumeable(nil, 0.2)
    elseif obj and obj.boss and obj.boss.epic then
        play_sound('cancel', 0.8, 1)
        local text = localize('k_nope_ex')
        attention_text({
            scale = 0.9, text = text, hold = 0.75, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = obj.boss_colour or G.C.RED
        })
            local card = e.config.ref_table

        local boss = card.ability.blind_card.blind.key
        -- G.GAME.round_resets.blind_choices.Boss = boss

        -- play_sound('other1')

        e.config.button = nil

        -- if G.blind_select_opts.boss then
        --     bunc_refresh_boss_blind()
        -- end

        G.PROFILES[G.SETTINGS.profile].blind_cards_used = (G.PROFILES[G.SETTINGS.profile].blind_cards_used or 0) + 1
        if G.PROFILES[G.SETTINGS.profile].blind_cards_used then
            check_for_unlock({type = 'use_blind_card', blinds_total = G.PROFILES[G.SETTINGS.profile].blind_cards_used})
        end

        G.FUNCS.end_consumeable(nil, 0.2)
	else
		return bunco_hook(e)
	end
end

--For legendary blinds,etc... It changes the atlas, without changing the base atlas
function AnimatedSprite:shift_atlas(sprite_pos)
    self.animation = {
        x= sprite_pos and sprite_pos.x or 0,
        y=sprite_pos and sprite_pos.y or 0,
        frames=self.atlas.frames,current=0,
        w=self.scale.x, h=self.scale.y}
end


-- ban skip in epic cookie
local skipRestriction = G.FUNCS.skip_blind
G.FUNCS.skip_blind = function(e)
    local obj = G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss]
    local obj2 = G.P_BLINDS[G.GAME.round_resets.blind_choices.Big]
    local obj3 = G.P_BLINDS[G.GAME.round_resets.blind_choices.Small]
	if obj.key == 'bl_unik_epic_cookie' or G.GAME.modifiers.unik_no_skipping or (obj.boss and obj.boss.unskippable_ante) then
        play_sound('cancel', 0.8, 1)
        local text = localize('k_nope_ex')
        attention_text({
            scale = 0.9, text = text, hold = 0.75, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = obj.boss_colour or G.C.RED
        })
        if e and e.disable_button then
            e.disable_button = nil
        end
    elseif G.GAME.blind_on_deck == "Small" and obj3.boss and (obj3.boss.epic or obj3.boss.legendary or obj3.boss.unskippable_ante and G.GAME.round_resets.blind_states.Small ~= "Defeated") then
        play_sound('cancel', 0.8, 1)
        local text = localize('k_nope_ex')
        attention_text({
            scale = 0.9, text = text, hold = 0.75, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = obj3.boss_colour or G.C.RED
        })
        if e and e.disable_button then
            e.disable_button = nil
        end
    elseif G.GAME.blind_on_deck == "Big" and obj2.boss and (obj2.boss.epic or obj2.boss.legendary or (obj2.boss.unskippable_ante and G.GAME.round_resets.blind_states.Big ~= "Defeated")) then
        play_sound('cancel', 0.8, 1)
        local text = localize('k_nope_ex')
        attention_text({
            scale = 0.9, text = text, hold = 0.75, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = obj2.boss_colour or G.C.RED
        })
        if e and e.disable_button then
            e.disable_button = nil
        end
    else
        skipRestriction(e)
    end

end

--immediately ends the round, sets score to -1 and unless you have something like Determination (will still respect that), you die.
function UNIK.instakill()
    if not G.GAME.blind or (G.GAME.blind and not G.GAME.blind.in_blind ) then
        local game_over = true
        SMODS.saved = false
        SMODS.calculate_context({out_of_round = true, game_over = game_over})
        if SMODS.saved then game_over = false end
        if game_over then
            G.E_MANAGER:add_event(Event({
                delay = 0,
                trigger = 'immediate',
                func = function()
                    G.STATE = G.STATES.GAME_OVER
                    G.STATE_COMPLETE = false 
                    return true
                end
            }))
        end
    else
        
    G.GAME.chips = -1
    G.E_MANAGER:add_event(
        Event({
            trigger = "immediate",
            func = function()
                if G.STATE ~= G.STATES.SELECTING_HAND then
                    return false
                end
                G.STATE = G.STATES.HAND_PLAYED
                G.STATE_COMPLETE = true
                end_round()
                return true
            end,
        }),
        "other"
    )
        
        
    end
    
end

G.FUNCS.draw_from_play_to_deck = function(e)
    local play_count = #G.play.cards
    local it = 1
    for k, v in ipairs(G.play.cards) do
        if (not v.shattered) and (not v.destroyed) then 
            draw_card(G.play,G.deck, it*100/play_count,'down', false, v)
            it = it + 1
        end
    end
end

local end_roundref = end_round
function end_round()
    local instakill = G.GAME.blind:unik_after_defeat(G.GAME.chips,G.GAME.blind.chips)
    if instakill then
        G.GAME.chips = -1
        game_over = true
        G.ROOM.jiggle = G.ROOM.jiggle + 25
        G.GAME.blind.triggered = true
        G.GAME.blind:wiggle()
    end
    local ret = end_roundref()

    return ret
end

local pcfh = G.FUNCS.play_cards_from_highlighted
function G.FUNCS.play_cards_from_highlighted(e)
	G.GAME.before_play_buffer2 = true

    
    --Steel blind edition, each held card

    --Epic cookie: Deselect cards pending destruction
    for i=1, #G.hand.highlighted do
        if G.hand.highlighted[i] and G.hand.highlighted[i].ability and G.hand.highlighted[i].ability.set_for_destruction then
            G.hand:remove_from_highlighted(G.hand.highlighted[i])
        end
    end
    --Only play if highlight cards are > 0
    if (SMODS.Mods["Cryptid"] or {}).can_load  then
        if #G.hand.highlighted == 0 and (Cryptid.enabled("set_cry_poker_hand_stuff") == true) and G.PROFILES[G.SETTINGS.profile].cry_none then
            G.PROFILES[G.SETTINGS.profile].cry_none = true
        end
    end

    --Now that none hand is enabled, no need to disable playing hopefully it unlocks none hand by then
    if ((not (SMODS.Mods["Cryptid"] or {}).can_load  ) or (Cryptid.enabled("set_cry_poker_hand_stuff") ~= true)) and #G.hand.highlighted == 0 then
        
    else

        -- -NAN fix
        if G.GAME.round_scores['hand'] and not G.GAME.round_scores['hand'].amt then
            G.GAME.round_scores['hand'].amt = math.huge
            G.GAME.round_scores.hand.amt = math.huge
        end


        --Polymino autoselect all cards in selected group
        local id = {}
        G.GAME.unik_no_finger_trigger = true

        if G.hand and G.hand.highlighted then
            for i = 1, #G.hand.highlighted do
                if G.hand.highlighted[i] and G.hand.highlighted[i].ability and G.hand.highlighted[i].ability.group then
                    local exists = false
                    for i,v in pairs(id) do

                        if G.hand.highlighted[i] and G.hand.highlighted[i].ability and G.hand.highlighted[i].ability.group and G.hand.highlighted[i].ability.group.id == v then
                            exists = true
                        end
                    end
                    if not exists then
                        id[#id+1] = G.hand.highlighted[i].ability.group.id
                    end
                    
                end
            end
        end
        --enable 
        if #G.hand.highlighted > 6 then
            G.GAME.unik_scored_over_5 = true 
        end
       -- print(id)
        --print(#id)
        if #id > 0 then
            for i,v in pairs(G.hand.cards) do
                for j,x in pairs(id) do
                    
                    if v and v.ability and v.ability.group and v.ability.group.id == x and not v.highlighted then
                        G.hand:brute_force_highlight(v)
                    end
                end
            end
        end
        G.GAME.unik_wiggle_consumed = nil
        G.GAME.unik_no_finger_trigger = nil
        
        G.GAME.blind:unik_before_play()
        if G.GAME.blind_edition and G.GAME.blind_edition[G.GAME.blind_on_deck] and not reset and (G.GAME.blind and G.GAME.blind.name and G.GAME.blind.name ~= '') then
            local edi = G.P_BLIND_EDITIONS[G.GAME.blind_edition[G.GAME.blind_on_deck]]
            if edi.unik_before_play and (type(edi.unik_before_play) == "function") then
                edi:unik_before_play()
            end
        end
        if G.GAME.modifiers.unik_decay_on_play then
            for i = 1, #G.hand.highlighted do
                G.hand.highlighted[i].ability.unik_decaying = true
            end
        end
        SMODS.calculate_context({on_select_play = true})
        --end
        G.E_MANAGER:add_event(Event({
            func = function()
                UNIK.railroad_suits()
                return true
            end
        }))
        pcfh(e)
    end
	G.GAME.before_play_buffer2 = nil
end