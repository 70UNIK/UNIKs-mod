--Consumeables/CCD: Immediately uses consumeable when possible (left to right)
--If conditions for use are avaliable and its in consumeable slot, the consumeable will trigger. Lartceps will always have this sticker, so reserving it will not save you.\
--Playing cards: 1 in 10 chance to play selected cards when selected
--Vouchers: Immediately purchased when possible in shop (not implemented)
--Jokers: Immediately sold when selected (when possible)
--incompatible with eternal
function Card:set_triggering(triggering)
    --colour cards are blacklisted
    if self.config.center.set == 'Colour' then
        return nil
    end
    if not self.config.center.triggering_blacklist and not SMODS.is_eternal(self,self) then
        self.ability.unik_triggering = triggering
        self:set_cost()
    end
end
local setCosta = Card.set_cost
function Card:set_cost()
    setCosta(self)
    if self.ability.disposable then
        self.cost = 0
        self.sell_cost = 0
    end
end
SMODS.Sticker{
    key="unik_triggering",
    badge_colour=HEX("db5700"),
    atlas = 'unik_stickers', 
    pos = { x = 2, y = 1 },
    rate = 0.0,
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1,8, 'unik_triggering_playing_card')
		if card.ability.consumeable then
			return { key = "unik_triggering_consumeable"}
        elseif card.ability.set == "Joker" then
            return { key = "unik_triggering_joker" }
        elseif card.ability.set == "Default" then
            return { key = "unik_triggering_playing_card" , vars = { new_numerator, new_denominator }}
        elseif card.ability.set == "Voucher" then
			return { key = "unik_triggering_voucher" }
		elseif card.ability.set == "Booster" then
			return { key = "unik_triggering_booster" }
		else
            return { key = "unik_triggering_playing_card", vars = { new_numerator, new_denominator } }
		end
	end,
    calculate = function(self, card, context)
		if context.unik_triggering then 
            if (context.selected_card == card) then
                if SMODS.pseudorandom_probability(card, 'unik_triggering_playing_card', 1, 8, 'unik_triggering_playing_card') then
                    if next(SMODS.find_mod("Bunco")) then
                        play_sound('bunc_gunshot')
                        card:juice_up(1,1)
                    end
                    return {
                        message = localize("k_unik_triggered"),
                        colour = G.C.RED,
                        finger_triggered = true,
                    }
                end
            end

            
		end
	end,
}

local updateStickerHook = Card.update
function Card:update(dt)
    if self.ability and self.ability.unik_shielded then
        self.debuff = false
        self.perma_debuff = false
    end
    if self.ability and self.ability.unik_triggering then
        if (self.area == G.consumeables or self.area == G.hand) and self.ability and self.ability.unik_can_autotrigger then
            local canUse = false
            if self.can_use_consumeable and self.ability.consumeable then
                canUse = self:can_use_consumeable()
            end
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
        self.ability.unik_shielded = nil
        if not self.debuff and not self.area.config.collection then
            self.debuff = true
            self.perma_debuff = true
            self:set_debuff(true)
            if self.area == G.jokers then self:remove_from_deck(true) end
        end
    end
    local ret = updateStickerHook(self,dt)
    return ret
end


function Card:calculate_triggering(is_higlighted)
    self.highlighted = is_higlighted
    local eval = {}
    if self.highlighted == true and (self.area == G.hand) and (G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.DRAW_TO_HAND) and not G.GAME.unik_using_automatic_consumeable  and (not (G.GAME.STOP_USE and G.GAME.STOP_USE > 0)) then
        SMODS.calculate_context({unik_triggering = true, selected_card = self},eval)
    end
    local triggered = false
    for i = 1, #eval do
        if triggered then break end
        if eval[i] and type(eval[i]) == 'table' then
            if triggered then break end
            for i,v in pairs(eval[i]) do
                if triggered then break end
                if v.finger_triggered then
                    triggered = true
                    if v.message then
                        card_eval_status_text(v.card, "extra", nil, nil, nil, {
                            message = v.message,
                            colour = v.colour or G.C.FILTER,
                            card=v.card,
                        })
                    end
                    break
                end
            end

        end
    end
    if triggered then
        stop_use()
        print("TRIGGERED!")
        G.FUNCS.play_cards_from_highlighted()
    end
    
    -- if self.highlighted == true and self.ability and self.ability.set and self.ability.unik_triggering and (self.ability.set == "Default" or self.area == G.hand) then
    --     if (G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.DRAW_TO_HAND) and SMODS.pseudorandom_probability(self, 'unik_triggering_playing_card', 1, 8, 'unik_triggering_playing_card') and not G.GAME.unik_using_automatic_consumeable then
    --         local cards = {}
    --         for i = 1, #G.hand.highlighted do
    --             table.insert(cards, G.hand.highlighted[i])
    --         end
    --         G.E_MANAGER:add_event(Event({
    --             trigger = 'after', 
    --             func = function()
    --                 if not G.GAME.unik_using_automatic_consumeable then
    --                     for i = 1, #cards do
    --                         if not cards[i].highlighted then
    --                             cards[i]:highlight()
    --                         end
    --                     end
    --                     if G.hand.highlighted then
    --                         if next(SMODS.find_mod("Bunco")) then
    --                             play_sound('bunc_gunshot')
    --                         end
    --                         card_eval_status_text(self, "extra", nil, nil, nil, { message = localize("k_unik_triggered") })
                            
    --                         G.FUNCS.play_cards_from_highlighted()
    --                     end
    --                 end
    --                 return true 
    --         end}))
    --     end
    -- -- Jokers
    -- end
end