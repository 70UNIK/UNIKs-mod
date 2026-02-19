--Rescore card if scoring and adjacent to a card with another copper seal.
--Literally copper cards but more versatile.
--Spectral: Turing
SMODS.Seal {
    key = 'copper',
    atlas = "unik_seals",
    pos = { x = 0, y = 0 },
    badge_colour = G.C.UNIK_COPPER,
    calculate = function(self, card, context)
        if context.unik_after_effect and context.cardarea and context.cardarea == G.hand  then
            -- print("XXXXXXXXVVVV")
            -- print(context.cardarea.cards)
            local success = false
            for i = 1, #context.cardarea.cards do
                if context.cardarea.cards[i] == card then
                    if i > 1 and context.cardarea.cards[i-1].seal and context.cardarea.cards[i-1].seal == 'unik_copper' and not context.cardarea.cards[i-1].debuff then
                        success = true
                        break
                    end
                    if i < #context.cardarea.cards and context.cardarea.cards[i+1].seal and context.cardarea.cards[i+1].seal == 'unik_copper' and not context.cardarea.cards[i+1].debuff then
                        success = true
                        break
                    end
                end
            end
            if success then
                return {
                    rescore = 1
                }
            end
        end
        if context.unik_after_effect and context.scoring_hand then
            local success = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i] == card then
                    if i > 1 and context.scoring_hand[i-1].seal and context.scoring_hand[i-1].seal == 'unik_copper' and not context.scoring_hand[i-1].debuff then
                        success = true
                        break
                    end
                    if i < #context.scoring_hand and context.scoring_hand[i+1].seal and context.scoring_hand[i+1].seal == 'unik_copper' and not context.scoring_hand[i+1].debuff then
                        success = true
                        break
                    end
                end
            end
            if success then
                return {
                    rescore = 1
                }
            end
        end
       
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
    end,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            G.shared_seals[card.seal].role.draw_major = card
            G.shared_seals[card.seal]:draw_shader('dissolve', nil, nil, nil, card.children.center)
            G.shared_seals[card.seal]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center)
        end
    end,
}
