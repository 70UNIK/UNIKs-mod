--add finish to 1 selected trinket and create a gore tag
SMODS.Consumable {
    key = 'unik_blindside_mirror',
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
                v:set_edition('e_bld_finish', true)
                return true
            end
        }))
        end
       
        delay(0.6)
        G.E_MANAGER:add_event(Event({
            func = function ()
                add_tag(Tag('tag_unik_blindside_gore'))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
            end
        }))
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS['tag_unik_blindside_gore']
        info_queue[#info_queue + 1] = G.P_CENTERS['e_bld_finish']
        return {
            vars = {
                card.ability.extra.affected
            }
        }
    end
}