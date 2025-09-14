--exclusive to plasma deck or if you have sync catalyst, this will prevent chips and mult from being balanced.--All rankless and suitless cards (stone cards) are debuffed
SMODS.Blind{
    key = 'unik_sync_catalyst_fail',
    config = {},

    boss = {min = 1, max = 6666666}, 
    
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 9},
    boss_colour= G.C.DARK_EDITION,
    dollars = 5,
    mult = 1.5,
    pronouns = "it_its",
	--Only appear if you have at least 5 stone cardsSMODS.has_no_suit(v)
    death_message = 'special_lose_unik_the_leak',
	in_pool = function()
		if G.jokers then
			if G.jokers.cards then
				for i = 1,#G.jokers.cards do
                    if G.jokers.cards[i].config.center.key == "j_cry_sync_catalyst" or
                    G.jokers.cards[i].config.center.key == 'j_paperback_milk_tea' or
                     G.jokers.cards[i].config.center.key =='j_paperback_let_it_happen'
                     then
                        return true
                    end
                end
			end
		end
        --Apply effect if with plasma sleeve
        if CardSleeves and G.GAME.selected_sleeve then
            if G.GAME.selected_sleeve == 'sleeve_casl_plasma' then
                return true
            end
        end
        if G.GAME then
            if G.GAME.selected_back.name == "Plasma Deck" then
                return true
            end
        end

        return false
	end,
    recalc_debuff = function(self, card, from_blind)
        if (card.area == G.jokers) and (card.config.center.key == "j_cry_sync_catalyst" or card.config.center.key == 'j_paperback_milk_tea' or card.config.center.key == 'j_paperback_let_it_happen') then
            return true
        end
        return false
	end,
    set_blind = function(self)
		G.GAME.unik_killed_by_leak = true
		--To make it work with obsidian orb, it uses flag
		G.GAME.unik_disable_catalyst = true
	end,
	disable = function(self)
		G.GAME.unik_killed_by_leak = nil
		G.GAME.unik_disable_catalyst = nil
	end,
	defeat = function(self)
		G.GAME.unik_killed_by_leak = nil
		G.GAME.unik_disable_catalyst = nil
	end,
}

local backFX = Back.trigger_effect
function Back:trigger_effect(args)
     if self.name == 'Plasma Deck' and args.context == 'final_scoring_step' and G.GAME.unik_disable_catalyst then
        G.E_MANAGER:add_event(Event({
            func = (function()
                local text = localize('k_unik_plasma_deck_fail')
                attention_text({
                    scale = 1.4, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                })
                G.GAME.blind.triggered = true
                 if SMODS.hand_debuff_source then SMODS.hand_debuff_source:juice_up(0.3,0) else SMODS.juice_up_blind() end
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                    play_sound('tarot2', 0.76, 0.4);return true end}))
                play_sound('tarot2', 1, 0.4)
                G.ROOM.jiggle = G.ROOM.jiggle + 3
                return true
            end)
        }))
        delay(0.6)
        return args.chips, args.mult
    end
    local ret = backFX(self,args)
    return ret
end

if CardSleeves then
    local plasmaSleeve = CardSleeves.Sleeve:get_obj('sleeve_casl_plasma')
    local plasmaSleeveRef = plasmaSleeve.calculate
    plasmaSleeve.calculate = function(self, sleeve, context)
                if self.get_current_deck_key() == "b_plasma" and (context.starting_shop or context.reroll_shop) then
            local hold = 0.6  -- how long to take to ease the costs, and how long to hold the player
            G.CONTROLLER.locks.shop_reroll = true  -- stop controller/mouse from doing anything
            if G.CONTROLLER:save_cardarea_focus('shop_jokers') then G.CONTROLLER.interrupt.focus = true end

            G.E_MANAGER:add_event(Event({
                delay = 0.01,  --  because tags don't immediately apply, sigh
                blockable = true,
                trigger = 'after',
                func = function()
                    local cardareas = {}
                    for _, obj in pairs(G) do
                        if type(obj) == "table" and obj["is"] and obj:is(CardArea) and obj.config.type == "shop" then
                            cardareas[#cardareas+1] = obj
                        end
                    end
                    local total_cost, total_items_for_sale = 0, 0
                    for _, cardarea in pairs(cardareas) do
                        for _, card in pairs(cardarea.cards) do
                            card:set_cost()
                            local has_coupon_tag = card.area and card.ability.couponed and (card.area == G.shop_jokers or card.area == G.shop_booster)
                            if has_coupon_tag then
                                -- tags that set price to 0 (coupon, uncommon, rare, etc)
                                card.cost = 0
                                card.ability.couponed = false
                            end
                            total_cost = total_cost + card.cost
                            total_items_for_sale = total_items_for_sale + 1
                        end
                    end
                    local avg_cost = math.floor((total_cost - 1) / total_items_for_sale)  -- make it always be in favour of the player
                    for _, cardarea in pairs(cardareas) do
                        for _, card in pairs(cardarea.cards) do
                            card.cost = math.max(card.cost, card.base_cost)
                            local mod = avg_cost - card.cost
                            --         table, value,  mod, floor, timer, not_blockable, delay, ease_type
                            ease_value(card,  "cost", mod, nil,   nil,   true,          hold,   "quad")
                            -- card.cost = avg_cost
                            -- card:set_cost()
                        end
                    end
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            play_sound('gong', 1.2, 0.2)
                            play_sound('gong', 1.2*1.5, 0.1)
                            play_sound('tarot1', 1.6, 0.8)
                            attention_text({
                                scale = 1.3,
                                colour = G.C.GOLD,
                                text = localize('k_balanced'),
                                hold = 1.5,
                                align = 'cm',
                                offset = {x = 0, y = -3.5},
                                major = G.play
                            })
                            return true
                        end)
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = hold,
                        func = function()
                            -- allow player to buy cards again, ONLY after having eased prices
                            G.CONTROLLER.interrupt.focus = false
                            G.CONTROLLER.locks.shop_reroll = false
                            G.CONTROLLER:recall_cardarea_focus('shop_jokers')
                            return true
                        end
                    }))
                    return true
                end
            }))
        end

        if self.get_current_deck_key() ~= "b_plasma" and context.context == 'final_scoring_step' then
            if G.GAME.unik_disable_catalyst then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    local text = localize('k_unik_plasma_deck_fail')
                    attention_text({
                        scale = 1.4, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                    })
                    G.GAME.blind.triggered = true
                     if SMODS.hand_debuff_source then SMODS.hand_debuff_source:juice_up(0.3,0) else SMODS.juice_up_blind() end
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                            play_sound('tarot2', 0.76, 0.4);return true end}))
                        play_sound('tarot2', 1, 0.4)
                    G.ROOM.jiggle = G.ROOM.jiggle + 3
                    return true
                end)
            }))
                delay(0.6)
                return context.chips, context.mult
            end
            -- cannot use `context.final_scoring_step` and `return {balance = true}` because it doesn't have the fancy animations
            -- copy-paste from plasma deck
            local tot = context.chips + context.mult
            context.chips = math.floor(tot/2)
            context.mult = math.floor(tot/2)
            update_hand_text({delay = 0}, {mult = context.mult, chips = context.chips})

            G.E_MANAGER:add_event(Event({
                func = (function()
                    play_sound('gong', 0.94, 0.3)
                    play_sound('gong', 0.94*1.5, 0.2)
                    play_sound('tarot1', 1.5)
                    ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
                    ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
                    attention_text({
                        scale = 1.4, text = localize('k_balanced'), hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        blocking = false,
                        delay =  4.3,
                        func = (function()
                                ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
                                ease_colour(G.C.UI_MULT, G.C.RED, 2)
                            return true
                        end)
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        blocking = false,
                        no_delete = true,
                        delay =  6.3,
                        func = (function()
                            G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
                            G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
                            return true
                        end)
                    }))
                    return true
                end)
            }))

            delay(0.6)
            return context.chips, context.mult
        end
    end
end