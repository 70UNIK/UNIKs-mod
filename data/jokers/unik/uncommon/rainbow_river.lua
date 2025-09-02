--LAST TILE: Add Mosaic to all scored cards on final hand, self destructs.
SMODS.Joker {
    key = 'unik_rainbow_river',
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
                    if not v.edition then
                        local edition = poll_edition('UNIK_rainbow_river'..G.GAME.round_resets.ante, 2, true,true)
                        v:set_edition(edition, true,nil, true)
                    end
                end
                card.ability.extra.triggers = card.ability.extra.triggers - 1
                if card.ability.extra.triggers < 1 then
                    selfDestruction(card,"k_unik_dried_up",G.C.DARK_EDITION)
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