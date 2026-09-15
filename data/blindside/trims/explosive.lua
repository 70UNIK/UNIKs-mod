--explosive: destroyed when played, when destroyed, destroys 2 adjacent blinds
SMODS.Seal {
    key = "unik_blindside_explosive",
    atlas = 'unik_legendary_blind_enhancements', 
    pos = { x = 0, y = 3 },
    legendary_atlas = 'unik_legendary_blind_enhancements',
    legendary_atlas_coords = {x = 2, y = 2},
    badge_colour = HEX('FF8836'),
    in_pool = function(self, args)
        return UNIK.hasBlindside()
    end,
    blindside_trim = true,
    pools = {
        ["bld_obj_enhancements"] = true,
    },
    calculate = function(self, card, context)
        if context.before and context.scoring_hand and card.facing ~= 'back' then
            if SMODS.in_scoring(card,context.scoring_hand) then
                card.already_blown_up = true
                card.will_be_destroyed_1 = true
                local index = -1
                for i = 1, #G.play.cards  do
                    if G.play.cards [i] == card then
                        index = i
                        break
                    end
                end
                if index > 1 then
                    local indice = 0
                    repeat
                        G.play.cards[index + indice].already_blown_up = true
                        G.play.cards[index + indice].will_be_destroyed_1 = true
                        if G.play.cards[index + indice].seal and G.play.cards[index + indice].seal == 'unik_blindside_explosive' then
                            indice = indice - 1
                        else
                            break
                        end
                    until (index + indice < 1)
                    
                end
                if index < #G.play.cards then
                    local indice = 0
                    repeat
                        G.play.cards[index + indice].already_blown_up = true
                        G.play.cards[index + indice].will_be_destroyed_1 = true
                        if G.play.cards[index + indice].seal and G.play.cards[index + indice].seal == 'unik_blindside_explosive' then
                            indice = indice + 1
                        else
                            break
                        end
                    until (index + indice > #G.play.cards)
                end
            end
            
        end
        if context.destroy_card and context.destroy_card == card and context.cardarea == G.play and card.facing ~= 'back' then
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
    self:juice_up(2, 0.4)
    self.states.drag.is = true
    self.children.center.pinch.x = true
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
                play_sound("unik_explosion2", math.random()*0.2 + 0.9,1.25)
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