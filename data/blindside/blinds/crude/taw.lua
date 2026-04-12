--stubborn, forced to be selected, cannot be burned or destroyed, EVER!

local burnHook = Card.start_burn
function Card:start_burn(cardarea, cell_fix, dissolve_colours, silent, dissolve_time_fac, no_juice)
    if not self.destroyed then
        if self and self.ability and self.ability.extra and type(self.ability.extra) == 'table' and self.ability.extra.taw_unbreakable then
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
        if self and self.ability and self.ability.extra and type(self.ability.extra) == 'table' and self.ability.extra.taw_unbreakable and not self.ability.unik_bypass_taw and not G.SETTINGS.paused then
            if originalArea == G.hand or originalArea == G.play or originalArea == G.deck or originalArea == G.discard or originalArea == G.exhaust then
                local _card = copy_card(self, nil, nil, G.playing_card)
                _card.ability.extra.taw_unbreakable = true
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, _card)
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
    return ret
end

local set_abilityref = Card.set_ability
function Card:set_ability(center, initial, delay)
    local tawsome = self and self.ability and self.ability.extra and type(self.ability.extra) == 'table' and self.ability.extra.taw_unbreakable
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
        forced_selection = true,
        extra = {
            value = 30,
            taw_unbreakable = true,
            stubborn = true,
            x_mult = 4,
        },
    },
    hues = {"Purple"},
    calculate = function(self, card, context) 
        if tableContains(card, G.hand.cards) and not tableContains(card, G.hand.highlighted) and #G.hand.highlighted < 5 and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
            card.ability.forced_selection = true
            G.hand:add_to_highlighted(card, true)
        end
        if context.after then
            card.ability.forced_selection = false
        end
         if context.cardarea == G.play and context.main_scoring and card.ability.extra.upgraded then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    end,
    curse = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bld_stubborn', set = 'Other'}
        info_queue[#info_queue+1] = {key = 'unik_unrerollable', set = 'Other'}
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
        end
    end
})