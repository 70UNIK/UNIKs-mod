SMODS.Joker {
    key = "unik_pink_guard",
    atlas = "unik_uncommon",
    rarity = 2,
    cost = 6,
    pos = { x = 9, y = 2 },
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    demicoloncompat = true,
    config = {extra = {mult = 0, diamond_mult = 0.25, nought_mult = 1}},
    pronouns = "he_him",
    loc_vars = function(self, info_queue, center)
        return {
            vars = {center.ability.extra.diamond_mult,localize("Diamonds","suits_singular"),center.ability.extra.nought_mult,localize("unik_Noughts","suits_singular"),center.ability.extra.mult}
        }
	end,
    calculate = function(self, card, context)
        if ((context.joker_main or context.force_trigger) and to_big(card.ability.extra.mult) > to_big(0)) then
			return {
				mult = card.ability.extra.mult,
			}
		end
        if (context.individual and context.cardarea == G.play) then
            if context.other_card:is_suit('Diamonds') then
                
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_value = "diamond_mult",
                    message_key = 'a_mult',
                    message_colour = G.C.MULT,
                })
            end
            if context.other_card:is_suit('unik_Noughts') then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_value = "nought_mult",
                    message_key = 'a_mult',
                    message_colour = G.C.MULT,
                })
            end
            
            
            return {

			}
        end

    end,
    in_pool = function(self)
		return UNIK.suit_in_deck('unik_Noughts') 
	end,
}