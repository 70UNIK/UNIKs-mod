SMODS.Sticker{
    key="unik_mad",
    badge_colour=HEX("211400"),
    atlas = 'unik_stickers', 
    pos = { x = 5, y = 0 },
    rate = 0.0,
    no_sticker_sheet = true,
    order = 3200,
}
local remove_ref = Card.remove
function Card.remove(self)
    local hasbeenrestored = false
    local originalArea = self.area or nil
    if self.ability and self.ability.unik_mad then
        self.ability.unik_mad_seed = math.random(1,99999999)
    end


    local ret = remove_ref(self)
    if not G.GAME.ignore_delete_context then
        if self.ability.unik_mad and not G.SETTINGS.paused then
            G.E_MANAGER:add_event(Event({
                delay = 0,
                trigger= 'after',
                func = function()
                    if originalArea ~= G.shop_booster and originalArea ~= G.shop_vouchers and originalArea ~= G.pack_cards and originalArea ~= G.shop_jokers then
                            if originalArea == G.jokers or originalArea == G.deck or originalArea == G.consumables or originalArea == G.hand or originalArea == G.play or originalArea == G.discard then
                            if self.ability.set == 'Joker' then
                                originalArea = G.jokers
                            end
                            if originalArea and originalArea.cards then
                                for i,v in pairs(originalArea.cards) do
                                    if self.config.center.key == v.config.center.key
                                    and self.ability and v.ability and
                                    self.ability.unik_mad_seed and v.ability.unik_mad_seed
                                    and self.ability.unik_mad_seed == v.ability.unik_mad_seed
                                    then
                                        hasbeenrestored = true
                                        break
                                    end
                                end
                            end
                            if originalArea and not hasbeenrestored then
                                G.E_MANAGER:add_event(Event({
                                    delay = 0,
                                    func = function()
                                        G.STATE = G.STATES.GAME_OVER
                                        G.STATE_COMPLETE = false 
                                        return true
                                    end
                                }))
                            end                                           
                        end
                        
                    end
                    return true
                end
            }))
        end
    end

    
    return ret
end

