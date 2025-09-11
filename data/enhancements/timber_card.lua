SMODS.Enhancement {
	atlas = 'unik_enhancements',
	pos = {x = 2, y = 0},
	key = 'unik_timber',
	not_stoned = true,
    config = { extra = { Xlogmultbase = 50,base_odds = 1, break_odds = 3}},
    weight = 1,
    woodbreak = true,
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card,card.ability.extra.base_odds,card.ability.extra.break_odds, 'unik_timber_enhancement')
        return {
            vars = { card.ability.extra.Xlogmultbase,new_numerator, new_denominator }
        }
    end,
	calculate = function(self, card, context, effect)
		if context.cardarea == G.play and context.main_scoring then
            return {
				xlog_mult = card.ability.extra.Xlogmultbase,
                colour = G.C.DARK_EDITION,
			}
		end
        if context.destroy_card and context.destroy_card == card and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, pseudoseed('unik_timber_enhancement'),card.ability.extra.base_odds,card.ability.extra.break_odds, 'unik_timber_enhancement')  then
                return { remove = true }
            end
		end
    
	end,
}

local dissolveHook = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
    local enhancements = SMODS.get_enhancements(self)
    for key, _ in pairs(enhancements) do
        if G.P_CENTERS[key].woodbreak then 
            self:woodBreak()
            return nil
        end
    end
    local ret = dissolveHook(self,dissolve_colours, silent, dissolve_time_fac, no_juice)
    return ret
end

--Gore6 (custom card destruction animation)
function Card:woodBreak()
    local dissolve_time = 1.0
    self.shattered = true
    self.dissolve = 0
    self.dissolve_colours = {{0.7,0.5,0,1.0}}
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
                play_sound("unik_woodBreak", math.random()*0.2 + 0.9,1)
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