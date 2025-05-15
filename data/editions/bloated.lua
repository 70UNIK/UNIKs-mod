--1 in 3 chance card is destroyed on trigger (regardless of eternal).
SMODS.Sound({
	key = "bloated",
	path = "bloated.ogg",
})
SMODS.Sound({
	key = "bloated_pop",
	path = "bloated_pop.ogg",
})
SMODS.Shader({
    key = "bloated",
    path = "bloated.fs",
})
SMODS.Edition({
	key = "bloated",
	order = 66666,
	weight = 0, -- should not appear normally in stores as its a detrimental one
	shader = "bloated",
	extra_cost = -5, --Its a detrimental edition, hence lower cost
    apply_to_float = true,
	sound = {
		sound = "unik_bloated",
        per = 1,
		vol = 1.3,
	},
    disable_base_shader = true,
    no_shadow = true,
    -- loc_txt = {
	-- 	name = 'Positive',
    --     label = 'Positive',
	-- 	text = {
	-- 		"{C:red}#1#{} #2#"
	-- 	}
	-- },
    in_shop = false,
    badge_colour = G.C.UNIK_SHITTY_EDITION,
	config = { odds = 3},
    loc_vars = function(self, info_queue, card)
		local key = 'e_unik_bloated'
		if card.ability and card.ability.consumeable then
			key = 'e_unik_bloated_consumeable'
		end
        return { key = key, vars = {
				(G.GAME.probabilities.normal),
				self.config.odds,
			}, }
		end,
calculate = function(self, card, context)
		if
			context.cardarea == G.jokers
			and context.post_trigger
			and context.other_card == card --animation-wise this looks weird sometimes
		then
			if
                pseudorandom(pseudoseed("unik_bloated")) < G.GAME.probabilities.normal / self.config.odds
				
			then
				-- this event call might need to be pushed later to make more sense
				G.E_MANAGER:add_event(Event({
					func = function()
                        card:juice_up(3, 0.5)
						card.states.drag.is = true
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:bloated_pop()
								card = nil
								return true
							end,
						}))
						return true
					end,
				}))
			end
		end
		if context.main_scoring and context.cardarea == G.play then
			if
                pseudorandom(pseudoseed("unik_bloated")) < G.GAME.probabilities.normal / self.config.odds
			then
				card.config.will_pop = true
			end
			
		end

		if context.joker_main then
			card.config.trigger = true -- context.edition triggers twice, this makes it only trigger once (only for jonklers)
		end

		if context.after then
			card.config.trigger = nil
		end

		if context.destroying_card and card.config.will_pop and context.destroy_card == card then
			G.E_MANAGER:add_event(Event({
				func = function()
					card.states.drag.is = true
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.3,
						blockable = false,
						func = function()
							G.jokers:remove_card(card)
							card:bloated_pop()
							card = nil
							return true
						end,
					}))
					return true
				end,
			}))
			return { remove = true }
		end
	end,
})

--Gore6 (custom card destruction animation)
function Card:bloated_pop()
    local dissolve_time = 0.4
    self.shattered = true
    self.dissolve = 0
    self.dissolve_colours = {{1,1,1,1}}
    self:juice_up(3, 0.5)
    local childParts = Particles(0, 0, 0,0, {
        timer_type = 'TOTAL',
        timer = 0.007*dissolve_time,
        scale = 0.3,
        speed = 4,
        lifespan = 0.5*dissolve_time,
        attach = self,
        colours = self.dissolve_colours,
        fill = true
    })
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.5*dissolve_time,
        func = (function() childParts:fade(0.15*dissolve_time) return true end)
    }))
    G.E_MANAGER:add_event(Event({
        blockable = false,
        func = (function()
                play_sound("unik_bloated_pop", math.random()*0.2 + 0.9,0.5)
                play_sound('generic1', math.random()*0.2 + 0.9,0.5)
            return true end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'ease',
        blockable = false,
        ref_table = self,
        ref_value = 'dissolve',
        ease_to = 1,
        delay =  0.5*dissolve_time,
        func = (function(t) return t end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.55*dissolve_time,
        func = (function() self:remove() return true end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.51*dissolve_time,
    }))
end
