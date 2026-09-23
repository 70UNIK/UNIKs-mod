--Leftmost Trinket is debuffed, it becomes negative on defeat
BLINDSIDE.Joker({
    key = 'unik_blindside_impound_notice',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=23},
    boss_colour = HEX('ff9947'),
    mult = 22,
    base_dollars = 8,
    order = 1,
    cursed = {min = -66},
    active = true,
    blindside_joker = true,
    in_pool = function(self, args)
        if G.GAME.selected_back.effect.center.config.extra then
            if not UNIK.hasBlindside() then return false end
            return true
        else
        return false
        end
    end,
    debuff = {
        akyrs_blind_difficulty = "unik_blindside_cursed",
    },
    calculate = function(self, blind, context)
        if context.setting_blind and not context.disabled then
            blind.active = true
        end
        if not blind.disabled and G.GAME.blind.active then
            if context.debuff_card and context.debuff_card.area == G.jokers and G.GAME.blind.active then
                if context.debuff_card.ability.unik_impounded_blindside then
                    return {
                        debuff = true
                    }
                end
            end
            if context.press_play and G.jokers.cards[1] then
                blind.prepped = true
            end
            if context.hand_drawn then
                if blind.prepped and G.jokers.cards[1] then
                    local jokers = {}
                    for i = 1, #G.jokers.cards do
                        if not G.jokers.cards[i].debuff and not  G.jokers.cards[i].edition then
                            jokers[#jokers + 1] = G.jokers.cards[i]
                        end
                    end
                    if #jokers == 0 then
                        for i = 1, #G.jokers.cards do
                        if not G.jokers.cards[i].debuff and (G.jokers.cards[i].edition and not G.jokers.cards[i].edition.negative) then
                            jokers[#jokers + 1] = G.jokers.cards[i]
                        end
                    end
                    end
                    local _card = pseudorandom_element(jokers, 'impound_notice')
                    if _card then
                        _card.ability.unik_impounded_blindside = true
                        _card:juice_up()
                        blind:wiggle()
                        G.GAME.blind.active = false
                    end
                end
            end
        if context.hand_drawn then
            blind.prepped = nil
        end
        end
    end,
    disable = function(self)
        for _, joker in ipairs(G.jokers.cards) do
            joker.ability.unik_impounded_blindside = nil
        end
    end,
    loc_vars = function (self)
        return {
            vars = {
               3
                
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                3
            }
        }
    end,
})

