--explosive: destroyed when played, when destroyed, destroys 2 adjacent blinds
SMODS.Seal {
    key = "unik_blindside_explosive",
    atlas = 'bld_enhance', 
    pos = { x = 0, y = 3 },
    legendary_atlas = 'unik_legendary_blind_enhancements',
    legendary_atlas_coords = {x = 2, y = 2},
    badge_colour = HEX('FF8836'),
    in_pool = function(self, args)
        return UNIK.hasBlindside()
    end,
    pools = {
        ["bld_obj_enhancements"] = true,
    },
    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card == card and context.cardarea == G.play then
            return { remove = true }
        end 
    end,
    weight = function(self, info_queue, card)
        return 0
    end,
}
--7B5877
function Card:boom_break2()
    if not SMODS.is_playing_card(self) then
        local flags = SMODS.calculate_context({joker_type_destroyed = true, card = self})
        if flags.no_destroy then self.getting_sliced = nil; return false end
    end
    local dissolve_time = 0.7
    self.shattered = true
    self.dissolve = 0
    self.dissolve_colours = {{1,0.6,0,1.0}}
    self:juice_up(3,3)
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
                play_sound("unik_explosion2", math.random()*0.2 + 0.9,0.75)
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
    if self.ability and self.ability.immutable then
        self.ability.immutable.destroyed = nil
    end
    
end