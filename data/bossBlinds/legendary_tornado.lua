SMODS.Blind{
    key = 'unik_legendary_tornado',
    config = {},
    boss = {min = 1,legendary = true,showdown = true}, 
    atlas = "unik_legendary_blinds",
    pos = {x=0, y=4},
    boss_colour= HEX("600000"), --all legendary blinds will be blood red and black.
    dollars = 13,
    mult = 0.666,
    gameset_config = {
		modest = { disabled = true},
	},
    -- loc_vars = function(self)
	-- 	return { vars = { "" .. ((Cryptid.safe_get(G.GAME, "probabilities", "normal") or 1)), 666 } }
	-- end,
    -- collection_loc_vars = function(self)
	-- 	return { vars = { "" .. ((Cryptid.safe_get(G.GAME, "probabilities", "normal") or 1)), 666 } }
	-- end,
    ignore_showdown_check = true,
    set_blind = function(self, reset, silent)
		if not reset then
            ease_hands_played(-G.GAME.current_round.hands_left)
            ease_hands_played(66)
			G.GAME.blind.unik_tornado_hands_remaining = 3
            G.GAME.blind.unik_tornado_pity = 0
            G.GAME.unik_killed_by_tornado_legendary = true
		end
	end,
    in_pool = function()
        local hasExotic = false
        if not G.jokers or not G.jokers.cards then
			return false
		end
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].config.center.rarity == "cry_exotic" then
                hasExotic = true
            end
        end
        if Cryptid.gameset() ~= "modest" and ((G.GAME.round >= 100 and hasExotic) or G.GAME.modifiers.unik_legendary_at_any_time) then
            return true
        end
        return false
    end,
	debuff_hand = function(self, cards, hand, handname, check)
		-- --Phase 1: Check for 1 in 666 chance of instakill cause its funny
        -- if
        --     not check
        --     and (pseudorandom(pseudoseed("unik_legendary_tornado_instakill")) < ((G.GAME.probabilities.normal) / 666))
        --     and not G.GAME.blind.disabled
        -- then
        --     --deathly debuff text will force an instakill instead the hand not scoring
        --     --print("got sucked up")
        --     G.GAME.unik_deathly_debuff_text = true
        --     G.GAME.blind.triggered = true
        --     return true
        -- end
        --Phase 2: Hand Numerator. 
        --How it works is: Allowed hands/Hands remaining. So if 64 hands do not score first, asumming no instakill, the remaining hands WILL score. It ignores probabilities such as OAS or YN
        --If successful 2 times, then set hands to -666
        if
        not check
        and (pseudorandom(pseudoseed("unik_legendary_tornado_hand_filter")) < ((G.GAME.current_round.hands_left-G.GAME.blind.unik_tornado_hands_remaining)/ G.GAME.current_round.hands_left))
        and not G.GAME.blind.disabled
        and G.GAME.blind.unik_tornado_pity < 22
        then
            G.GAME.blind.unik_tornado_pity = G.GAME.blind.unik_tornado_pity + 1
            G.GAME.unik_deathly_debuff_text = nil
            return true
        elseif not check and not G.GAME.blind.disabled then
            G.GAME.blind.unik_tornado_hands_remaining = G.GAME.blind.unik_tornado_hands_remaining - 1
            local text = G.GAME.blind.unik_tornado_hands_remaining .. localize('k_unik_hands_remaining') 
            attention_text({
                scale = 1, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = G.C.UNIK_EYE_SEARING_RED
            })
            G.GAME.blind.unik_tornado_pity = 0
            -- no hands left? set to -666
            if G.GAME.blind.unik_tornado_hands_remaining <= 0 then
                ease_hands_played(-G.GAME.current_round.hands_left)
                ease_hands_played(-666)
            end
            G.GAME.blind:wiggle()
            return false
        end

		return false
	end,
    disable = function(self)
        G.GAME.unik_deathly_debuff_text = nil
        G.GAME.unik_killed_by_tornado_legendary = nil
    end,
    defeat = function(self)
        G.GAME.unik_deathly_debuff_text = nil
        G.GAME.unik_killed_by_tornado_legendary = nil
    end,
}