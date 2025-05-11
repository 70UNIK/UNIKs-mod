--epic arm but somehow worse
--set levels and mult of all hands to zero, but chips becomes negative. THe only way to counter this is with Echip jokers and theres exactly 3 (pi, alice, unik)
SMODS.Consumable{
    set = 'unik_lartceps', 
	atlas = 'unik_lartceps',
    cost = 0,
	pos = {x = 3, y = 0},
	key = 'unik_brethren_moon',
    config = { extra = { odds = 5 } },
    can_use = function(self, card)
		return true
	end,
    no_doe = true,
    no_grc = true,
	no_ccd = true,
	use = function(self, card, area, copier)
        local used_consumable = copier or card
        -- G.GAME.hands[G.FUNCS.get_poker_hand_info(G.hand.highlighted)].mult = G.GAME.hands[G.FUNCS.get_poker_hand_info(
		-- 	G.hand.highlighted
		-- )].mult + #G.jokers.cards
		-- G.hand:unhighlight_all()
        --stolen from black hole
        update_hand_text(
				{ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
				{ handname = localize("k_all_hands"), chips = "...", mult = "...", level = "" }
			)
        delay(1.3)
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
        delay(1.3)
        update_hand_text({ delay = 0 }, { mult = "=0", StatusText = true, forceRed = true })
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.9,
            func = function()
                play_sound("tarot1")
                used_consumable:juice_up(0.4, 0.25)
                return true
            end,
        }))
        delay(1.3)
        update_hand_text({ delay = 0 }, { chips = "x(-1)", StatusText = true, forceRed = true})
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
        update_hand_text({ sound = "button", volume = 1.0, pitch = 0.8, delay = 0 }, { level = "=0" })
        delay(1.3)
        if G.GAME.hands then
            for i,v in ipairs(G.handlist) do
                local negativeChips = G.GAME.hands[v].chips
                level_up_hand(used_consumable, v, true, -G.GAME.hands[v].level)
                G.GAME.hands[v].chips = -math.abs(negativeChips) --ALWAYS NEGATIVE!
                G.GAME.hands[v].mult = 0
            end
        end
        update_hand_text(
            { sound = "button", volume = 1.0, pitch = 0.8, delay = 0 },
            { mult = 0, chips = 0, handname = "", level = "" }
        )
    end
}

SMODS.DrawStep({
	key = "lartceps_shader",
	order = 5,
	func = function(self)
		if self.ability.set == "unik_lartceps" and (self.config.center.discovered or self.bypass_discovery_center) then
            self.children.center:draw_shader('negative_shine', nil, self.ARGS.send_to_shader)
        end
	end,
	conditions = { vortex = false, facing = "back" },
})