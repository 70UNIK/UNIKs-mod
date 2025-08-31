-- 1.4x Chips, has it's own suit and is considered a 7.
SMODS.Enhancement {
	atlas = 'unik_enhancements',
	pos = {x = 0, y = 0},
	key = 'unik_pink',
	not_stoned = true,
	overrides_base_rank = true, --enhancement do not generate in grim, incantation, etc...
	replace_base_card = true, --So no base chips and no image
    config = { extra = { Echips = 0.05}, immutable = {base_echips = 1.0} },
    weight = 0,
    shatters = true, --lefunny
    force_no_face = true, --true = always face, false = always face
	--NEW! specific_suit suit. Like abstracted!

	unik_specific_suit = "unik_pink",
	unik_specific_rank = 7, --Corresponds to normal get_id value. MUST BE NUMERICAL is not unik_is_custom_rank
    unik_specific_base_value = "7", --corresponds to normal base_value
    unik_is_custom_rank = false, 

    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.Echips + card.ability.immutable.base_echips}
        }
    end,
    in_pool = function(self)
        return false
    end,
	calculate = function(self, card, context, effect)
		if context.cardarea == G.play and context.main_scoring then
            return {
				e_chips = card.ability.extra.Echips + card.ability.immutable.base_echips,
                colour = G.C.DARK_EDITION,
			}
		end
        if context.destroy_card and context.destroy_card == card and context.cardarea == G.play then
            for i,v in pairs(G.play.cards) do
                if v:get_id() ~= 7 then
                    return { remove = true }
                end
            end
		end
        if (context.cardarea == "unscored") and context.destroy_card == card then
            for i,v in pairs(G.play.cards) do
                if v:get_id() ~= 7 then
                    return { remove = true }
                end
            end
        end
	end,
}
