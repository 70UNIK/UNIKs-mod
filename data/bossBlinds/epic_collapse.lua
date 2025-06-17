SMODS.Blind	{
    key = 'unik_epic_collapse',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = HEX("444444"),
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 8},
    vars = {},
    dollars = 13,
    jen_dollars = 25, --dollar change with almanac
    mult = 2,
    jen_blind_resize = 1e9,
	get_loc_debuff_text = function(self)
		return localize("k_unik_only_stone")
	end,
	--must be localized
	death_message = 'special_lose_unik_epic_collapse',
	ignore_showdown_check = true,
	in_pool = function(self)
		local stoneCards = 0
        if G.deck then 
            for i, w in pairs(G.deck.cards) do
                if SMODS.has_no_suit(w) then
                    stoneCards = stoneCards + 1
                end
            end
        end
                --in cryptid, at least it only spawns if yoy have at least 5 stone cards
        if stoneCards < 5 and not (SMODS.Mods["jen"] or {}).can_load then
            return false
        end
        --maybe its funnier to have it spawn even without stone hands in deck in almanac
        return CanSpawnEpic()
	end,
	unik_kill_hand = function(self, cards, hand, handname, check)
		for k, v in ipairs(cards) do
			if not SMODS.has_no_rank(v) and not SMODS.has_no_suit(v) then
				return true
			end
		end
	end
}


local killHook = Blind.debuff_hand
function Blind:debuff_hand(cards, hand, handname, check)
	local instakill = self:unik_kill_hand(cards, hand, handname, check)
	if killHook(self,cards, hand, handname, check) == true or instakill == true then
		if instakill == true then
			G.GAME.unik_instant_death_hand = true
		else
			G.GAME.unik_instant_death_hand = nil
		end
		return true
	else
		G.GAME.unik_instant_death_hand = nil
		return false
	end
end
