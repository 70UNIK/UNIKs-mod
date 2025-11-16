--adda copper seal to 1 card
SMODS.Consumable {
    key = 'unik_lightning',
    set = 'Spectral',
	atlas = "unik_spectrals",
    pos = { x = 3, y = 1 },
    cost = 4,
    config = {mod_conv = "unik_copper_seal", max_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_copper_seal" }
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        for i,v in pairs(G.hand.highlighted) do
            local conv_card = v
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    conv_card:set_seal('unik_copper',nil,true)
                    return true
                end
            }))
        end
        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
}