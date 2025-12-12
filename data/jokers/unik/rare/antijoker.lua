--after 4 rounds, sell this card to add negative to a random joker
SMODS.Joker {
    key = "unik_antijoker",
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    demicoloncompat = true,
    rarity = 3,
    cost = 15,
    atlas = 'unik_rare',
    pos = { x = 2, y = 2 },
    draw = function(self, card, layer)
        if card.config.center.discovered or card.bypass_discovery_center then
             card.children.center:draw_shader('negative', nil, card.ARGS.send_to_shader)
            card.children.center:draw_shader('negative_shine', nil, card.ARGS.send_to_shader)
        end
    end,
    immutable = true,
    config = { extra = { anti_rounds = 0, total_rounds = 5 } },
    loc_vars = function(self, info_queue, card)
        if not card.edition or (card.edition and not card.edition.negative) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		end
        return { vars = { card.ability.extra.total_rounds, card.ability.extra.anti_rounds } }
    end,
    calculate = function(self, card, context)
        if context.selling_self and (card.ability.extra.anti_rounds >= card.ability.extra.total_rounds) and not context.blueprint or context.force_trigger then
            local jokers = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card and (not G.jokers.cards[i].edition or (G.jokers.cards[i].edition and not G.jokers.cards[i].edition.negative))then
                    jokers[#jokers + 1] = G.jokers.cards[i]
                end
            end
            if #jokers > 0 then
                local chosen_joker = pseudorandom_element(jokers, 'antijoker')
                chosen_joker:set_edition({ negative = true }, true)
                return {}
            else
                return { message = localize('k_nope_ex') }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.anti_rounds = card.ability.extra.anti_rounds + 1
            if card.ability.extra.anti_rounds == card.ability.extra.total_rounds then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            return {
                message = (card.ability.extra.anti_rounds < card.ability.extra.total_rounds) and
                    (card.ability.extra.anti_rounds .. '/' .. card.ability.extra.total_rounds) or
                    localize('k_active_ex'),
                colour = G.C.FILTER
            }
        end
    end,
}