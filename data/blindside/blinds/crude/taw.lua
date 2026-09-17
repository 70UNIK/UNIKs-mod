--stubborn, forced to be selected, cannot be burned or destroyed, EVER!

local burner = BLINDSIDE.crane_active
function BLINDSIDE.crane_active(card)
    local ret = burner(card)
    if not ret then
        if card and card.ability and card.ability.extra and type(card.ability.extra) == 'table' and card.ability.extra.taw_unbreakable then
            return true
        elseif card and card.ability and card.ability.seal and card.ability.seal.extra and type(card.ability.seal.extra) == 'table' 
        and card.ability.seal.extra.locked_burn_limit and card.ability.seal.extra.locked_burn_limit > 0 then
            if card.ability.seal.extra.locked_burn_limit <= 1 then
                card:set_seal(nil, nil, true)
                card:juice_up(1,1)
                card_eval_status_text(card, 'extra', nil, nil, nil, {instant = true, message = localize('k_unik_weapon_destroyed') --[[index]], colour = HEX('7B5877')})
                play_sound('unik_locked_break', 1, 1)

            else
                card.ability.seal.extra.locked_burn_limit = card.ability.seal.extra.locked_burn_limit - 1
                card:juice_up()
                card_eval_status_text(card, 'extra', nil, nil, nil, {instant = true, message = localize('k_nope_ex') --[[index]], colour = HEX('7B5877')})
                play_sound('bld_clang', 1.5, 1)
            end
            return true
        end
    end
    
    return ret
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
                    _card:juice_up(1,1)
                    card_eval_status_text(_card, 'extra', nil, nil, nil, {instant = true, message = localize('k_unik_weapon_destroyed') --[[index]], colour = HEX('7B5877')})
                    play_sound('unik_locked_break', 1, 1)
                else
                    _card.ability.seal.extra.locked_destroy_limit = _card.ability.seal.extra.locked_destroy_limit - 1
                    play_sound('bld_clang', 1.5, 1)
                    _card:juice_up()
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
    local tawsome = self and (self.ability and self.ability.extra and type(self.ability.extra) == 'table' and self.ability.extra.taw_unrerollable 
    or (self.seal and self.seal == 'unik_blindside_locked')) and not G.GAME.bypass_reroll_block
    if (not tawsome) or G.SETTINGS.paused then
        set_abilityref(self, center, initial, delay)
    else
        if self.seal and self.seal == 'unik_blindside_locked' then
            self:juice_up()
            card_eval_status_text(self, 'extra', nil, nil, nil, {instant = true, message = localize('k_nope_ex') --[[index]], colour = HEX('7B5877')})
            play_sound('bld_clang', 1.5, 1)
        end
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