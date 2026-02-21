--^1.2 Mult, only if played hand only contains a single king of spades
SMODS.Joker {
    key = 'unik_lone_despot',
    atlas = 'unik_epic',
    rarity = 3,
	pos = { x = 1, y = 0 },
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    demicoloncompat = true,
    cost = 8,
    config = { extra = { Emult = 0.3}, immutable = {base_emult = 1.0} },
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.Emult + center.ability.immutable.base_emult} }
	end,
    --Only spawn if you have at least 1 king of spades in deck
    in_pool = function(self)
        for i,v in pairs(G.playing_cards) do
            if v:get_id() == 13 then
                return true
            end
        end
        return false
    end,
    pronouns = "he_him",
    calculate = function(self, card, context)
        if context.forcetrigger then
             return {
                e_mult = card.ability.extra.Emult + card.ability.immutable.base_emult,
                colour = G.C.DARK_EDITION,
            }
        end
        if context.joker_main and #context.full_hand == 1 then
            if context.full_hand[1]:get_id() == 13 then
                return {
                    e_mult = card.ability.extra.Emult + card.ability.immutable.base_emult,
                    colour = G.C.DARK_EDITION,
                }
            end
        end
    end
}