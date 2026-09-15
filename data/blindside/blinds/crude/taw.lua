--stubborn, forced to be selected, cannot be burned or destroyed, EVER!

local burnHook = Card.start_burn
function Card:start_burn(cardarea, cell_fix, dissolve_colours, silent, dissolve_time_fac, no_juice)
    if not self.destroyed then
        if self and self.seal and self.ability and self.ability.extra and type(self.ability.extra) == 'table' and self.ability.extra.taw_unbreakable then
            return false
        elseif self and self.ability and self.ability.seal and self.ability.seal.extra and type(self.ability.seal.extra) == 'table' 
        and self.ability.seal.extra.locked_burn_limit and self.ability.seal.extra.locked_burn_limit > 0 then
            if self.ability.seal.extra.locked_burn_limit <= 1 then
                self:set_seal(nil, nil, true)
                self:juice_up()
                card_eval_status_text(self, 'extra', nil, nil, nil, {instant = true, message = localize('k_unik_weapon_destroyed') --[[index]], colour = HEX('7B5877')})
            else
                self.ability.seal.extra.locked_burn_limit = self.ability.seal.extra.locked_burn_limit - 1
                card_eval_status_text(self, 'extra', nil, nil, nil, {instant = true, message = localize('k_nope_ex') --[[index]], colour = HEX('7B5877')})
            end
                G.E_MANAGER:add_event(Event({
                trigger = 'after',
                blockable = false,
                delay =  1.05,
                func = (function()
                if self then 
                    play_sound('card1', 0.85 + percent*0.2/100, 0.6*(vol or 1))
                    if cardarea then self = cardarea:remove_card(self) end
                    if self then drawn = true end
                    local stay_flipped = G.GAME and G.GAME.blind and G.GAME.blind:stay_flipped(G.exhaust, self, G.play)
                    if not stay_flipped then
                        stay_flipped = G.GAME and G.GAME.blindassist and G.GAME.blindassist:stay_flipped(G.exhaust, self, G.play)
                    end
                    if G.GAME.modifiers.flipped_cards and to == G.hand then
                        if pseudorandom(pseudoseed('flipped_card')) < 1/G.GAME.modifiers.flipped_cards then
                            stay_flipped = true
                        end
                    end
                    G.discard:emplace(self, nil, stay_flipped)
                else
                    print("an error has occured")
                    play_sound('card1', 0.85 + percent*0.2/100, 0.6*(vol or 1))
                    if self then drawn = true end
                end
                return true
                end
                )}))
                return
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
        if self and self.ability and self.ability.extra and type(self.ability.extra) == 'table' and self.ability.extra.taw_unbreakable and not self.ability.unik_bypass_taw and not G.SETTINGS.paused then
            if originalArea == G.hand or originalArea == G.play or originalArea == G.deck or originalArea == G.discard or originalArea == G.exhaust then
                local _card = copy_card(self, nil, nil, G.playing_card)
                _card.ability.extra.taw_unbreakable = true
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, _card)
                _card:add_to_deck()
                _card:start_materialize()
                self.shattered = nil
                self.already_blown_up = nil
                if G.hand and G.hand.cards and G.GAME.blind.in_blind then
                    G.hand:emplace(_card)
                else
                    G.deck:emplace(_card)
                end
            end

            
           
        elseif self and self.seal and self.ability and self.ability.seal and self.ability.seal.extra and type(self.ability.seal.extra) == 'table' 
        and self.ability.seal.extra.locked_destroy_limit and self.ability.seal.extra.locked_destroy_limit > 0 and not G.SETTINGS.paused
        then 
            if originalArea == G.hand or originalArea == G.play or originalArea == G.deck or originalArea == G.discard or originalArea == G.exhaust then
                local _card = copy_card(self, nil, nil, G.playing_card)
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, _card)
                    _card:add_to_deck()
                    _card:start_materialize()
                    self.shattered = nil
                    self.already_blown_up = nil
                    if G.hand and G.hand.cards and G.GAME.blind.in_blind then
                        G.hand:emplace(_card)
                    else
                        G.deck:emplace(_card)
                    end
                if _card.ability.seal.extra.locked_destroy_limit <= 1 then
                    _card:set_seal(nil, nil, true)
                    _card:juice_up()
                    card_eval_status_text(_card, 'extra', nil, nil, nil, {instant = true, message = localize('k_unik_weapon_destroyed') --[[index]], colour = HEX('7B5877')})
                else
                    _card.ability.seal.extra.locked_destroy_limit = _card.ability.seal.extra.locked_destroy_limit - 1
                    card_eval_status_text(_card, 'extra', nil, nil, nil, {instant = true, message = localize('k_nope_ex') --[[index]], colour = HEX('7B5877')})
                end
            end
        end
    end
    return ret
end

--blocks rerolling
local set_abilityref = Card.set_ability
function Card:set_ability(center, initial, delay)
    local tawsome = self and self.ability and self.ability.extra and type(self.ability.extra) == 'table' and self.ability.extra.taw_unrerollable 
    or (self.seal and self.seal == 'unik_blindside_locked')
    if (not tawsome) or G.SETTINGS.paused then
        set_abilityref(self, center, initial, delay)
    else
        set_abilityref(self, G.P_CENTERS[self.config.center.key], initial, delay)
    end
end

BLINDSIDE.Blind({
    key = 'unik_blindside_taw',
    atlas = 'unik_blindside_blinds',
    pos = {x = 5, y = 6},
    config = {
        extra = {
            value = 30,
            taw_unbreakable = true,
            taw_unrerollable = true,
            x_mult = 2,
        },
    },
    hues = {"Purple"},
    calculate = function(self, card, context) 
         if context.cardarea == G.play and context.main_scoring and card.ability.extra.upgraded then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    end,
    curse = true,
    loc_vars = function(self, info_queue, card)
        if not card.ability.extra.upgraded then
            info_queue[#info_queue+1] = {key = 'unik_unrerollable', set = 'Other'}
        end
        
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_taw_upgraded' or 'm_unik_blindside_taw',
            vars = {
                card.ability.extra.x_mult
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.upgraded = true
            card.ability.extra.taw_unrerollable = nil
        end
    end
})