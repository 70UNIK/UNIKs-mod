--gains X0.1 Mult every time a probability FAILS.
--Secret: If a probability fails 32 times in a row, become megatron
--After becoming megatron, all D16 instances become Eternal Megatrons and D16 is ba
SMODS.Joker {
    key = 'unik_D16',
    atlas = 'unik_uncommon',
	pos = { x = 5, y = 2 },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = false,
    demicolon_compat = true,
    config = {
		extra = { x_mult = 1, x_mult_mod = 0.075, },
        immutable = {funny = 0, funny_limit = 32, destroyed = false},
	},
    loc_vars = function(self, info_queue, center)
		return { vars = {tostring(center.ability.extra.x_mult_mod),tostring(center.ability.extra.x_mult),center.ability.immutable.funny, center.ability.immutable.funny_limit} }
	end,
    pronouns = "it_its",
    pools = {["Dice"] = true},
    in_pool = function()
		return not G.GAME.d16_boom_boom
	end,
    calculate = function(self, card, context)
		if context.pseudorandom_result and not context.result and not context.blueprint and not card.ability.immutable.destroyed then
            SMODS.scale_card(card, {
				ref_table =card.ability.extra,
				ref_value = "x_mult",
				scalar_value = "x_mult_mod",
				message_key = "a_xmult",
				message_colour = G.C.MULT,
			})
            if not context.retrigger_joker and not context.repetition then
                card.ability.immutable.funny = card.ability.immutable.funny + 1
            end         
            if card.ability.immutable.funny >= card.ability.immutable.funny_limit then
                card.ability.immutable.destroyed = true
                G.GAME.d16_boom_boom = true
                if not G.GAME.banned_keys then
                    G.GAME.banned_keys = {}
                end -- i have no idea if this is always initialised already tbh
                if not G.GAME.cry_banished_keys then
                    G.GAME.cry_banished_keys = {}
                end -- 
                G.GAME.cry_banished_keys['j_unik_D16'] = true
                 G.E_MANAGER:add_event(Event({
                    trigger="immediate",
                    func = function()
                        --Dissolving
                            card.T.r = -0.2
                            card:juice_up(2, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            card:boom_break()
                            local card2 = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_unik_megatron")
                            card2.ability.eternal = true
                            card2:add_to_deck()
                            G.jokers:emplace(card2)
                            card2:juice_up(0.3, 0.5)
                        
                        return true
                    end
                }))
                return{
                    message = localize("k_unik_D16_boom"),
                    colour = G.C.UNIK_EYE_SEARING_RED,
                }
            end
            return {
                
            }
        end
        if context.pseudorandom_result and context.result and not context.blueprint and not context.retrigger_joker and not card.ability.immutable.destroyed then
            card.ability.immutable.funny = 0
        end
        if not card.ability.immutable.destroyed and ((context.joker_main or context.forcetrigger) and (to_big(card.ability.extra.x_mult) > to_big(1))) then
            return {
                x_mult = card.ability.extra.x_mult,
                card = card,
            }
        end
	end,
}

function Card:boom_break()
    local dissolve_time = 0.7
    self.shattered = true
    self.dissolve = 0
    self.dissolve_colours = {{1,0.6,0,1.0}}
    self:juice_up()
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
                play_sound("unik_explosion1", math.random()*0.2 + 0.9,0.5)
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