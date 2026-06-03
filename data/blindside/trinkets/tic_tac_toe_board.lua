SMODS.Joker({
    key = 'unik_blindside_tic_tac_toe_board',
    atlas = 'unik_trinkets',
    pos = {x = 0, y = 1},
    rarity = 'bld_keepsake',
    cost = 12,
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS['tag_unik_blindside_peak']
        info_queue[#info_queue + 1] = G.P_TAGS['tag_unik_blindside_recursive']
    end,
    in_pool = function(self, args)
        return UNIK.hasBlindside()
    end,
    calculate = function(self, card, context)
        if context.reshuffle then
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.5,
                func = function ()
                    if pseudorandom('toe_board') < 0.5 then
                        add_tag(Tag('tag_unik_blindside_peak'))
                    else
                        add_tag(Tag('tag_unik_blindside_recursive'))
                    end
                    card:juice_up(0.65, 0.65)
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end
            }))
            return {

            }
        end
    end
})