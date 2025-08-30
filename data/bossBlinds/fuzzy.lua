SMODS.Blind{
    key = 'unik_fuzzy',
    config = {},
	boss = {
		min = 9,
	},
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 23},
    boss_colour= G.C.UNIK_RGB,
    dollars = 5,
    mult = 2,
    death_message = "special_lose_unik_fuzzy",
    loc_vars = function(self)
        local new_numerator, new_denominator = SMODS.get_probability_vars(self, 1,4, 'unik_fuzzy')
		return { vars = { new_numerator, new_denominator } }
	end,
	collection_loc_vars = function(self)
        local new_numerator, new_denominator = SMODS.get_probability_vars(self, 1,4, 'unik_fuzzy')
		return { vars = { new_numerator, new_denominator } }
	end,
    unik_before_play = function(self)
        for i,v in pairs(G.hand.highlighted) do
            if (not v.edition or (v.edition and not v.edition.unik_fuzzy)) and SMODS.pseudorandom_probability(self, pseudoseed('unik_fuzzy'), 1, 4, 'unik_fuzzy') then
                v:set_edition({ unik_fuzzy = true }, true,nil, true)
                G.GAME.blind.triggered = true
                G.GAME.blind:wiggle()
            end
        end
	end,
}