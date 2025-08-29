SMODS.Joker{ --chain lightning but for xchips and bonus cards
    key = "unik_chipzel",
    config = {
        extra = {
            x_chips = 1,
            x_chip_mod = 0.1,
        }
    },
    atlas = 'unik_uncommon',
    pos = {
        x = 6,
        y = 1
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = true,
    enhancement_gate = 'm_bonus',
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
        return {vars = {card.ability.extra.x_chips, card.ability.extra.x_chip_mod}}
    end,
    calculate = function(self, card, context)
        if context.before then
            card.ability.extra.x_chips = 1
        end
        if context.forcetrigger then
            card.ability.extra.x_chips = card.ability.extra.x_chips + card.ability.extra.x_chip_mod
            return {

				x_chips = card.ability.extra.x_chips,
				colour = G.C.CHIPS,
			}
        end
        if context.cardarea == G.play and context.individual and SMODS.has_enhancement(context.other_card,'m_bonus') then
            card.ability.extra.x_chips = card.ability.extra.x_chips + card.ability.extra.x_chip_mod
            return {
				x_chips = card.ability.extra.x_chips,
				colour = G.C.CHIPS,
			}
        end
        if context.after then 
            card.ability.extra.x_chips = 1
        end
    end,
}