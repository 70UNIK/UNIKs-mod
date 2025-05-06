--Consumeable exclusive sticker; Immediately uses consumeable when possible (left to right)
--If conditions for use are avaliable and its in consumeable slot, the consumeable will trigger. Lartceps will always have this sticker, so reserving it will not save you. Otherwise is cosmetic
SMODS.Sticker{
    key="unik_triggering",
    badge_colour=HEX("db5700"),
    atlas = 'unik_stickers', 
    pos = { x = 2, y = 1 },
    rate = 0.0,
    no_sticker_sheet = true,
    loc_vars = function(self, info_queue, card)
		if card.ability.consumeable then
			return { key = "unik_triggering_consumeable"}
		else
			return { }
		end
	end,
    update = function(self,card,dt)
        
    end
}

local updateStickerHook = Card.update
function Card:update(dt)
    if self.ability and self.ability.unik_triggering then
        if self.area == G.consumeables then
            if self:can_use_consumeable() and not self.ability.unik_already_used and not G.GAME.unik_using_automatic_consumeable then
                self.ability.unik_already_used = true
                G.GAME.unik_using_automatic_consumeable = true
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        G.FUNCS.use_card({config = {ref_table = self}})
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            func = function()
                                G.GAME.unik_using_automatic_consumeable = nil
                                return true
                            end
                        }))
                        return true
                    end
                }))

            end
        end
    end
    local ret = updateStickerHook(self,dt)
    return ret
end
