--add glittergrid to a random joker, create a significant detriment
SMODS.Consumable {
    key = 'unik_jinx',
    set = 'Spectral',
	atlas = "placeholders",
    pos = { x = 2, y = 2 },
    cost = 4,
    config = {cards = 2 },
    loc_vars = function(self, info_queue, card)
        
         info_queue[#info_queue + 1] = G.P_CENTERS.e_unik_shining_glitter
    end,
    can_use = function(self, card)
         return next(SMODS.Edition:get_edition_cards(G.jokers, true))
    end,
    attributes = {'generation','editions','detriment'},
    use = function(self, card, area, copier)
         local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local eligible_card = pseudorandom_element(editionless_jokers, 'unik_jinx')
                eligible_card:set_edition("e_unik_shining_glitter")
                UNIK.create_detriment({severity = 2,seed = "unik_jinx_detriment" })
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
}
