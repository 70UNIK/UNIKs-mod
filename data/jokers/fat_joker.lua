SMODS.Joker {
    key = 'unik_fat_joker',
    atlas = "placeholders",
    rarity = 2,
    pos = {x = 1, y = 0},
	cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    demicolon_compat = true,
    config = {
		extra = { card = 1 },
	},
    loc_vars = function(self, info_queue, center)
        local mult = 26 * center.ability.extra.card
        if G.playing_cards and G.GAME.starting_deck_size then
            mult = math.max(0,(#G.playing_cards - math.ceil(G.GAME.starting_deck_size/2)) * center.ability.extra.card)
        end
		return { vars = {center.ability.extra.card,math.ceil(G.GAME.starting_deck_size/2),mult} }
	end,
    calculate = function(self, card, context)
		if context.joker_main and #G.playing_cards -math.ceil(G.GAME.starting_deck_size/2) > 0 then
            local mult = math.max(0,(#G.playing_cards - math.ceil(G.GAME.starting_deck_size/2)) * card.ability.extra.card)
            return {
                message = localize{type='variable',key='a_mult',vars={mult}},
                mult_mod = mult
            }
		end
	end,
}