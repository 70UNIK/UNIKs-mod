--stubborn, retained, cannot be burned or destroyed, EVER!

local burnHook = Card.start_burn
function Card:start_burn(cardarea, cell_fix, dissolve_colours, silent, dissolve_time_fac, no_juice)
    if not self.destroyed then
        if self and self.config.center.key == 'm_unik_blindside_taw' then
            return false
        end
        local ret = burnHook(self,cardarea, cell_fix, dissolve_colours, silent, dissolve_time_fac, no_juice)
        return ret
    end
end

local remove_ref = Card.remove
function Card.remove(self)
    local originalArea = self.area

    local ret = remove_ref(self)
    if not G.GAME.ignore_delete_context then
        if self.config.center.key == 'm_unik_blindside_taw' and not self.ability.unik_bypass_taw and not G.SETTINGS.paused then
            if originalArea == G.hand or originalArea == G.play or originalArea == G.deck or originalArea == G.discard or originalArea == G.exhaust then
                if self.playing_card then

                local _card = nil
                _card = copy_card(self, nil, nil, nil, nil)
                _card:add_to_deck()
                _card:start_materialize()
                    if G.hand and G.hand.cards and G.GAME.blind.in_blind then
                        G.hand:emplace(_card)
                    else
                        G.deck:emplace(_card)
                    end
                    
                end
            end

            
           
        end
    end
    return ret
end

