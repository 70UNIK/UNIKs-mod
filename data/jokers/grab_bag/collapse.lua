--destroy all played rankless and suitless cards, gain 75 Chips every time a rankless and suitless card is destroyed.
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_collapse',
    atlas = 'unik_grab_bag_jokers',
    pos = { x = 2, y = 0 },
    rarity = "gb_boss",
	-- Modest
    config = { extra = { chips = 0, chip_mod = 60}, },
    cost = 6,
    blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
	demicoloncompat = true,
    discovered = true,
    unlocked = true,

    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.chip_mod,center.ability.extra.chips} }
	end,
    calculate = function(self, card, context)
		if context.forcetrigger then

            return {

                chips = card.ability.extra.chips,
            }
        end
        if context.joker_main and to_big(card.ability.extra.chips) > to_big(0) then
			return {
                chips = card.ability.extra.chips,
            }
		end
        if context.destroy_card and context.cardarea == G.play and SMODS.has_no_rank(context.destroy_card) and SMODS.has_no_suit(context.destroy_card) then
			return { 
                remove = true,
            }
		end
        if context.remove_playing_cards and context.removed and #context.removed > 0 and not context.blueprint then
            local validcards = 0
            for i,v in pairs(context.removed) do
                if SMODS.has_no_rank(v) and SMODS.has_no_suit(v) then
                    validcards = validcards + 1
                end
            end
            SMODS.scale_card(card, {
				ref_table =card.ability.extra,
				ref_value = "chips",
				scalar_value = "custom_scaler",
                scalar_table = {
                    custom_scaler = validcards * card.ability.extra.chip_mod,
                },
				message_key = "a_chips",
				message_colour = G.C.CHIPS,
			})
            				return {

				}
        end
	end,
    in_pool = function(self, args)
        local stoneCards = 0
        if G.deck then 
            for i, w in pairs(G.deck.cards) do
                if SMODS.has_no_suit(w) and SMODS.has_no_rank(w) then
                    stoneCards = stoneCards + 1
                end
            end
        end
        if stoneCards >= 1 then
            return gb_is_blind_defeated("bl_unik_collapse")
        end
        return false
    end,
    set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("GrabBag")[1] }, badges)
    end,
}