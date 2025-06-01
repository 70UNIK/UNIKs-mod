SMODS.Blind{
    key = 'unik_fuzzy',
    config = {},
	boss = {
		min = 9,
	},
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 23},
    boss_colour= HEX("ff00e6"),
    dollars = 5,
    mult = 2,
    loc_vars = function(self)
		return { vars = { "" .. ((Cryptid.safe_get(G.GAME, "probabilities", "normal") or 1) * 1), 4 } }
	end,
	collection_loc_vars = function(self)
		return { vars = { "" .. ((Cryptid.safe_get(G.GAME, "probabilities", "normal") or 1) * 1), 4 } }
	end,
    cry_before_play = function(self)
        for i,v in pairs(G.hand.highlighted) do
            if (not v.edition or (v.edition and not v.edition.unik_fuzzy)) and (pseudorandom(pseudoseed("unik_fuzzy_blind_chance")) < ((G.GAME.probabilities.normal * 1) / 4))then
                v:set_edition({ unik_fuzzy = true }, true,nil, true)
                G.GAME.blind.triggered = true
                G.GAME.blind:wiggle()
            end
        end
	end,
}