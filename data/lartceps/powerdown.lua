--INNOCENSE DOSENT GET YOU FAR!!!!!!!!!!!!
--destroy 50% of jokers, 50% of consumeables, 50% of cards and halve all hand levels and statistics(rounded down), just like GF
function CloneTable(table2)
    local newTable = {}
    for i,v in pairs(table2) do
        table.insert(newTable,v)
    end
    return newTable
end

SMODS.Consumable{
    set = 'unik_lartceps', 
	atlas = 'unik_lartceps',
    cost = 0,
	pos = {x = 2, y = 0},
	key = 'unik_rip_girlfriend',
    config = {},
    can_use = function(self, card)
		return true
	end,
    no_doe = true,
    no_grc = true,
	no_ccd = true,
	use = function(self, card, area, copier)
        local used_consumable = copier or card
        local targetsJokers = {}
        local targetsConsumeables = {} 
        local targetsCards = {}
        local allcards = CloneTable(G.playing_cards)
        local alljokers = CloneTable(G.jokers.cards)
        local allConsumecards = CloneTable(G.consumeables.cards)
        local divideJokers = math.ceil(#G.jokers.cards/2)
        local divideConsume = math.ceil(#G.consumeables.cards/2)
        local divideCards = math.ceil(#G.playing_cards/2)
        if divideCards > 0 then
            while #targetsCards < divideCards do
                local int = pseudorandom('MARIO85', 1, divideCards)
                local sel = allcards[int]
                table.remove(allcards, int)
                table.insert(targetsCards, sel)
            end
        end
        if divideConsume > 0 then
            while #targetsConsumeables < divideConsume do
                local int = pseudorandom('MARIO85', 1, divideConsume)
                local sel = allConsumecards[int]
					table.remove(allConsumecards, int)
					table.insert(targetsConsumeables, sel)
            end
        end
        if divideJokers > 0 then
            while #targetsJokers < divideJokers do
                local int = pseudorandom('MARIO85', 1, divideJokers)
                local sel = alljokers[int]
                table.remove(alljokers, int)
                table.insert(targetsJokers, sel)
            end
        end
        if #targetsCards > 0 then
			for k, v in pairs(targetsCards) do
				v:start_dissolve()
                for j = 1, #G.jokers.cards do
                    eval_card(
                        G.jokers.cards[j],
                        { cardarea = G.jokers, remove_playing_cards = true, removed = v }
                    )
                end
			end
		end
        if #targetsJokers > 0 then
			for k, v in pairs(targetsJokers) do
				v:start_dissolve()
			end
		end
        if #targetsConsumeables > 0 then
			for k, v in pairs(targetsConsumeables) do
				v:start_dissolve()
			end
		end
        delay(0.1)
        --stolen from black hole
        update_hand_text(
				{ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
				{ handname = localize("k_all_hands"), chips = "...", mult = "...", level = "" }
			)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.2,
            func = function()
                play_sound("tarot1")
                used_consumable:juice_up(0.4, 0.25)
                G.TAROT_INTERRUPT_PULSE = true
                return true
            end,
        }))
        update_hand_text({ delay = 0 }, { mult = "/2", StatusText = true, forceRed = true })
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.9,
            func = function()
                play_sound("tarot1")
                used_consumable:juice_up(0.4, 0.25)
                return true
            end,
        }))
        update_hand_text({ delay = 0 }, { chips = "/2", StatusText = true, forceRed = true})
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.9,
            func = function()
                play_sound("tarot1")
                used_consumable:juice_up(0.4, 0.25)
                G.TAROT_INTERRUPT_PULSE = nil
                return true
            end,
        }))
        update_hand_text({ sound = "button", volume = 1.0, pitch = 0.8, delay = 0 }, { level = "/2" })
        if G.GAME.hands then
            for i,v in ipairs(G.handlist) do
                G.GAME.hands[v].level = math.floor(G.GAME.hands[v].level/2)
                G.GAME.hands[v].chips = math.floor(G.GAME.hands[v].chips/2)
                G.GAME.hands[v].mult = math.floor(G.GAME.hands[v].mult/2)
            end
        end
        update_hand_text(
            { sound = "button", volume = 1.0, pitch = 0.8, delay = 0 },
            { mult = 0, chips = 0, handname = "", level = "" }
        )
    end,
    in_pool = function()
		return lartcepsCheck()
	end,
}