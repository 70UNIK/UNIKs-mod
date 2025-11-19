--destroy a random played card
SMODS.BlindEdition {
    key = 'unik_bloated',
    blind_shader = 'unik_bloated',
    weight = 0.2,
    dollars_mod = 1,
    unik_after_play = function(self)
        if G.play and G.play.cards and (#G.play.cards > 0) then
            local destroyed_cards = {}
                local card = pseudorandom_element(G.play.cards, pseudoseed("unik_bloated_Editionblind"))
                destroyed_cards[#destroyed_cards+1] = card
                -- Destroy all cards in first hand
                SMODS.destroy_cards(destroyed_cards)
                G.E_MANAGER:add_event(Event({
                    delay = 0,
                    func = function()
                        G.GAME.blind.triggered = true
                        G.GAME.blind:wiggle()
                        return true
                    end
                }))
            end
	end,
    defeat = function(self, blind_on_deck)

    end,
}