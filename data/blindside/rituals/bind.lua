--Create a addition and a multiplication tag, create a handcuffs tag
SMODS.Consumable {
    key = 'unik_blindside_bind',
    set = 'bld_obj_ritual',
    atlas = 'placeholders',
	pos = { x = 2, y = 1 },
    config = {},
    can_use = function (self, card)
        return true
    end,
    use = function(self, card, area)
         G.E_MANAGER:add_event(Event({
            func = function ()
                add_tag(Tag('tag_unik_blindside_multiplicative'))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
            end
        }))
         G.E_MANAGER:add_event(Event({
            func = function ()
                add_tag(Tag('tag_bld_additive'))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
            end
        }))
        delay(0.6)
        G.E_MANAGER:add_event(Event({
            func = function ()
                add_tag(Tag('tag_unik_blindside_handcuffs'))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
            end
        }))
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS['tag_unik_blindside_multiplicative']
        info_queue[#info_queue + 1] = G.P_TAGS['tag_bld_additive']
        info_queue[#info_queue + 1] = G.P_TAGS['tag_unik_blindside_handcuffs']
    end,
}