--defeating this blind will increase victory requirements by 2 antes.
--Will NOT appear when orbin time or obsidian swarm is active as otherwise you will never win. Also wont appear in endless since its pointless by that point
SMODS.Blind{
    --Hahahahahah no jolly for you
    key = 'unik_green_goalpost',
    config = {},
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 13},
    boss_colour= HEX("00ff00"),
    dollars = 8 ,
    mult = 2,
    in_pool = function()
        --if obsidian orb is mandated as the last blind, disable it from spawning. Also disable if you already win.
        if (G.GAME.won or G.GAME.modifiers.unik_obsidian_showdown or G.GAME.modifiers.unik_obsidian_swarm)then
            return false
        end
        return true
	end,
	set_blind = function(self)
        local text = localize('k_unik_goalpost_start')
        attention_text({
            scale = 0.6, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
        })
	end,
  unik_after_defeat = function(self,chips,blind_size)
      ease_victory_reqs(3)
      --increase by 2 then later decrease by amount if victory.
      G.GAME.unik_goalpost_ante_win_increase = G.GAME.unik_goalpost_ante_win_increase + 3
      G.GAME.unik_moving_the_goalposts = nil
      G.GAME.blind.triggered = true
      G.GAME.blind:wiggle()
      return false
  end
}
--TODO: Legendary Goalpost/ pakotettumaaliviiva (Forced Finish line): sets ante to 666, rounds to 100 and victory requirements to 1 (aka all blinds are finishers). 
-- Never spawns naturally, but after getting two Green Goalposts,
--has a 10% chance to replace Green Goalpost whenever it is pointered in, rerolled to or it spawns naturally, 
--increases by 15% every time green goalpost is obtained.
--Primarily designed to punish goalpost abuse to not trigger straddle (by extending victory reqs to unnatural values)
--Will never spawn in endless
function ease_victory_reqs(mod)
     G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      func = function()
          local ante_UI = G.hand_text_area.ante
          mod = mod or 0
          if mod ~= 0 then
            local text = '+'
          local col = G.C.UNIK_LARTCEPS_INVERSE
          if to_big(mod) < to_big(0) then
              text = '-'
              col = G.C.IMPORTANT
          end
          G.GAME.win_ante = G.GAME.win_ante + mod
        --   G.GAME.round_resets.ante_disp = number_format(G.GAME.round_resets.ante)
          G.GAME.win_ante = Big and (to_number(math.floor(to_big(G.GAME.win_ante)))) or math.floor(G.GAME.win_ante)
          check_and_set_high_score('furthest_ante', G.GAME.round_resets.ante)
          ante_UI.config.object:update()
          G.HUD:recalculate()
          --Popup text next to the chips in UI showing number of chips gained/lost
          attention_text({
            text = text..tostring(math.abs(mod)),
            scale = 1, 
            hold = 0.7,
            cover = ante_UI.parent,
            cover_colour = col,
            align = 'cm',
            })
          --Play a chip sound
            play_sound('highlight2', 0.5, 0.2)
            play_sound('generic1')
          end
          return true
      end
    }))
end