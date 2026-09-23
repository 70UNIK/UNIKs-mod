--doubles sell value of all owned trinkets per hand
--DYSFUNCTIONALL FOR NOIWE
BLINDSIDE.Joker({
    blindside_joker = true,
    key = 'unik_blindside_rotten_egg',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=26},
    boss_colour = HEX("A0A073"),
    mult = 19,
    base_dollars = 8,
    order = 1,
    cursed = {min = -66},
    active = true,
    in_pool = function(self, args)
        if G.GAME.selected_back.effect.center.config.extra then
            if not UNIK.hasBlindside() then return false end
            return true
        else
        return false
        end
    end,
    debuff = {
        akyrs_blind_difficulty = "unik_blindside_cursed",
    },
    disable = function(self)
    end,
    joker_defeat = function()
    end,
    calculate = function(self, blind, context)
        if context.before and not G.GAME.blind.disabled then
            local triggered = false
             G.E_MANAGER:add_event(Event({
                func = function()
                    for i,v in pairs(G.jokers.cards) do
                        v.ability.extra_value = (v.ability.extra_value or 0) + v.sell_cost
                        v:set_cost()
                        triggered = true
                    end
                    if triggered then
                        G.GAME.blind:wiggle()
                        
                    end
                                    
                    
                    return true
                end
            }))
            
        end
    end,
})