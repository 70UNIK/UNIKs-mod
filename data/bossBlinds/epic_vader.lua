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
        --maybe its funnier to have it spawn even without stone hands in deck in almanac
        if G.GAME.modifiers.unik_legendary_at_any_time then
            return true
        end
        if (SMODS.Mods["jen"] or {}).can_load then
            return G.GAME.round > Jen.config.ante_threshold * 2
        else

            local hasExotic = false
            if not G.jokers or not G.jokers.cards then
                return false
            end
            
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.rarity == "cry_exotic" then
                    hasExotic = true
                end
            end
            return (G.GAME.round > 50 and hasExotic and Cryptid.gameset() ~= "modest") --only appear after round 50 in mainline cryptid, and you have an exotic at hand
        end
	end,
}

