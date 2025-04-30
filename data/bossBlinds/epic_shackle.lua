SMODS.Blind{
    key = 'unik_epic_shackle',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 14},
    boss_colour= HEX("28285d"), 
    dollars = 13,
    jen_dollars = 25, --dollar change with almanac
    mult = 2,
    jen_blind_resize = 1e9,
    death_message = "special_lose_unik_epic_shackle",
    ignore_showdown_check = true,
    loc_vars = function(self)
		return { vars = { ((SMODS.Mods["jen"] or {}).can_load and localize('k_unik_shackle1')) or localize('k_unik_shackle2')} }
	end,
	collection_loc_vars = function(self)
		return { vars = { ((SMODS.Mods["jen"] or {}).can_load and localize('k_unik_shackle1')) or localize('k_unik_shackle2')} }
	end,
    set_blind = function(self, reset, silent)
        if not reset then
            if G.jokers and G.jokers.cards then
                local negativeJokers = 0
                local emptySlots = G.jokers.config.card_limit - #G.jokers.cards
                for i,v in pairs(G.jokers.cards) do
                    if v.edition and v.edition.key == "e_negative" then
                        v.ability.shackle_marked_for_destruction = true
                        negativeJokers = negativeJokers + 1
                    end
                end
                for i,v in pairs(G.jokers.cards) do
                    if v.ability.shackle_marked_for_destruction then
                        G.E_MANAGER:add_event(Event({
                            delay = 0.2,
                            func = function()
                                v:start_dissolve()
                                G.GAME.blind.triggered = true
                                G.GAME.blind:wiggle()
                                return true
                            end
                        }))
                    end
                end
                if (negativeJokers * emptySlots) > 0 then
                    G.GAME.unik_original_size = negativeJokers * emptySlots
                    G.hand:change_size(-negativeJokers * emptySlots)
                    if G.jokers.change_size_absolute then
                        G.jokers:change_size_absolute(- (negativeJokers * emptySlots))
                    else
                        G.jokers.config.card_limit = G.jokers.config.card_limit - (negativeJokers * emptySlots)
                    end
                    G.GAME.blind.triggered = true
                    G.GAME.blind:wiggle()
                end
                for i,v in pairs(G.consumeables.cards) do
                    if v.edition and v.edition.key == "e_negative" then
                        v.ability.shackle_marked_for_destruction = true
                    end
                end
                for i,v in pairs(G.consumeables.cards) do
                    if v.ability.shackle_marked_for_destruction then
                        G.E_MANAGER:add_event(Event({
                            delay = 0.2,
                            func = function()
                                v:start_dissolve()
                                G.GAME.blind.triggered = true
                                G.GAME.blind:wiggle()
                                return true
                            end
                        }))
                    end
                end
                for i,v in pairs(G.deck.cards) do
                    if v.edition and v.edition.key == "e_negative" then
                        v.ability.shackle_marked_for_destruction = true
                    end
                end
                for i,v in pairs(G.deck.cards) do
                    if v.ability.shackle_marked_for_destruction then
                        G.E_MANAGER:add_event(Event({
                            delay = 0.2,
                            func = function()
                                v:start_dissolve()
                                G.GAME.blind.triggered = true
                                G.GAME.blind:wiggle()
                                return true
                            end
                        }))
                    end
                end
            end
        end
    end,
	disable = function(self)
        if not (SMODS.Mods["jen"] or {}).can_load and G.GAME.unik_original_size then
            G.hand:change_size(G.GAME.unik_original_size)
            G.jokers.config.card_limit = G.jokers.config.card_limit + G.GAME.unik_original_size
        end
	end,
	defeat = function(self)
        if not (SMODS.Mods["jen"] or {}).can_load and G.GAME.unik_original_size then
            G.hand:change_size(G.GAME.unik_original_size)
            G.jokers.config.card_limit = G.jokers.config.card_limit + G.GAME.unik_original_size
        end
	end,
	in_pool = function(self)
        if G.GAME.modifiers.cry_force_edition and G.GAME.modifiers.cry_force_edition == "negative" then
			return false
		end
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
            return (#Cryptid.advanced_find_joker(nil, nil, "e_negative", nil, true) ~= 0 or G.jokers.config.card_limit - #G.jokers.cards > 0)
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
            return (G.GAME.round > 50 and hasExotic and Cryptid.gameset() ~= "modest" and (#Cryptid.advanced_find_joker(nil, nil, "e_negative", nil, true) ~= 0 or G.jokers.config.card_limit - #G.jokers.cards > 0)) --only appear after round 50 in mainline cryptid, and you have an exotic at hand
        end
	end,
}