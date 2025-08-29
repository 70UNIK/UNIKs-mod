--^1.2 Mult, only if played hand only contains a single king of spades
SMODS.Joker {
    key = 'unik_lone_despot',
    atlas = 'unik_epic',
    rarity = 'cry_epic',
	pos = { x = 1, y = 0 },
    cost = 10,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    demicoloncompat = true,
    config = { extra = { Emult = 0.2}, immutable = {base_emult = 1.0} },
    gameset_config = {
		modest = { extra = { Emult = 0.1}, immutable = {base_emult = 1.0} },  
	},
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.Emult + center.ability.immutable.base_emult,localize('Spades', 'suits_plural')} }
	end,
    --Only spawn if you have at least 1 king of spades in deck
    in_pool = function(self)
        for i,v in pairs(G.playing_cards) do
            if v:is_suit("Spades") and v:get_id() == 13 then
                return true
            end
        end
        return false
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
             return {
                e_mult = card.ability.extra.Emult + card.ability.immutable.base_emult,
                colour = G.C.DARK_EDITION,
            }
        end
        if context.individual and context.cardarea == G.play and #context.full_hand == 1 then
            if context.full_hand[1]:is_suit("Spades") and context.full_hand[1]:get_id() == 13 then
                 return {
                    e_mult = card.ability.extra.Emult + card.ability.immutable.base_emult,
                    colour = G.C.DARK_EDITION,
                }
            end
        end
    end
}