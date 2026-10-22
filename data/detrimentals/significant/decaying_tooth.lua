UNIK.detriment{
    key = "unik_decaying_tooth",
    atlas = "unik_detriments",
	pos = { x = 3, y = 2 },
    severity = 2,
    attributes = { 'detrimental','lose_economy','detriment' },
    config = { extra = {cash_loss = 1, cash_required = 13, current_cash = 0, enable_check = false,} },
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.cash_loss,center.ability.extra.cash_required} }
	end,
    pools = { ["unik_boss_blind_joker"] = true},
	blueprint_compat = true,
    immutable = true,
    dongtong_compat = false,
	calc_scaling = function(self, card, other_card, initial_value, scalar_value, args)
        if scalar_value > 0 then
            return {
                override_scalar_value = {
                    value = scalar_value/3, 
                },
            }
        end
    end,
    in_pool = function(self, args)
        return true
    end,
    calculate = function(self, card, context)
        if context.before and not context.retrigger_joker and not context.blueprint and not context.repetition then
            card.ability.extra.enable_check = true
            card.ability.extra.current_cash = 0
            for k, v in ipairs(context.full_hand) do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        v:juice_up()
                        return true
                    end,
                }))      
            end
            if context.full_hand and #context.full_hand > 0 then
                 return {
                    dollars = -card.ability.extra.cash_loss * #context.full_hand,
                }
            end
        end

        if card.ability.extra.enable_check and context.money_mod and context.money_mod_val > 0 and not context.retrigger_joker and not context.blueprint and not context.repetition then
            card.ability.extra.current_cash = card.ability.extra.current_cash + context.money_mod_val
        end

        if context.after then
            if card.ability.extra.current_cash >= card.ability.extra.cash_required then
                selfDestruction(card,"k_unik_headless_rotted",G.C.UNIK_THE_TOOTH)
            else
                card.ability.extra.enable_check = false
                card.ability.extra.current_cash = 0
            end
        end
        if context.setting_blind and (G.GAME.blind and (G.GAME.blind.config.blind.name == "The Tooth")) and not (G.GAME.blind.disabled) then
            selfDestruction(card,"k_unik_blind_start_tooth",G.C.UNIK_THE_TOOTH)
        end
    end,
}

local edo = ease_dollars
function ease_dollars(mod, instant)
    local res = edo(mod, instant)
        SMODS.calculate_context({ money_mod = true, money_mod_val = mod })
        if mod < 0 then
            G.GAME.unik_ante_spent = G.GAME.unik_ante_spent or 0
            G.GAME.unik_global_spent = G.GAME.unik_global_spent or 0
            if G.GAME.enable_ante_purchase_tracking then
                G.GAME.unik_ante_spent = G.GAME.unik_ante_spent+ math.abs(mod)
            end
            
            G.GAME.unik_global_spent = G.GAME.unik_global_spent + math.abs(mod)
        end
    return res
end