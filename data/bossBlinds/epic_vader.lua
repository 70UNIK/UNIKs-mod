--set the statistics of all jokers to 0.
SMODS.Blind{
    key = 'unik_epic_vader',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 13},
    boss_colour= HEX("2c313a"), 
    dollars = 13,
    jen_dollars = 25, --dollar change with almanac
    mult = 2,
    jen_blind_resize = 1e9,
    death_message = "special_lose_unik_epic_darth_vader",
    ignore_showdown_check = true,
    set_blind = function(self, reset, silent)
        if not reset then
            if G.jokers and G.jokers.cards then
                for i,v in pairs(G.jokers.cards) do
                    G.E_MANAGER:add_event(Event({
                        delay = 0.2,
                        func = function()
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            Cryptid.misprintize(v, { min = 1e-300, max = 1e-300 }, true, true)
                            G.GAME.blind.triggered = true
                            G.GAME.blind:wiggle()
                            v:juice_up(0,0.5)
                            return true
                        end
                    }))
                end
                local text = localize('k_unik_darth_vader_start')
                attention_text({
                    scale = 0.6, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = HEX("2c313a")
                })
            end
        end
    end,
	in_pool = function(self)
        if (G.GAME.modifiers.no_shop_jokers)then
            return false
        end
		if G.jokers then
			if G.jokers.cards then
				if #G.jokers.cards <= 1 then
					return false
				end
			end
		end
        return CanSpawnEpic()
	end,
}

