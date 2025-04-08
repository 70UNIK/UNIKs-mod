SMODS.Blind	{
    key = 'unik_epic_collapse',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true},
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
		-- local stoneCards = 0
        -- if G.deck then 
        --     for i, w in pairs(G.deck.cards) do
        --         if SMODS.has_no_suit(w) then
        --             stoneCards = stoneCards + 1
        --         end
        --     end
        -- end
        -- if stoneCards < 5 then
        --     return false
        -- end
        --maybe its funnier to have it spawn even without stone hands in deck
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
	unik_kill_hand = function(self, cards, hand, handname, check)
		for k, v in ipairs(cards) do
			if not v:norank() and not v:nosuit() then
				return true
			end
		end
	end
}

--Instead of merely debuffing a hand, it will KILL you if you play that hand
function Blind:unik_kill_hand(cards, hand, handname, check)
	if not self.disabled then
		local obj = self.config.blind
		if obj.unik_kill_hand and type(obj.unik_kill_hand) == "function" then
			return obj:unik_kill_hand(cards, hand, handname, check)
		end
	end
end

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
