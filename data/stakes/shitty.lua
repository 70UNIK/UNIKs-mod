--jokers may be disposable (50% chance to replace perishing).
--Perishables self destruct instead of being debuffed
local nextStake = 'cry_ruby'
if (SMODS.Mods["Buffoonery"] or {}).can_load then
    nextStake = 'buf_palladium'
end
SMODS.Stake{ 
    key = 'unik_shitty',

    unlocked_stake =  nextStake ,
    applied_stakes = {'gold'},
    above_stake = 'gold',
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}},

    modifiers = function()
        G.GAME.modifiers.enable_disposable_in_shop = true
        G.GAME.modifiers.destroy_perishables = true
    end,

    colour = HEX('4e4d25'),

    pos = { x = 0, y = 0 },
    sticker_pos = { x = 0, y = 0 },
    atlas = 'unik_stakes',
    sticker_atlas = 'unik_sticker_stakes'
}

if not (SMODS.Mods["Buffoonery"] or {}).can_load then
    SMODS.Stake:take_ownership('stake_cry_ruby', {
        applied_stakes = { "unik_shitty" },
        above_stake = "unik_shitty",
        prefix_config = { above_stake = {mod = false}, applied_stakes = {mod = false} },
    })
end
local disposableOverrideVoucher = Card.cry_calculate_voucher_perishable
function Card:cry_calculate_voucher_perishable()
    if self.ability.perishable and not self.ability.perish_tally then
		self.ability.perish_tally = G.GAME.cry_voucher_perishable_rounds
	end
    if (G.GAME.modifiers.destroy_perishables or self.ability.eternal) and self.ability.perishable and self.ability.perish_tally > 0 then
        if self.ability.perish_tally == 1 then
			self:unredeem()
            card_eval_status_text(self, "jokers", nil, nil, nil, {
                message = localize("k_unik_perished"),
                delay = 0.1 ,
                colour = G.C.PERISHABLE,
            })
		else
			self.ability.perish_tally = self.ability.perish_tally - 1
			card_eval_status_text(self, "extra", nil, nil, nil, {
				message = localize({ type = "variable", key = "a_remaining", vars = { self.ability.perish_tally } }),
				colour = G.C.FILTER,
				delay = 0.45,
			})
		end
    else
        disposableOverrideVoucher(self)
    end
end

local disposableConsumableOverride = Card.cry_calculate_consumeable_perishable
function Card:cry_calculate_consumeable_perishable()
	if not self.ability.perish_tally then
		self.ability.perish_tally = 1
	end
    if (G.GAME.modifiers.destroy_perishables or self.ability.eternal) and self.ability.perishable and self.ability.perish_tally > 0 then
        self.ability.perish_tally = 0
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
            delay = 0.1 ,
            colour = G.C.PERISHABLE,
        })
    else
        disposableConsumableOverride(self)
    end
end

local disposablePerishOverride = Card.calculate_perishable
function Card:calculate_perishable()
    if self.ability.perishable and not self.ability.perish_tally then self.ability.perish_tally = G.GAME.perishable_rounds end
    if (G.GAME.modifiers.destroy_perishables or self.ability.eternal) and self.ability.perishable and self.ability.perish_tally > 0 then
        if self.ability.perish_tally == 1 then
            self.ability.perish_tally = 0
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
                delay = 0.1 ,
                colour = G.C.PERISHABLE,
            })
        else
            self.ability.perish_tally = self.ability.perish_tally - 1
            card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_remaining',vars={self.ability.perish_tally}},colour = G.C.FILTER, delay = 0.45})
        end
    else
        disposablePerishOverride(self)
    end
end