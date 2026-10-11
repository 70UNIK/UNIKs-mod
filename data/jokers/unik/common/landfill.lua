SMODS.Joker {
    key = 'unik_landfill',
    atlas = 'unik_normal_jokers',
	pos = { x = 2, y = 7 },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = true,
    demicoloncompat = true,
    attributes = { 'chips','scaling' },
    config = { extra = {chips = 0, chip_mod = 3, bad_chip_mod = 2}},
    loc_vars = function(self, info_queue, center)
        return { 
            vars = {center.ability.extra.chip_mod,-center.ability.extra.bad_chip_mod,math.max(center.ability.extra.chips,0)},
        }
	end,
    calculate = function(self, card, context)
        --so it can work with phanta better
        if context.individual and context.cardarea == "unscored" and not context.blueprint then
            card.ability.extra.chips = math.max(card.ability.extra.chips,0)
            return {
                func = function()
                    if context.other_card then
                        local juice_card = context.other_card
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                if juice_card then
                                    juice_card:juice_up()
                                end
                                return true
                            end,
                        }))
                    end
                    
                    
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "chips",
                        scalar_value = "chip_mod",
                        message_key = 'a_chips',
                        message_colour = G.C.CHIPS,
                        operation = '+',
                    })
                end
            }
        end
        if context.individual and context.cardarea == G.play and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "bad_chip_mod",
                message_key = 'a_chips_minus',
                message_colour = G.C.CHIPS,
                operation = '-',
            })
            card.ability.extra.chips = math.max(card.ability.extra.chips,0)
            return {

            }
        end
        if context.joker_main or context.force_trigger then
            card.ability.extra.chips = math.max(card.ability.extra.chips,0)
            return {
                chips = math.max(card.ability.extra.chips,0)
            }
        end
    end,
}