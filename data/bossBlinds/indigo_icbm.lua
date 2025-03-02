SMODS.Blind{
    key = 'unik_indigo_icbm',
    config = {},
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 1},
    boss_colour= HEX("250088"),
    dollars = 8,
    mult = 0.5,
    set_blind = function(self, reset, silent)
        local text = localize('k_unik_nuke_start')
        attention_text({
            scale = 1, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
        })
	end,
	-- defeat = function(self, silent)
	-- 	if G.GAME.unik_nuke_armed then
    --         G.GAME.unik_nuke_armed = nil
	-- 	end
	-- end,
	-- disable = function(self, silent)
	-- 	if G.GAME.unik_nuke_armed then
    --         G.GAME.unik_nuke_armed = nil
	-- 	end
	-- end,
    -- unik_indigo_nuke = function(self)
	-- 	if to_big(G.GAME.chips) >= to_big(G.GAME.blind.chips) * 3 then
	-- 		--DIE.
    --         G.E_MANAGER:add_event(Event({
    --             func = function()
    --                 G.STATE = G.STATES.GAME_OVER
    --                 G.GAME.chips = 0
    --                 G.GAME.unik_got_nuked = true
    --                 print("DIE!")
    --                 G.GAME.blind.triggered = true
    --                 G.GAME.won = false
    --                 return true
    --             end
    --         }))

    --         unik_gameover()

    --         return to_big(0)
	-- 	end
	-- 	return 1
	-- end,
}
-- function Blind:unik_indigo_nuke()
-- 	if not self.disabled then
--         print("ENABLED")
-- 		local obj = self.config.blind
-- 		if obj.unik_indigo_nuke and type(obj.unik_indigo_nuke) == "function" then
-- 			return obj:unik_indigo_nuke()
-- 		end
-- 	end
-- 	return 1
-- end
-- Game over function
function unik_gameover()
    remove_save()

    if G.GAME.round_resets.ante <= G.GAME.win_ante then
        if not G.GAME.seeded and not G.GAME.challenge then
            inc_career_stat('c_losses', 1)
            set_deck_loss()
            set_joker_loss()
        end
    end

    play_sound('negative', 0.5, 0.7)
    play_sound('whoosh2', 0.9, 0.7)

    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu{
        definition = create_UIBox_game_over(),
        config = {no_esc = true}
    }
    G.ROOM.jiggle = G.ROOM.jiggle + 3
    
    if G.GAME.round_resets.ante <= G.GAME.win_ante then --Only add Jimbo to say a quip if the game over happens when the run is lost
        local Jimbo = nil
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 2.5,
            blocking = false,
            func = (function()
                if G.OVERLAY_MENU and G.OVERLAY_MENU:get_UIE_by_ID('jimbo_spot') then 
                    Jimbo = Card_Character({x = 0, y = 5})
                    local spot = G.OVERLAY_MENU:get_UIE_by_ID('jimbo_spot')
                    spot.config.object:remove()
                    spot.config.object = Jimbo
                    Jimbo.ui_object_updated = true
                    Jimbo:add_speech_bubble('lq_'..math.random(1,10), nil, {quip = true})
                    Jimbo:say_stuff(5)
                    end
                return true
            end)
        }))
    end

    G.STATE_COMPLETE = true
end
