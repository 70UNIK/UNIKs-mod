--Retrigger scored 7s 2 times
--Replacement for NSNM for this mod.
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_uniku',
    atlas = 'unik_uncommon',
	pos = { x = 3, y = 2 },
    rarity = 2,
    config = { extra = { repetitions = 2 } },
    cost = 5,
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.repetitions} }
	end,
    pronouns = "he_him",
    calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition and not context.repetition_only then
            if context.other_card:get_id() == 7 then
                return {
                    message = localize('k_again_ex'),
                    repetitions = card.ability.extra.repetitions,
                    colour = G.C.UNIK_UNIK,
                    card = card,
                }
            end
        end
	end
}
