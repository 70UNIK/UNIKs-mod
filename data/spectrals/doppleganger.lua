--destroys the leftmost destructible joker then copies a random joker and creates a severe detriment, 
SMODS.Consumable {
    key = 'unik_doppleganger',
    set = 'Spectral',
	atlas = "placeholders",
    pos = { x = 2, y = 2 },
    cost = 4,
    config = {cards = 2 },
    loc_vars = function(self, info_queue, card)
        
        local main_end = {}
        if G.jokers and G.jokers.cards then
            for _, joker in ipairs(G.jokers.cards) do
                if joker.edition and joker.edition.negative then
                    info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
                    localize { type = 'other', key = 'remove_negative', nodes = main_end, vars = {} }
                    break
                end
            end
        end
        return { vars = {2 }, main_end = main_end[1] }
    end,
    can_use = function(self, card)
        local valid_jokers = {}
        local valid_copies = {}
        local valid_negatives = {}
        local blacklist_index = -1
        for i= 1, #G.jokers.cards  do
            local v= G.jokers.cards[i]
            if not SMODS.is_eternal(v, card) then
                if v.edition and v.edition.negative then
                    valid_negatives[#valid_negatives+1] = v
                    blacklist_index = i
                    break
                else
                    valid_jokers[#valid_jokers+1] = v
                    blacklist_index = i
                    break
                end
            end 
        end
        for i = 1, #G.jokers.cards do
            if i ~= blacklist_index then
                valid_copies[#valid_copies+1] = G.jokers.cards[i]
            end
        end
        return (#valid_jokers > 0 or (#valid_negatives > 0 and #G.jokers.cards < G.jokers.config.card_limit)) and #valid_copies > 0
    end,
    attributes = {'generation','joker','destroy_card','detriment'},
    use = function(self, card, area, copier)
        local copyable_jokers = {}
        local destroyable_joker = {}
        for i= 1, #G.jokers.cards do
            if not SMODS.is_eternal(G.jokers.cards[i], card) then
                G.jokers.cards[i].to_destroy = true
                destroyable_joker[#destroyable_joker+1] = G.jokers.cards[i]

                break
            end
        end
        for i,v in pairs(G.jokers.cards) do
            if not v.to_destroy then
                copyable_jokers[#copyable_jokers+1] = v
            end
        end
        local chosen_joker = pseudorandom_element(copyable_jokers, 'unik_doppleganger_copy')
        local _first_dissolve = nil
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.75,
            func = function()
                for _, joker in ipairs(destroyable_joker) do
                    joker.to_destroy = nil
                    joker:start_dissolve(nil, _first_dissolve)
                    
                    _first_dissolve = true
                end
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.4,
            func = function()
                local copied_joker = SMODS.copy_card(chosen_joker,
                    { strip_edition = chosen_joker.edition and chosen_joker.edition.negative })
                copied_joker:start_materialize()
                return true
            end
        }))
        --  G.E_MANAGER:add_event(Event({
        --     trigger = 'before',
        --     delay = 0.4,
        --     func = function()
        --         UNIK.create_detriment({severity = 2,seed = "unik_doppleganger_detriment_sig" })
        --         return true
        --     end
        -- }))
         G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.4,
            func = function()
                UNIK.create_detriment({severity = 3,seed = "unik_doppleganger_detriment_sev" })
                return true
            end
        }))

    end,
}