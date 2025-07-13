--X0.1 mult and chips, no rank and suit, ^2 Blind size when held in hand. Create a random Namta card after play; self destructs
SMODS.Enhancement {
	atlas = 'unik_lartceps',
	pos = {x = 6, y = 1},
	key = 'unik_namta',
    replace_base_card = true,
    no_suit = true,
    no_rank = true,
    always_scores = true,
    config = { extra = { x_mult = 0.1, x_chips = 0.1,blind_size = 1.15} },
    weight = 0,
    immutable = true,
    shatters = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.x_mult, card.ability.extra.x_chips,card.ability.extra.blind_size}
        }
    end,
    in_pool = function(self)
        return false
    end,
	calculate = function(self, card, context, effect)
        if context.before then
            G.GAME.unik_enable_lartcep_spawn = true
        end
		if context.cardarea == G.play and context.main_scoring then
            G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
				local card2 = create_card("unik_lartceps", G.pack_cards, nil, nil, true, nil, nil, "namta")
				card2:add_to_deck()
                card2:start_materialize()
				G.consumeables:emplace(card2)
				return true
			end }))
            -- SMODS.calculate_effect({
            --     message = localize({
			-- 		type = "variable",
			-- 		key = "a_xchips",
			-- 		vars = { number_format(card.ability.extra.x_chips) },
			-- 	}),
			-- 	x_chips = lenient_bignum(card.ability.extra.x_chips),
            --     colour = G.C.CHIPS,
            -- }, card)
            -- return {
            --     message = localize({
			-- 		type = "variable",
			-- 		key = "a_xmult",
			-- 		vars = { number_format(card.ability.extra.x_mult) },
			-- 	}),
            --     Xmult_mod = lenient_bignum(card.ability.extra.x_mult),
            --     colour = G.C.RED,
            -- } 
            
            return {
                message = localize('unik_plus_lartceps'),
                colour = G.C.UNIK_LARTCEPS1,
                card = card
            }
		end
        if context.cardarea == G.hand and context.main_scoring and not context.end_of_round then
            
            G.E_MANAGER:add_event(Event({func = function()
                G.GAME.blind.chips = G.GAME.blind.chips^card.ability.extra.blind_size
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                G.HUD_blind:recalculate(true)
                G.hand_text_area.blind_chips:juice_up()
                play_sound('chips2')
            return true end }))
            return {
                message = localize({
                    type = "variable",
                    key = "a_eblindsize",
                    vars = {
                        number_format(to_big(card.ability.extra.blind_size)),
                    },
                }),
                colour = G.C.UNIK_VOID_COLOR,
                card = card
            }
        end
        if context.after then
            G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
                G.GAME.unik_enable_lartcep_spawn = nil
            				return true
			end }))
        end
        if context.destroy_card == card and context.cardarea == G.play then
            G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
                G.GAME.unik_enable_lartcep_spawn = nil
            				return true
			end }))
			return { remove = true }
		end
	end
}