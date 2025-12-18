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
    pronouns = "he_him",
    death_message = "special_lose_unik_cookie",
	disable = function(self, silent)
		G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.blind_ante) * G.GAME.starting_params.ante_scaling * 2
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
	end,
    increment_in_ante = {-1,0.025},
    increment_by_click = true,
    unik_clicky_click_mod = function(self,prevent_rep)
        local base = get_blind_amount(G.GAME.round_resets.blind_ante)*G.GAME.starting_params.ante_scaling
        G.GAME.blind.chips = G.GAME.blind.chips + base * 0.025
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        G.HUD_blind:recalculate(true)
        G.hand_text_area.blind_chips:juice_up()
        G.GAME.blind.triggered = true
        G.GAME.blind:wiggle()
        play_sound('chips2')
        G.ROOM.jiggle = G.ROOM.jiggle + 0.5
    end,
}

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

-- --refresh on reload
local sr2 = Game.start_run
function Game:start_run(args)
	sr2(self, args)
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

local rb2 = reset_blinds
function reset_blinds()
    local choices = { "Small", "Big", "Boss" }
	for _, c in pairs(choices) do
		if
            G.GAME.round_resets.blind_states[c] == "Defeated"
            or G.GAME.round_resets.blind_states[c] == 'Hide'
            or G.GAME.round_resets.blind_states[c] == 'Skipped'
		then
            G.GAME.round_resets.cookie_increment = G.GAME.round_resets.cookie_increment or {}
             G.GAME.round_resets.cookie_increment[c] = 0
		end
	end
	rb2()
end
local function BlindIncrement(penalty)
    local choices = { "Small", "Big", "Boss" }
	for _, c in pairs(choices) do
		if
            not G.SETTINGS.paused and 
			G.GAME
			and G.GAME.round_resets
			and G.GAME.round_resets.blind_choices
			and G.GAME.round_resets.blind_choices[c]
			and G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].increment_in_ante
            and G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].increment_by_click
            and G.GAME.round_resets.blind_states[c] ~= "Defeated"
            and G.GAME.round_resets.blind_states[c] ~= 'Hide'
            and G.GAME.round_resets.blind_states[c] ~= 'Current'
		then
            G.GAME.round_resets.cookie_increment = G.GAME.round_resets.cookie_increment or {}
            G.GAME.round_resets.cookie_increment[c] = G.GAME.round_resets.cookie_increment[c] or 0
            G.GAME.round_resets.cookie_increment[c] = G.GAME.round_resets.cookie_increment[c] + 1
            if G.blind_select_opts then
                local blindText = G.blind_select_opts[string.lower(c)]:get_UIE_by_ID('blind_text_'..string.lower(c))
                if blindText then
                    blindText.config.text = UNIK.calculate_cookie_base(c)..""

                    G.blind_select_opts[string.lower(c)]:recalculate()
                    blindText:juice_up()
                end
                
                if G.OVERLAY_MENU then
                    local blindText2 = G.OVERLAY_MENU:get_UIE_by_ID('blind_text_'..string.lower(c))
                    if blindText2 then
                        blindText2:juice_up()
                        blindText2.config.text = UNIK.calculate_cookie_base(c)..""
                        G.OVERLAY_MENU:recalculate()
                    end
                end
            end
            play_sound('cancel', 0.8, 1)
            G.ROOM.jiggle = G.ROOM.jiggle + 0.5
        elseif G.GAME.round_resets.blind_states[c] == "Current" 
            and G.GAME
			and G.GAME.blind
			and not G.GAME.blind.disabled
			and to_big(G.GAME.chips) < to_big(G.GAME.blind.chips) 
        then

        elseif 			not G.SETTINGS.paused and G.GAME
			and G.GAME.round_resets
			and G.GAME.round_resets.blind_choices
			and G.GAME.round_resets.blind_choices[c] and 
            G.GAME.round_resets.cookie_increment and 
            G.GAME.round_resets.cookie_increment[c]
            then
            G.GAME.round_resets.cookie_increment[c] = nil
        end
	end
end

function UNIK.calculate_cookie_base(type)
    local incrementer = G.P_BLINDS[G.GAME.round_resets.blind_choices[type]].increment_in_ante
    local base = get_blind_amount(G.GAME.round_resets.blind_ante)*G.GAME.starting_params.ante_scaling
    local initial = get_blind_amount(G.GAME.round_resets.blind_ante)*G.P_BLINDS[G.GAME.round_resets.blind_choices[type]].mult*G.GAME.starting_params.ante_scaling
    --print(initial)
    --print(G.P_BLINDS[G.GAME.round_resets.blind_choices[type]].config.mult)
    G.GAME.round_resets.cookie_increment = G.GAME.round_resets.cookie_increment or {}
    G.GAME.round_resets.cookie_increment[type] = G.GAME.round_resets.cookie_increment[type] or 0
    --iterate until get to value
    for i = 1, G.GAME.round_resets.cookie_increment[type] do
        if incrementer[1] == -1 then --addition
            initial = initial + base*incrementer[2]
        elseif incrementer[1] == 0 then --multiplication
            initial = initial *incrementer[2]
        elseif incrementer[1] == 1 then --exponentiation
            initial = initial^incrementer[2]
        elseif incrementer[1] > 1 then --higher operators
            initial = portable_exp(initial,incrementer[1],incrementer[2])
        end
    end
    return initial
end

local lcpref2 = Controller.L_cursor_press
function Controller:L_cursor_press(x, y)
    lcpref2(self, x, y)
    BlindIncrement(0)
    if G and G.GAME and G.GAME.blind and G.GAME.blind.unik_clicky_click_mod and G.GAME.blind.in_blind and not G.SETTINGS.paused and not G.OVERLAY_MENU then
        G.GAME.blind:unik_clicky_click_mod(self)
    end
end