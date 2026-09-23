BLINDSIDE.Joker({
    blindside_joker = true,
    key = 'unik_blindside_lily',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=6},
    boss_colour = HEX("d377dc"),
    mult = 16,
    base_dollars = 8,
    order = 1,
    boss = {min = 2},
    active = true,
    death_card = {
        card = 'j_unik_lily_sprunki', 
        mod_card = function(self, card) --used to apply editions and/or stickers
            
        end,
        quotes = {'unik_blindside_lily_lose'},
        say_times = 1,
    },
    calculate = function(self, blind, context)
        if context.before and not G.GAME.blind.disabled then
            
            local destroyed_cards = {}
            local triggered = true
            for z = 1,2 do
                local eligable_cards = {}
                for i,v in pairs(context.full_hand) do
                    if not v.to_be_destroyed_by_lily then
                        eligable_cards[#eligable_cards+1] = v
                    end
                end
                if #eligable_cards > 0 then 
                    local card = pseudorandom_element(eligable_cards, pseudoseed("unik_lily_eat"))
                    destroyed_cards[#destroyed_cards+1] = card
                    card.to_be_destroyed_by_lily = true
                end
                
            end
            if #destroyed_cards > 0 then
                BLINDSIDE.change_fire_amount({amount = 2})
                BLINDSIDE.add_fire()
            end
            
        end
        if context.destroy_card and not G.GAME.blind.disabled then
            if context.destroy_card.to_be_destroyed_by_lily then
                G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0, func = function()
                    G.GAME.blind:wiggle()
                    if SMODS.hand_debuff_source then SMODS.hand_debuff_source:juice_up(0.3,0) else  end
                    return true
                end}))
                return { remove = true }
            end
        end
    end,
})

