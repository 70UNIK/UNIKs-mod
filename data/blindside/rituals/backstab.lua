--Create a curse tag in exchange for one trinket
SMODS.Consumable {
    key = 'unik_blindside_backstab',
    set = 'bld_obj_ritual',
    atlas = 'placeholders',
	pos = { x = 2, y = 1 },
    config = {
        extra = {
            affected = 1
        }
    },
    can_use = function (self, card)
        if G.jokers and G.jokers.highlighted and #G.jokers.highlighted > 0 and #G.jokers.highlighted <= card.ability.extra.affected then
            return true
        end
        return false
    end,
    use = function(self, card, area)
        for i,v in pairs(G.jokers.highlighted) do
            G.E_MANAGER:add_event(Event({
            func = function ()
                v:start_dissolve()
                v:juice_up(0.8, 0.8)
                play_sound('slice1', 0.96+math.random()*0.08)
                return true
            end
        }))
        end
       
        delay(0.2)
        G.E_MANAGER:add_event(Event({
            func = function ()
                add_tag(Tag('tag_unik_blindside_cursed'))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
            end
        }))
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS['tag_unik_blindside_cursed']
        return {
            vars = {
                card.ability.extra.affected
            }
        }
    end
}