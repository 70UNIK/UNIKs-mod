--add +5 Mult and X0.5 Mult to 2 selected Blinds, create a downscale tag
SMODS.Consumable {
    key = 'unik_blindside_augment',
    set = 'bld_obj_ritual',
    atlas = 'placeholders',
	pos = { x = 2, y = 1 },
    config = {
        extra = {affected = 3}},
    use = function(self, card, area)
         local choices = {}
        for key, value in pairs(G.hand.cards) do
            if not value.edition then
                table.insert(choices, value)
            end
        end

        local cards = choose_stuff(choices, card.ability.extra.affected, pseudoseed('bld_augment'))
        for key, value in pairs(cards) do
            G.E_MANAGER:add_event(Event({
                trigger = "before",
                delay = 0.4,
                func = function ()
                    value:set_edition('e_bld_shiny', true)
                    return true
                end
            }))
        end
        delay(0.6)
        G.E_MANAGER:add_event(Event({
            func = function ()
                add_tag(Tag('tag_unik_blindside_downscale'))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
            end
        }))
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS['tag_unik_blindside_downscale']
        info_queue[#info_queue + 1] = G.P_CENTERS['e_bld_shiny']
        return {
            vars = {
                card.ability.extra.affected,
            }
        }
    end,
}