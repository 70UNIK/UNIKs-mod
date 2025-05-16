--Add bloated to 2 random cards and leftmost joker on play
SMODS.Blind{
    key = 'unik_bloon',
    config = {},
	boss = {
		min = 3,
	},
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 20},
    boss_colour= HEX("ec1210"),
    dollars = 5,
    mult = 2,
    cry_before_play = function(self)
        --Add Half to 2 random cards selected and 2 random jokers that are not already have the edition
        local triggered = false
        if G.jokers.cards and G.jokers.cards[1] then
            if not G.jokers.cards[1].edition or (G.jokers.cards[1].edition and not G.jokers.cards[1].edition.unik_bloated) then
                G.jokers.cards[1]:set_edition({ unik_bloated = true }, true,nil, true)
                triggered = true
            end
        end
        for g = 1, 2 do
            local eligible_cards2 = {}
            for i,v in pairs(G.hand.highlighted) do
                if not v.edition or (v.edition and not v.edition.unik_bloated) then
                    eligible_cards2[#eligible_cards2 + 1] = v
                end
            end
            if #eligible_cards2 > 0 then
                triggered = true
                local rip2 = pseudorandom_element(eligible_cards2, pseudoseed("unik_half_joker_maker2"))
                rip2:set_edition({ unik_bloated = true }, true,nil, true)
            end
            
        end
        if triggered then
            G.GAME.blind.triggered = true
            G.GAME.blind:wiggle()
        end
	end,
}