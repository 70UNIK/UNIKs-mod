--Lose $1 per card played. Self destructs after gaining more than $10 in a hand.
SMODS.Joker {
	dependencies = {
		items = {
			"set_cry_cursed",
		},
	},
	-- How the code refers to the joker.
	key = 'unik_decaying_tooth',
    atlas = 'placeholders',
    rarity = UnikDetrimentalRarity(),
	no_dbl = true,
	pos = { x = 3, y = 1 },
    cost = 0,
	blueprint_compat = false,
    perishable_compat = false,
	eternal_compat = false,
    config = { extra = {cash_loss = 1, cash_required = 20, current_cash = 0, enable_check = false,selfDestruct = false},},
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.cash_loss,center.ability.extra.cash_required} }
	end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_unik_blind_start_tooth'), G.C.UNIK_THE_TOOTH, G.C.WHITE, 1.0 )
    end,
    immutable = true,
    pools = { ["unik_boss_blind_joker"] = true},
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
            if card.ability.extra.current_cash >= card.ability.extra.cash_required and not card.ability.extra.selfDestruct then
                card.ability.extra.selfDestruct = true
                selfDestruction(card,"k_unik_headless_rotted",G.C.UNIK_THE_TOOTH)
            else
                card.ability.extra.enable_check = false
                card.ability.extra.current_cash = 0
            end
        end
        if context.setting_blind and (G.GAME.blind and (G.GAME.blind.config.blind.name == "The Tooth")) and not (G.GAME.blind.disabled) and not card.ability.extra.selfDestruct then
            selfDestruction(card,"k_unik_blind_start_tooth",G.C.UNIK_THE_TOOTH)
            card.ability.extra.selfDestruct = true
        end
    end,
}

local edo = ease_dollars
function ease_dollars(mod, instant)
    local res = edo(mod, instant)
        SMODS.calculate_context({ money_mod = true, money_mod_val = mod })
    return res
end