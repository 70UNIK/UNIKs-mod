
SMODS.Enhancement:take_ownership("m_steel",{
    metalbreak = {colour = {215/255,228/255,245/255,1.0}},
}, true)
SMODS.Enhancement:take_ownership("m_gold",{
    metalbreak = {colour = {255/255,208/255,129/255,1.0}},
}, true)
SMODS.Enhancement:take_ownership("m_stone",{
    rockbreak = true,
}, true)
SMODS.Enhancement:take_ownership("m_ortalab_ore",{
    rockbreak = {colour = {91/255,122/255,128/255,1.0}},
}, true)
--rgb(91, 122, 128)
SMODS.Enhancement:take_ownership("m_phanta_marblecard",{
    rockbreak = {colour = {250/255,250/255,250/255,1.0}},
}, true)
SMODS.Enhancement:take_ownership("m_aij_ice",{
    shatters = true,
}, true)
SMODS.Enhancement:take_ownership("m_ortalab_rusty",{
    metalbreak = {colour = {255/255,183/255,129/255,1.0}},
}, true)

SMODS.Enhancement:take_ownership("m_akyrs_item_box",{
    shatters = true,
}, true)

--rgb(251, 189, 50)
SMODS.Enhancement:take_ownership("m_akyrs_hatena",{
    metalbreak = {colour = {51/255,189/255,50/255,1.0}},
}, true)

SMODS.Enhancement:take_ownership("m_akyrs_brick_card",{
    rockbreak = {colour = {123/255,84/255,60/255,1.0}},
}, true)
--rgb(123, 84, 60)

--rgb(227, 130, 108)
SMODS.Enhancement:take_ownership("m_phanta_coppergratefresh",{
    metalbreak = {colour = {227/255,130/255,108/255,1.0}},
}, true)
--rgb(157, 132, 102)
SMODS.Enhancement:take_ownership("m_phanta_coppergrateexposed",{
    metalbreak = {colour = {157/255,132/255,102/255,1.0}},
}, true)
--rgb(109, 161, 113)
SMODS.Enhancement:take_ownership("m_phanta_coppergrateweathered",{
    metalbreak = {colour = {109/255,161/255,113/255,1.0}},
}, true)
--rgb(81, 164, 135)
SMODS.Enhancement:take_ownership("m_phanta_coppergrateoxidised",{
    metalbreak = {colour = {81/255,164/255,135/255,1.0}},
}, true)
--rgb(255, 209, 99)
SMODS.Enhancement:take_ownership("m_mf_brass",{
    metalbreak = {colour = {255/255,209/255,99/255,1.0}},
}, true)

SMODS.Joker:take_ownership("j_steel_joker",{
    metalbreak = {colour = {215/255,228/255,245/255,1.0}},
}, true)
SMODS.Enhancement:take_ownership("m_aij_wood",{
    woodbreak = true,
}, true)
SMODS.Enhancement:take_ownership("m_artb_wood",{
    woodbreak = true,
}, true)
SMODS.Enhancement:take_ownership("m_entr_disavowed",{ --its cursed ya know, thees something more to it than just that...
    gore6break = true,
}, true)
SMODS.Enhancement:take_ownership("m_entr_flesh",{
    gore6break = true,
}, true)

SMODS.Enhancement:take_ownership("m_bld_tablet",{
    rockbreak = true,
}, true)



local dissolveHook = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
    local enhancements = SMODS.get_enhancements(self)
    for key, _ in pairs(enhancements) do
        if G.P_CENTERS[key].woodbreak then 
            self:woodBreak()
            return nil
        elseif G.P_CENTERS[key].metalbreak then 
            self:metalBreak(type(G.P_CENTERS[key].metalbreak) == "table" and G.P_CENTERS[key].metalbreak.colour or nil)
            return nil
        elseif G.P_CENTERS[key].rockbreak then 
            self:rockBreak(type(G.P_CENTERS[key].rockbreak) == "table" and G.P_CENTERS[key].rockbreak.colour or nil)
            return nil
        elseif G.P_CENTERS[key].gore6break then 
            self:gore6_break()
            return nil
        end
    end
    if self.config.center.woodbreak then 
        self:woodBreak()
        return nil
    elseif self.config.center.metalbreak then 
        self:metalBreak(self.config.center.metalbreak.colour or nil)
        return nil
    elseif self.config.center.rockbreak then 
        self:rockBreak(type(self.config.center.rockbreak) == "table" and self.config.center.rockbreak.colour or nil)
        return nil
    elseif self.config.center.gore6break then 
            self:gore6_break()
            return nil
        end
    if self.to_be_destroyed_by_lily then
        self:gore6_break()
        return nil
    end
    local ret = dissolveHook(self,dissolve_colours, silent, dissolve_time_fac, no_juice)
    return ret
end



function Card:metalBreak(colour)
    local dissolve_time = 1.0
    self.shattered = true
    self.dissolve = 0
    self.dissolve_colours = {colour or {215/255,228/255,245/255,1.0}}
    self.dissolve_colours2 = {{255/255,145/255,0/255,1.0}}
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
    local sparkParts = Particles(0, 0, 0,0, {
        timer_type = 'TOTAL',
        timer = 0.007*dissolve_time,
        scale = 0.15,
        speed = 3,
        lifespan = 0.5*dissolve_time,
        attach = self,
        colours = self.dissolve_colours2,
        fill = true
    })
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.5*dissolve_time,
        func = (function() childParts:fade(0.15*dissolve_time) return true end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.5*dissolve_time,
        func = (function() sparkParts:fade(0.15*dissolve_time) return true end)
    }))
    G.E_MANAGER:add_event(Event({
        blockable = false,
        func = (function()
                play_sound("unik_metalbreak", math.random()*0.2 + 0.9,1.25)
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

function Card:rockBreak(colour)
    local dissolve_time = 1.0
    self.shattered = true
    self.dissolve = 0
    self.dissolve_colours = {colour or {0.6,0.6,0.63,1.0}}
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
                play_sound("unik_rock_break", math.random()*0.2 + 0.9,1)
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