SMODS.Blind{
    key = 'unik_epic_shackle',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 14},
    boss_colour= HEX("28285d"), 
    dollars = 13,
    mult = 2,
    death_message = "special_lose_unik_epic_shackle",
    ignore_showdown_check = true,
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
                if (negativeJokers + emptySlots) > 0 then
                    G.GAME.unik_original_size = negativeJokers + emptySlots
                    G.hand:change_size(- (negativeJokers + emptySlots))
                    if G.jokers.change_size_absolute then
                        G.jokers:change_size_absolute(- (negativeJokers + emptySlots))
                    else
                        G.jokers.config.card_limit = G.jokers.config.card_limit - (negativeJokers + emptySlots)
                    end
                    G.GAME.blind.triggered = true
                    G.GAME.blind:wiggle()
                end
                -- for i,v in pairs(G.consumeables.cards) do
                --     if v.edition and v.edition.key == "e_negative" then
                --         v.ability.shackle_marked_for_destruction = true
                --     end
                -- end
                -- for i,v in pairs(G.consumeables.cards) do
                --     if v.ability.shackle_marked_for_destruction then
                --         G.E_MANAGER:add_event(Event({
                --             delay = 0.2,
                --             func = function()
                --                 v:start_dissolve()
                --                 G.GAME.blind.triggered = true
                --                 G.GAME.blind:wiggle()
                --                 return true
                --             end
                --         }))
                --     end
                -- end
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
        G.hand:change_size(G.GAME.unik_original_size)
        G.jokers.config.card_limit = G.jokers.config.card_limit + G.GAME.unik_original_size
        G.GAME.unik_original_size = nil
	end,
	defeat = function(self)
        G.hand:change_size(G.GAME.unik_original_size)
        G.jokers.config.card_limit = G.jokers.config.card_limit + G.GAME.unik_original_size
        G.GAME.unik_original_size = nil
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
        if not G.jokers or not G.jokers.cards then
            return false
        end
        if #Cryptid.advanced_find_joker(nil, nil, "e_negative", nil, true) ~= 0 or G.jokers.config.card_limit - #G.jokers.cards > 0 then
            return CanSpawnEpic()
        end
        return false
	end,
}