SMODS.Blind	{
    key = 'unik_epic_decision',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = G.C.UNIK_LARTCEPS1,
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 16},
    vars = {},
    dollars = 13,
    mult = 2,
	pronouns = "he_him",
	in_pool = function(self)
        return  CanSpawnEpic()
	end,
    unik_booster_before_blind = function(self)
    end,
    debuff = {
        akyrs_blind_difficulty = "unik_epic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
    set_blind = function(self, reset, silent)
        if not reset then
            G.GAME.blind:wiggle()
            G.GAME.blind.triggered = true
            G.GAME.unik_mortons_fork = true --flag will prevent other booster tags from triggering and draw cards afterwards if in blind.
            G.GAME.lartceps_pack_pity = 4
            if G.jokers.cards then
				G.GAME.blind:wiggle()
				G.GAME.blind.triggered = true
				for i,v in pairs(G.jokers.cards) do
					v:juice_up(0,0.25)
				end
			end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    local key = "p_unik_lartceps_bundle"
                    local card = Card(
                        G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
                        G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
                        G.CARD_W * 1.27,
                        G.CARD_H * 1.27,
                        G.P_CARDS.empty,
                        G.P_CENTERS[key],
                        { bypass_discovery_center = true, bypass_discovery_ui = true }
                    )
                    card.cost = 0
                    card.from_tag = true
                    G.FUNCS.use_card({ config = { ref_table = card } })
                    card:start_materialize()
                    pack_opened = true
                    return true
                end,
            }))
        end
    end
}
local G_FUNCS_can_skip_booster_ref = G.FUNCS.can_skip_booster
G.FUNCS.can_skip_booster = function(e)
    
	if G.pack_cards and (not (G.GAME.STOP_USE and G.GAME.STOP_USE > 0)) and
	(G.STATE == G.STATES.SMODS_BOOSTER_OPENED or G.STATE == G.STATES.PLANET_PACK or G.STATE == G.STATES.STANDARD_PACK or G.STATE == G.STATES.BUFFOON_PACK or (G.hand  )) then 
		--if a booster is unskippable (when its unskippable conditionsa re fulfilled), unhighlight it
		local obj
        if SMODS.OPENED_BOOSTER and SMODS.OPENED_BOOSTER.config then
            obj = SMODS.OPENED_BOOSTER.config.center or nil
        end
		if obj and obj.unskippable and type(obj.unskippable) == "function" then
			if obj:unskippable() == true then
				e.config.colour = G.C.UI.BACKGROUND_INACTIVE
				e.config.button = nil
			else
				G_FUNCS_can_skip_booster_ref(e)
			end
		else
			G_FUNCS_can_skip_booster_ref(e)
		end
	else
	e.config.colour = G.C.UI.BACKGROUND_INACTIVE
	e.config.button = nil
	end
end

--Hook for booster skip to say NOPE! in almanac (since alamanac overrides)
local almanac_no_skip = G.FUNCS.skip_booster
G.FUNCS.skip_booster = function(e)
    local obj = SMODS.OPENED_BOOSTER.config.center
    local obj2 = G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss]
    if obj.unskippable and type(obj.unskippable) == "function" and obj:unskippable() == true then
        if G.GAME.blind then
            play_sound('cancel', 0.8, 1)
            local text = localize('k_nope_ex')
            attention_text({
                scale = 0.9, text = text, hold = 0.75, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = obj2.boss_colour or G.C.RED
            })
			G.GAME.blind:wiggle()
            G.GAME.blind.triggered = true
        end
        if e and e.disable_button then
            e.disable_button = nil
           -- print("disble")
        end
    else
        if obj.skip_effect and type(obj.skip_effect) == "function" then
            obj:skip_effect()
        end
        almanac_no_skip(e)
        --Draw cards after the booster pack has been skipped/finished
        
    end
end

local end_consumable_hook =   G.FUNCS.end_consumeable
G.FUNCS.end_consumeable = function(e, delayfac)
    end_consumable_hook(e,delayfac)
    if G.GAME.unik_mortons_fork then
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                G.STATE = G.STATES.DRAW_TO_HAND
                G.deck:shuffle('nr'..G.GAME.round_resets.ante)
                G.deck:hard_set_T()
                G.STATE_COMPLETE = false
                return true
            end
        }))
    end
end
local draw_hook = Game.update_selecting_hand
function Game:update_selecting_hand(dt)
    G.GAME.unik_mortons_fork = nil
    local ret = draw_hook(self,dt)

    return ret
end

local saveHook = save_run
function save_run()
    if not G.GAME.unik_mortons_fork then
        saveHook()
    end
end