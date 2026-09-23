--rerolls blind to its right to the same hue --> rerolls 2 blinds to its right to the same hue
BLINDSIDE.Blind({
    key = 'unik_blindside_sharp',
    atlas = 'unik_blindside_blinds',
    pos = {x = 5, y = 1},
    config = {
        extra = {
            value = 23,
            blinds = 1,
            blinds_up = 1,
        }},
    hues = {"Blue"},
    always_scores = true,
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.after then
            local enhancement = {}

            local args = {}
            args.guaranteed = true
            local area = context.full_hand
            local enabled = false
            local count = 0
            local cards = {}
            for i = 1, #area do
                if enabled and count < card.ability.extra.blinds then
                    SMODS.ObjectTypes.bld_obj_blindcard_generate:delete_card(area[i].config.center)
                    args.options = G.P_CENTER_POOLS.bld_obj_blindcard_generate
                    args.colors = area[i].ability.extra.hues
                    args.cursed = area[i].config.center.weight == 67
                    enhancement = BLINDSIDE.poll_enhancement(args)
                    SMODS.ObjectTypes.bld_obj_blindcard_generate:inject_card(area[i].config.center)
                    count = count + 1
                    table.insert(cards,area[i])
                end
                if area[i] == card then
                    enabled = true
                end
            end
            if #cards > 0 then
                for i=1, #cards do
                    local percent = 1.15 - (i-0.999)/(#cards-0.998)*0.3
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.3,func = function() cards[i]:flip();play_sound('card1', percent);cards[i]:juice_up(0.3, 0.3);return true end }))
                end
                for i=1, #cards do
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function()
                        local upgrade = cards[i].ability.extra.upgraded
                        cards[i]:set_ability(enhancement)
                        if upgrade then
                            upgrade_blinds({cards[i]}, true, true)
                        end
                        ;return true end }))
                end 
                for i=1, #cards do
                    local percent = 0.85 + (i-0.999)/(#cards-0.998)*0.3
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.3,func = function() cards[i]:flip();play_sound('tarot2', percent, 0.6);cards[i]:juice_up(0.3, 0.3);return true end }))
                end
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                return {
                    message = localize('k_unik_rerolled'),
                    colour = HEX('5d5ea3'),
                }
            end
            
            
        end
    end,
    common = true,
    loc_vars = function(self, info_queue, card)
        
        return {
            vars = {
                card.ability.extra.blinds
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.blinds = card.ability.extra.blinds + card.ability.extra.blinds_up
            card.ability.extra.upgraded = true
        end
    end
})