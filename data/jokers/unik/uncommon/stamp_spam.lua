SMODS.Joker {
    key = 'unik_stamp_spam',
    atlas = 'placeholders',
	pos = { x = 1, y = 0 },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    perishable_compat = true,
	eternal_compat = true,
    demicolon_compat = true,
    immutable = true,
    config = {extra = {triggers = 4}},
    loc_vars = function(self, info_queue, center)
        return { vars = {center.ability.extra.triggers}}
	end,
    calculate = function(self, card, context)
        if context.forcetrigger or (context.before and UNIK.contains_spectrum(context.poker_hands)) and card.ability.extra.triggers > 0 and not context.blueprint and not context.repetition and not context.retrigger_joker then
            if context.scoring_hand then
                for i,v in pairs(context.scoring_hand) do
                    if not v.seal then
                        v:set_seal(
                            SMODS.poll_seal({ guaranteed = true, type_key = "stamp_spam" }),
                            true,
                            false
                        )
                        v:juice_up()
                    end
                end
                card.ability.extra.triggers = card.ability.extra.triggers - 1
                if card.ability.extra.triggers < 1 then
                    selfDestruction(card,"k_extinct_ex",G.C.DARK_EDITION)
                else
                    return{
                        message = card.ability.extra.triggers..'',
                        colour = G.C.DARK_EDITION,
                    }
                end
                
            end
            
        end
    end,
    in_pool = function(self)
		if UNIK.spectrum_played() then
			return true
		end
		return false
	end,
}