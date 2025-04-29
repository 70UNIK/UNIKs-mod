--75% of jokers owned must be common for hand to score
SMODS.Blind	{
    key = 'unik_epic_box',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = HEX("672525"),
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 7},
    vars = {},
    dollars = 13,
    jen_dollars = 25, --dollar change with almanac
    mult = 2,
    jen_blind_resize = 1e9,
    death_message = "special_lose_unik_epic_box",
	ignore_showdown_check = true,
	in_pool = function(self)
        if (G.GAME.modifiers.no_shop_jokers or (G.jokers and G.jokers.config and G.jokers.config.card_limit < 4))then
            return false
        end
		if G.jokers then
			if G.jokers.cards then
				if #G.jokers.cards <= 1 then
					return false
				end
			end
		end
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
    get_loc_debuff_text = function(self)
		return localize('k_unik_common_jokers')
	end,
    debuff_hand = function(self, cards, hand, handname, check)
        local commonCount = 0
        for i,v in pairs(G.jokers.cards) do
            if v.config.center.rarity == 1 then
                commonCount = commonCount + 1
                
            end
        end

        if commonCount < #G.jokers.cards * 0.6 then
            --jiggle non common jokers
            for i,v in pairs(G.jokers.cards) do
                if v.config.center.rarity ~= 1 then
                    v:juice_up(0,0.5)

                end
            end
            return true
        end
        return false
    end
}