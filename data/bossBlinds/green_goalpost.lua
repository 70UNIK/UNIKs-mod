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
		G.GAME.unik_moving_the_goalposts = true
	end,
	disable = function(self)
		G.GAME.unik_moving_the_goalposts = nil
	end,
	defeat = function(self)
		G.GAME.unik_moving_the_goalposts = nil
	end,
}
--TODO: Legendary Goalpost/ pakotettumaaliviiva (Forced Finish line): sets ante to 666, rounds to 100 and victory requirements to 1 (aka all blinds are finishers). 
-- Never spawns naturally, but after getting two Green Goalposts,
--has a 10% chance to replace Green Goalpost whenever it is pointered in, rerolled to or it spawns naturally, 
--increases by 15% every time green goalpost is obtained.
--Primarily designed to punish goalpost abuse to not trigger straddle (by extending victory reqs to unnatural values)
--Will never spawn in endless