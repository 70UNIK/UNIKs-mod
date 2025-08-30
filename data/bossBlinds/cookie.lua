--0x Blind size initially, +0.05x requirements per click in this ante, +0.7x per skip
SMODS.Blind{
    key = 'unik_cookie',
    config = {},

    boss = {min = 1, max = 6666666}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 18},
    boss_colour= HEX("d58c4b"), 
    dollars = 5,
    mult = 0,
    death_message = "special_lose_unik_cookie",
	defeat = function(self, silent)
		G.P_BLINDS.bl_unik_cookie.mult = 0
	end,
	disable = function(self, silent)
		G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
	end,
    unik_clicky_click_mod = function(self,prevent_rep)
        if G.SETTINGS.paused then
			return {0.0,-1}
		else
            --only wiggle on click if inside the cookie or has this function, otherwise produce a sound indicating that the cookie is active.
            if G.GAME.blind.in_blind and (G.GAME.blind.name == 'bl_unik_cookie' or G.GAME.blind.name == 'bl_unik_epic_cookie' or G.GAME.blind.name == 'cry-Obsidian Orb') and G.GAME.blind.unik_clicky_click_mod then
                if not prevent_rep or prevent_rep == false then
                    G.GAME.blind.triggered = true
                    G.GAME.blind:wiggle()
                    G.hand_text_area.blind_chips:juice_up()
                    play_sound('chips2')
                    G.ROOM.jiggle = G.ROOM.jiggle + 0.5
                end
            else
                if not prevent_rep or prevent_rep == false then
                    play_sound('cancel', 0.8, 1)
                    G.ROOM.jiggle = G.ROOM.jiggle + 0.5
                end

            end
            --Syntax operators:
            -- -1 = +Reqs
            -- 0 = xReq
            -- 1 = ^Req
            -- 2 = ^^req, etc...
            --{Amount,operator}
            --For multiplication and exponentiation, ideally have it above 1.
			return {0.025,-1}
		end
    end,
}

-- ban skip in epic cookie
local skipRestriction = G.FUNCS.skip_blind
G.FUNCS.skip_blind = function(e)
    local obj = G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss]
    local obj2 = G.P_BLINDS[G.GAME.round_resets.blind_choices.Big]
    local obj3 = G.P_BLINDS[G.GAME.round_resets.blind_choices.Small]
	if obj.key == 'bl_unik_epic_cookie' then
        play_sound('cancel', 0.8, 1)
        local text = localize('k_nope_ex')
        attention_text({
            scale = 0.9, text = text, hold = 0.75, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = obj.boss_colour or G.C.RED
        })
        if e and e.disable_button then
            e.disable_button = nil
        end
    elseif G.GAME.blind_on_deck == "Small" and obj3.boss and (obj3.boss.epic or obj3.boss.legendary) then
        play_sound('cancel', 0.8, 1)
        local text = localize('k_nope_ex')
        attention_text({
            scale = 0.9, text = text, hold = 0.75, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = obj3.boss_colour or G.C.RED
        })
        if e and e.disable_button then
            e.disable_button = nil
        end
    elseif G.GAME.blind_on_deck == "Big" and obj2.boss and (obj2.boss.epic or obj2.boss.legendary) then
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

--refresh on reload
local sr2 = Game.start_run
function Game:start_run(args)
	sr2(self, args)
	if G.P_BLINDS.bl_unik_cookie then
		G.P_BLINDS.bl_unik_cookie.mult = 0
    end
    if G.P_BLINDS.bl_unik_epic_cookie then
        G.P_BLINDS.bl_unik_epic_cookie.mult = 1
        G.P_BLINDS.bl_unik_epic_cookie.unik_exponent[2] = 1
    end
	if not G.GAME.defeated_blinds then
		G.GAME.defeated_blinds = {}
	end
end

--Update when you click
function Blind:unik_clicky_click_mod(prevent_rep)
	if not self.disabled then
		local obj = self.config.blind
		if obj.unik_clicky_click_mod and type(obj.unik_clicky_click_mod) == "function" then
			return obj:unik_clicky_click_mod(prevent_rep)
		end
	end
	return 0
end

--patch for multiple cookies to click all at once
local bsb2 = Blind.set_blind
function Blind:set_blind(blind, y, z)
	local c = "Boss"
	if string.sub(G.GAME.subhash or "", -1) == "S" then
		c = "Small"
	end
	if string.sub(G.GAME.subhash or "", -1) == "B" then
		c = "Big"
	end
	if G.GAME.CRY_BLINDS and G.GAME.CRY_BLINDS[c] and not y and blind and (blind.mult or blind.unik_exponent) and blind.unik_clicky_click_mod then
		blind.mult = G.GAME.CRY_BLINDS[c]
        if blind.unik_exponent and blind.unik_exponent[2] > 0 then
            blind.unik_exponent[2] = G.GAME.CRY_BLINDS[c]
        end
	end
	bsb2(self, blind, y, z)
end

local rb2 = reset_blinds
function reset_blinds()
	if G.GAME.round_resets.blind_states.Boss == "Defeated" then
		G.GAME.CRY_BLINDS = {}
		if G.P_BLINDS.bl_unik_cookie then
			G.P_BLINDS.bl_unik_cookie.mult = 0
        end
        if G.P_BLINDS.bl_unik_epic_cookie then
            G.P_BLINDS.bl_unik_epic_cookie.unik_exponent[2] = 1
            G.P_BLINDS.bl_unik_epic_cookie.mult = 1
        end
	end
	rb2()
end

--BUG: losing against the cookie (both variants) will carry over the blind size.
local function BlindIncrement(penalty)
    local choices = { "Small", "Big", "Boss" }
	G.GAME.CRY_BLINDS = G.GAME.CRY_BLINDS or {}
	for _, c in pairs(choices) do
		if
			G.GAME
			and G.GAME.round_resets
			and G.GAME.round_resets.blind_choices
			and G.GAME.round_resets.blind_choices[c]
			and G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].unik_clicky_click_mod
		then
			if
				G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult ~= 0
				and G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult_ante ~= G.GAME.round_resets.ante
			then
				if G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].name == "cry-Obsidian Orb" then
					for i = 1, #G.GAME.defeated_blinds do
						G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult = G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult
							* G.P_BLINDS[G.GAME.defeated_blinds[i]]
							/ 2
					end
				elseif  G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].name == "bl_unik_epic_cookie" then
                    G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult = 1
                    G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].unik_exponent[2] = 1
                else
					G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult = 0
				end
				G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult_ante = G.GAME.round_resets.ante
			elseif G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult == 0
            and G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult_ante ~= G.GAME.round_resets.ante then
                if  G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].name == "bl_unik_epic_cookie" then
                    G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult = 1
                    G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].unik_exponent[2] = 1
                end
            end
			if
				G.GAME.round_resets.blind_states[c] ~= "Current"
				and G.GAME.round_resets.blind_states[c] ~= "Defeated"
			then
                --MAJOR ISSUE, they will carry their initial blind sizes if switched.
                --crash fix
                if G.P_BLINDS[G.GAME.round_resets.blind_choices[c]] and G.P_BLINDS[G.GAME.round_resets.blind_choices[c]]:unik_clicky_click_mod(false) then
                    if G.P_BLINDS[G.GAME.round_resets.blind_choices[c]]:unik_clicky_click_mod(true)[2] <= -1 then
                        G.GAME.CRY_BLINDS[c] = (G.GAME.CRY_BLINDS[c] or G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult)
                        + (
                            G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].unik_clicky_click_mod and G.P_BLINDS[G.GAME.round_resets.blind_choices[c]]:unik_clicky_click_mod(true)[1] or 0
                        )
                    --multiplication
                    elseif G.P_BLINDS[G.GAME.round_resets.blind_choices[c]]:unik_clicky_click_mod(true)[2] == 0 then
                        if G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult < 1 then
                            G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult = 1
                        end
                        if G.GAME.CRY_BLINDS[c] and G.GAME.CRY_BLINDS[c] < 1 then
                            G.GAME.CRY_BLINDS[c] = 1
                        end
                        G.GAME.CRY_BLINDS[c] = (G.GAME.CRY_BLINDS[c] or G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult)
                        * (
                            G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].unik_clicky_click_mod and G.P_BLINDS[G.GAME.round_resets.blind_choices[c]]:unik_clicky_click_mod(true)[1] or 1
                        )
                    --exponentiation, tetration, etc...
                    else
                        -- --The problem with this is that exponentiation doesnt work at x1 mult. So it has to be multiplied for used exponentiation
                        if G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult < 0 or G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].unik_exponent[2] == 0 then
                            G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult = 1
                            G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].unik_exponent[2] = 1
                        end
                        if G.GAME.CRY_BLINDS[c] and  G.GAME.CRY_BLINDS[c] < 1 then
                            G.GAME.CRY_BLINDS[c] = 1
                        end

                        G.GAME.CRY_BLINDS[c] = (G.GAME.CRY_BLINDS[c] or G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].unik_exponent[2])
                        * (
                            G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].unik_clicky_click_mod and G.P_BLINDS[G.GAME.round_resets.blind_choices[c]]:unik_clicky_click_mod(true)[1] or 1
                        )

                        --print(G.GAME.CRY_BLINDS[c] or G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].unik_exponent[2])
                        -- G.GAME.CRY_BLINDS[c] = to_big(G.GAME.CRY_BLINDS[c] or G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult):arrow(
                        --     G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].unik_clicky_click_mod and G.P_BLINDS[G.GAME.round_resets.blind_choices[c]]:unik_clicky_click_mod(true)[2] or 1,
                        --     G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].unik_clicky_click_mod and G.P_BLINDS[G.GAME.round_resets.blind_choices[c]]:unik_clicky_click_mod(true)[1] or 1
                        -- )
                        -- print(to_big(G.GAME.CRY_BLINDS[c] or G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult):arrow(
                        --     G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].unik_clicky_click_mod and G.P_BLINDS[G.GAME.round_resets.blind_choices[c]]:unik_clicky_click_mod(true)[2] or 1,
                        --     G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].unik_clicky_click_mod and G.P_BLINDS[G.GAME.round_resets.blind_choices[c]]:unik_clicky_click_mod(true)[1] or 1
                        -- ))
                    end
                end
				-- G.GAME.CRY_BLINDS[c] = (G.GAME.CRY_BLINDS[c] or G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult)
				-- 	+ (
				-- 		G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].unik_clicky_click_mod and G.P_BLINDS[G.GAME.round_resets.blind_choices[c]]:unik_clicky_click_mod()[0] or 0
                --         + penalty
				-- 	)
				--Update UI
				--todo: in blinds screen, too
				if G.blind_select_opts then
					if (SMODS.Mods["StrangeLib"] or {}).can_load then
						StrangeLib.dynablind.blind_choice_scores[c] = get_blind_amount(G.GAME.round_resets.blind_ante)
							* G.GAME.starting_params.ante_scaling
							* G.GAME.CRY_BLINDS[c]
						StrangeLib.dynablind.blind_choice_score_texts[c] =
							number_format(StrangeLib.dynablind.blind_choice_scores[c])
					else
						local blind_UI =
							G.blind_select_opts[string.lower(c)].definition.nodes[1].nodes[1].nodes[1].nodes[1]
						local chip_text_node = blind_UI.nodes[1].nodes[3].nodes[1].nodes[2].nodes[2].nodes[3]
						if chip_text_node then
                            local exponent = false
                            if G.P_BLINDS[G.GAME.round_resets.blind_choices[c]] and G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].unik_exponent and G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].unik_exponent[2] > 0 then
                                exponent = true
                            end
                            if exponent then
                                --this registers as that but is not updating properly
                                chip_text_node.config.text = number_format(
                                    to_big(get_blind_amount(G.GAME.round_resets.blind_ante)
                                        * G.GAME.starting_params.ante_scaling):arrow(G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].unik_exponent[1],G.GAME.CRY_BLINDS[c])
                                )
                                chip_text_node.config.scale = score_number_scale(
                                    0.9,
                                    to_big(get_blind_amount(G.GAME.round_resets.blind_ante)
                                    * G.GAME.starting_params.ante_scaling):arrow(G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].unik_exponent[1],G.GAME.CRY_BLINDS[c])
                                )  
                            else
                                --print("1")
                                chip_text_node.config.text = number_format(
								get_blind_amount(G.GAME.round_resets.blind_ante)
									* G.GAME.starting_params.ante_scaling
									* G.GAME.CRY_BLINDS[c])
							
                                chip_text_node.config.scale = score_number_scale(
                                    0.9,
                                    get_blind_amount(G.GAME.round_resets.blind_ante)
                                        * G.GAME.starting_params.ante_scaling
                                        * G.GAME.CRY_BLINDS[c]
                                )
                            end

						end
						G.blind_select_opts[string.lower(c)]:recalculate()
					end
				end

			elseif
				G.GAME.round_resets.blind_states[c] ~= "Defeated"
				and not G.GAME.blind.disabled
				and to_big(G.GAME.chips) < to_big(G.GAME.blind.chips)
			then
                if G.GAME.blind:unik_clicky_click_mod(false) then
                    if G.GAME.blind:unik_clicky_click_mod(true)[2] <= -1 then
                        G.GAME.blind.chips = G.GAME.blind.chips
                        + (G.GAME.blind:unik_clicky_click_mod(true)[1])
                            * get_blind_amount(G.GAME.round_resets.ante)
                            * G.GAME.starting_params.ante_scaling
                    elseif G.GAME.blind:unik_clicky_click_mod(true)[2] <= 0 then
                        G.GAME.blind.chips = G.GAME.blind.chips
                        * (G.GAME.blind:unik_clicky_click_mod(true)[1])
                            * get_blind_amount(G.GAME.round_resets.ante)
                            * G.GAME.starting_params.ante_scaling
                    else
                        G.GAME.blind.chips = to_big(G.GAME.blind.chips):arrow(G.GAME.blind:unik_clicky_click_mod(true)[2],G.GAME.blind:unik_clicky_click_mod(true)[1])
                    end
                end
                
				
				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                G.HUD_blind:recalculate(true)
                
			end
		end
	end
end

local lcpref2 = Controller.L_cursor_press
function Controller:L_cursor_press(x, y)
    lcpref2(self, x, y)
    BlindIncrement(0)
end