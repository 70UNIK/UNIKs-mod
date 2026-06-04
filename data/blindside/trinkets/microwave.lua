SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_blindside_microwave',
    atlas = 'unik_trinkets',
    pos = {x = 1, y = 1},
    rarity = 'bld_keepsake',
    cost = 12,
    config = {extra = {active = true,limit = 1}},
    pronouns = "she_her",
    in_pool = function(self, args)
        return UNIK.hasBlindside()
    end,
    loc_vars = function(self, info_queue, center)
        local quote = "k_active_ex"
        if center.ability.extra.active then
            quote = "k_active_ex"
        else
            quote = "k_inactive_ex"
        end
        return { 
            vars = {center.ability.extra.limit,localize(quote),
            colours = { 
                G.C.SECONDARY_SET.Enhanced,center.ability.extra.active and G.C.FILTER or G.C.UI.TEXT_INACTIVE
            }
        } }
    end,
    blueprint_compat = false,
	eternal_compat = true,
    triggering_blacklist = true,
    calculate = function(self, card, context)
        --Allows you to flip if doublesided
        if context.after_cashout and context.cardarea == G.jokers then
            card.ability.extra.active = true
            card.ability.extra.quoteset = 'normal'
            card_eval_status_text(card, "extra", nil, nil, nil, {
                message = localize('k_reset'),
                colour = HEX("d377dc"),
                card=card,
            })

        end
	end,
    unik_can_activate_ability = function(self,card)
        if not card.ability.extra.active then return false end
        local cards = 0
        for i,v in pairs(G.hand.highlighted) do
            if not SMODS.is_eternal(v,card) then
                cards = cards + 1
            end
        end
        return cards > 0 and cards <= card.ability.extra.limit
    end,
    unik_activated_ability = function(self,card) 
        local eternals = 0
        if G.hand and G.hand.highlighted and #G.hand.highlighted > 0 then
            for i, v in pairs(G.hand.highlighted) do
                if  SMODS.is_eternal(v, card) then
                    eternals = eternals + 1
                end
            end
        end
    if G.hand and G.hand.highlighted and #G.hand.highlighted - eternals > 0 then 
        G.CONTROLLER.locks.unik_destroy_selected = true
        local destroyed_cards = {}
        for i, v in pairs(G.hand.highlighted) do
            if not SMODS.is_eternal(v, card) then
                destroyed_cards[#destroyed_cards+1] = v
            end
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
       for i=1, #destroyed_cards do
            G.E_MANAGER:add_event(Event({
                func = function()
                    destroyed_cards[i]:start_dissolve()
                return true
                end
            }))
        end
        delay(0.3)
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_unik_destroyed'), colour = HEX("d377dc"), card = card})
        G.E_MANAGER:add_event(Event({
            delay=0.2,
            func = function()
                G.CONTROLLER.locks.unik_destroy_selected = nil
                card.ability.extra.active = false
                return true
            end
        }))
    else
        error("UH OH!")
    end
    end,

}