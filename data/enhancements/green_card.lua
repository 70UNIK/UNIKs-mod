--Considered a club and it's own rank.
--^1.08 Mult, destroyed if played with any suit other than clubs
SMODS.Enhancement {
	atlas = 'unik_enhancements',
	pos = {x = 0, y = 1},
	key = 'unik_green',
	not_stoned = true,
	overrides_base_rank = true, --enhancement do not generate in grim, incantation, etc...
	replace_base_card = true, --So no base chips and no image
    config = { extra = { Emult = 0.08}, immutable = {base_emult = 1.0} },
    weight = 1,
    shatters = true, --lefunny
    force_no_face = true, --true = always face, false = always face
	--NEW! specific_suit suit. Like abstracted!

	unik_specific_suit = "Clubs",
    unik_specific_base_value = "unik_green", --corresponds to normal base_value

    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.Emult + card.ability.immutable.base_emult,localize('Clubs','suits_singular'), localize('Clubs', 'suits_plural')}
        }
    end,
	calculate = function(self, card, context, effect)
		if context.cardarea == G.play and context.main_scoring then
            return {
				e_mult = card.ability.extra.Emult + card.ability.immutable.base_emult,
                colour = G.C.DARK_EDITION,
			}
		end
        if context.destroy_card and context.destroy_card == card and context.cardarea == G.play then
            local suits = unik_get_all_suits()
            for i,v in pairs(G.play.cards) do
                for i = 0, #suits do
                    if v:is_suit(suits[i]) and suits[i] ~= 'Clubs' then
                        return { remove = true }
                    end
                end
            end
		end
        if (context.cardarea == "unscored") and context.destroy_card == card then
            local suits = unik_get_all_suits()
            for i,v in pairs(G.play.cards) do
                for i = 0, #suits do
                    if v:is_suit(suits[i]) and suits[i] ~= 'Clubs' then
                        return { remove = true }
                    end
                end
            end
        end
	end,
}
