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
    mult = 2,
    death_message = "special_lose_unik_epic_box",
	ignore_showdown_check = true,
    debuff = {
        akyrs_blind_difficulty = "epic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_unskippable_blind = true,
    },
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
        return CanSpawnEpic()
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