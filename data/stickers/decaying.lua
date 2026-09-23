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
        if self.ability.unik_decaying_tally <= 1 or self.ability.consumeable then
            self.ability.unik_decaying_tally = 0
            --self.ability.block_wl_copy = true
            --self:set_debuff()
            selfDestruction(self,"k_unik_perished",G.C.PERISHABLE)
        else
            self.ability.unik_decaying_tally = self.ability.unik_decaying_tally - 1
            card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_remaining',vars={self.ability.unik_decaying_tally}},colour = G.C.PERISHABLE, delay = 0.5})
        end
    else
        self.ability.unik_decaying_tally = nil
    end
end