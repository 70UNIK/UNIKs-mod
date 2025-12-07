--perishable, but destroys jokers instead of debuffing it, cannot be removed
SMODS.Sticker{
    key="unik_decaying",
    badge_colour=G.C.PERISHABLE,
    atlas = 'unik_stickers', 
    pos = { x = 2, y = 2 },
    rate = 0.0,
    no_sticker_sheet = true,
    loc_vars = function(self, info_queue, card)
        G.GAME.unik_decaying_rounds = G.GAME.unik_decaying_rounds or 4
        local tally = G.GAME.unik_decaying_rounds or 4
        if card and card.ability and card.ability.unik_decaying_tally then
            tally = card.ability.unik_decaying_tally
        end
        local key = "unik_decaying"
        if card.ability.consumeable then
            key = "unik_decaying_consumable"
        end
        
        return { key = key, vars = { G.GAME.unik_decaying_rounds or 4, tally  } }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval then -- perishable is calculated seperately across G.playing_cards i believe
            card:calculate_decaying()
		end
	end,
}
function Card:calculate_decaying()
    if self.ability.unik_decaying then
        G.GAME.unik_decaying_rounds = G.GAME.unik_decaying_rounds or 4
        if self.ability.unik_decaying and not self.ability.unik_decaying_tally then self.ability.unik_decaying_tally = G.GAME.unik_decaying_rounds end
        if self.ability.unik_decaying_tally == 1 or self.ability.consumeable then
            self.ability.unik_decaying_tally = 0
            self:set_debuff()
                G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    self.T.r = -0.2
                    self:juice_up(0.3, 0.4)
                    self.states.drag.is = true
                    self.children.center.pinch.x = true
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.3,
                        blockable = false,
                        func = function()
                            if self.area then
                                self.area:remove_card(self)
                            end
                            self:remove()
                            self = nil
                            return true
                        end,
                    }))
                    return true
                end,
            }))
            card_eval_status_text(self, "jokers", nil, nil, nil, {
                message = localize("k_unik_perished"),
                delay = 0.5 ,
                colour = G.C.PERISHABLE,
            })
        else
            self.ability.unik_decaying_tally = self.ability.unik_decaying_tally - 1
            card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_remaining',vars={self.ability.unik_decaying_tally}},colour = G.C.PERISHABLE, delay = 0.5})
        end
    else
        self.ability.unik_decaying_tally = nil
    end
end