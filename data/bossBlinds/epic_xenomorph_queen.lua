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