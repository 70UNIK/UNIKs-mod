SMODS.Blind{
    key = 'unik_halved',
    config = {},
	boss = {
		min = 5,
	},
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 22},
    boss_colour= HEX("009cfd"),
    dollars = 5,
    mult = 2,
    death_message = "special_lose_unik_half",
    unik_before_play = function(self)
        --Add Half to 2 random cards selected and 2 random jokers that are not already have the edition
        if (G.hand and G.hand.highlighted and #G.hand.highlighted > 3) or (G.play and G.play.cards and #G.play.cards > 3) then
            local triggered = false
            for g = 1, 1 do
                local eligible_cards = {}
                for i,v in pairs(G.jokers.cards) do
                    if not v.edition or (v.edition and not v.edition.unik_halfjoker) then
                        eligible_cards[#eligible_cards + 1] = v
                    end
                end
                if #eligible_cards > 0 then
                    triggered = true
                    local rip = pseudorandom_element(eligible_cards, pseudoseed("unik_half_joker_maker1"))
                    rip:set_edition({ unik_halfjoker = true }, true,nil, true)
                end

                local eligible_cards2 = {}
                for i,v in pairs(G.hand.highlighted) do
                    if not v.edition or (v.edition and not v.edition.unik_halfjoker) then
                        eligible_cards2[#eligible_cards2 + 1] = v
                    end
                end
                if #eligible_cards2 > 0 then
                    triggered = true
                    local rip2 = pseudorandom_element(eligible_cards2, pseudoseed("unik_half_joker_maker2"))
                    rip2:set_edition({ unik_halfjoker = true }, true,nil, true)
                end
                
            end
            if triggered then
                G.GAME.blind.triggered = true
                G.GAME.blind:wiggle()
            end
        end
       
	end,
}