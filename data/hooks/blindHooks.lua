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
    local ret = disblref2(self)
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
