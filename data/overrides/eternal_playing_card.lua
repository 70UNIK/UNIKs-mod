--cannot be destroyed when possible, if somehow destroyed, copies itself
--priorities:
--exclude eternal
SMODS.Sticker:take_ownership("eternal", {
    loc_vars = function(self, info_queue, card)
		if card.playing_card then
            return {key = 'unik_eternal_playing_card'}
        end
        return {key = 'eternal'}
	end,
}, true)

local deleter = Game.delete_run
function Game:delete_run()
    G.GAME.ignore_eternal_cards = true
    local ret = deleter(self)
    G.GAME.ignore_eternal_cards = nil
    return ret
end

local remove_ref = Card.remove
function Card.remove(self)
  -- Check that the card being removed is a joker that's in the player's deck and that it's not being sold
    if self.added_to_deck and self.playing_card and SMODS.is_eternal(self,self) and not G.GAME.ignore_eternal_cards then
        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
        local new_card = copy_card(self, nil, nil, G.playing_card)    
         new_card:add_to_deck()
        G.deck.config.card_limit = G.deck.config.card_limit + 1
        table.insert(G.playing_cards, new_card)
        if G.hand then
            G.hand:emplace(new_card)
        else
            G.deck:emplace(new_card)
        end
        
        new_card.states.visible = nil
        new_card:start_materialize()
    end
    local ret = remove_ref(self)
    return ret
end