SMODS.Blind{
    key = 'unik_epic_xenomorph_queen',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 12},
    boss_colour= HEX("1c5607"), 
    dollars = 13,
    jen_dollars = 25, --dollar change with almanac
    mult = 2,
    jen_blind_resize = 1e9,
    ignore_showdown_check = true,
	loc_vars = function(self)
		return { vars = { "" .. ((Cryptid.safe_get(G.GAME, "probabilities", "normal") or 1)), 4 } }
	end,
	collection_loc_vars = function(self)
		return { vars = { "" .. ((Cryptid.safe_get(G.GAME, "probabilities", "normal") or 1)), 4 } }
	end,
    get_loc_debuff_text = function(self)
		return localize("k_unik_debuffed_card_only")
	end,
    death_message = "special_lose_unik_epic_xenomorph",
	unik_kill_hand = function(self, cards, hand, handname, check)
		for k, v in ipairs(cards) do
			if not v.debuff then
				return true
			end
		end
	end,
    set_blind = function(self, reset, silent)
        if not reset then
            G.GAME.unik_xenomorph_debuff = true
            local text = localize('k_unik_xenomorph_start')
            attention_text({
                scale = 0.75, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = HEX("1c5607")
            })
        end
    end,
	in_pool = function(self)
        return CanSpawnEpic()
	end,
    disable = function(self)
        G.GAME.unik_xenomorph_debuff = nil
    end,
    defeat = function(self)
        G.GAME.unik_xenomorph_debuff = nil
    end,
}

--Only permanently debuff when drawn to hand
local permaDebuffEmplace = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
    local vars = permaDebuffEmplace(self,card,location,stay_flipped)
    if G.GAME.unik_xenomorph_debuff then
        if self == G.hand and (pseudorandom(pseudoseed("xenomorph_debuff_chance")) < ((G.GAME.probabilities.normal) / 4)) then
            if G.GAME.blind and G.GAME.blind.in_blind and (G.GAME.blind.name == 'bl_unik_epic_xenomorph_queen' or G.GAME.blind.name == 'cry-Obsidian Orb') then
                G.GAME.blind.triggered = true
                G.GAME.blind:wiggle()
            end
            SMODS.debuff_card(card,true,"unik_xenomorph_debuff_perma")
        end
    end
    return vars
end