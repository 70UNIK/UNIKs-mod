--Consumeables/CCD: Immediately uses consumeable when possible (left to right)
--If conditions for use are avaliable and its in consumeable slot, the consumeable will trigger. Lartceps will always have this sticker, so reserving it will not save you.\
--Playing cards: 1 in 10 chance to play selected cards when selected
--Vouchers: Immediately purchased when possible in shop (not implemented)
--Jokers: Immediately sold when selected (when possible)
--incompatible with eternal
function Card:set_triggering(triggering)
    if not self.config.center.triggering_blacklist then
        self.ability.unik_triggering = triggering
        self:set_cost()
    end
end
local setCosta = Card.set_cost
function Card:set_cost()
    if self.ability.disposable then
        self.cost = 0
        self.sell_cost = 0
    end
    setCosta(self)
end
SMODS.Sticker{
    key="unik_triggering",
    badge_colour=HEX("db5700"),
    atlas = 'unik_stickers', 
    pos = { x = 2, y = 1 },
    rate = 0.0,
    loc_vars = function(self, info_queue, card)
		if card.ability.consumeable then
			return { key = "unik_triggering_consumeable"}
        elseif card.ability.set == "Joker" then
            return { key = "unik_triggering_joker" }
        elseif card.ability.set == "Default" then
            return { key = "unik_triggering_playing_card" , vars = { G.GAME.probabilities.normal, 8 }}
        elseif card.ability.set == "Voucher" then
			return { key = "unik_triggering_voucher" }
		elseif card.ability.set == "Booster" then
			return { key = "unik_triggering_booster" }
		else
            return { key = "unik_triggering_playing_card", vars = { G.GAME.probabilities.normal, 8 } }
		end
	end,
}

local updateStickerHook = Card.update
function Card:update(dt)
    if self.ability and self.ability.unik_triggering then
        if (self.area == G.consumeables or self.area == G.hand) and self.ability and self.ability.unik_can_autotrigger then
            local canUse = false
            canUse = self:can_use_consumeable()
            if canUse and not self.ability.unik_already_used and not G.GAME.unik_using_automatic_consumeable and not G.GAME.before_play_buffer then
                self.ability.unik_already_used = true
                G.GAME.unik_using_automatic_consumeable = true
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        if not G.GAME.before_play_buffer then
                            G.FUNCS.use_card({config = {ref_table = self}})
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                func = function()
                                    G.GAME.unik_using_automatic_consumeable = nil
                                    return true
                                end
                            }))
                        else
                            self.ability.unik_already_used = nil
                            G.GAME.unik_using_automatic_consumeable = nil
                        end
                        return true
                    end
                }))

            end
        end
    --Ultradebuffed
    elseif self.ability and self.ability.unik_ultradebuffed then
        if not self.debuff then
            self.debuff = true
            self.perma_debuff = true
            if self.area == G.jokers then self:remove_from_deck(true) end
        end
    end
    local ret = updateStickerHook(self,dt)
    return ret
end
