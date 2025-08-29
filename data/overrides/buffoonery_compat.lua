--Various buffoonery fixes.

--Overriding buffoonery's stakes so it works with vice_squeeze and comes after shitty stake and before pink stake
SMODS.Stake:take_ownership('stake_buf_spinel', {
	modifiers = function()
		G.E_MANAGER:add_event(Event({trigger = 'before',func = function() 
			G.GAME.win_ante = math.ceil(G.GAME.win_ante * 1.5)
		return true end })) 
    end,
    unlocked_stake = 'cry_ruby',
})
-- SMODS.Stake:take_ownership('cry_pink', {
--     applied_stakes = { "buf_spinel" },
--     above_stake = "buf_spinel",
--     prefix_config = { above_stake = {mod = false}, applied_stakes = {mod = false} },
-- })

SMODS.Stake:take_ownership('stake_buf_palladium', {
        applied_stakes = {"unik_shitty"},
    above_stake = "unik_shitty",
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}},
    modifiers = function()
		G.GAME.modifiers.buf_halfstep_bosses = true --dummy variable
        G.GAME.unik_vice_squeeze = 2
    end,
})
--The must win at ante 10 stake becomes ANTE 16 HAHAHAHAHAHAHHAHAHAHAHAHAHAH!!! 

-- SMODS.Stake:take_ownership('stake_unik_shitty', {
--     unlocked_stake = 'buf_palladium',
-- })

--increase win ante by 1.25X
-- SMODS.Stake:take_ownership('stake_cry_ruby', {
--  	applied_stakes = { "buf_spinel" },
--     above_stake = "buf_spinel",
--     prefix_config = { above_stake = {mod = false}, applied_stakes = {mod = false} },
--     modifiers = function()
-- 		G.E_MANAGER:add_event(Event({func = function() 
-- 			G.GAME.win_ante = math.ceil(G.GAME.win_ante * 1.25)
-- 		return true end })) 
-- 	end,
-- })

SMODS.Stake:take_ownership('stake_cry_horizon', {
    modifiers = function()
        G.GAME.unik_vice_squeeze = 4
    end,
})

--Rejected fan becomes cursed Joker.
SMODS.Joker:take_ownership('j_buf_afan_spc', {
    rarity = 'cry_cursed',
},true)

--Jokergebra and integral override fixes
SMODS.Joker:take_ownership('j_buf_jokergebra', {
calculate = function(self, card, context)
		if context.setting_blind then
			card.ability.extra.spc_check = true
		end
		if context.joker_main and not card.getting_sliced then
			if buf.compat.talisman then
				card.ability.extra.mult_amount = to_number(card.ability.extra.mult_amount)
			end
			return {
				chips = card.ability.extra.mult_amount
			}
        end
		if context.after and not context.blueprint then  -- go back to original func at EoR
			card.ability.extra.check = true
			card.ability.extra.mult_amount = 0
			card.ability.extra.mult_joker = nil
			if card.ability.extra.spc_count >= 5 then
				G.E_MANAGER:add_event(
				Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    SMODS.calculate_effect({message = localize('k_upgrade_ex'), colour = G.C.BUF_SPC}, card)
                    G.E_MANAGER:add_event(
                        Event({
                            trigger = "after",
                            delay = 0.2,
                            func = function()
                                SMODS.add_card({key = 'j_buf_integral'})
                                card:start_dissolve()
                                return true
                            end}))
                    return true
                end }))	
			end
		end
    end,
},true)

SMODS.Joker:take_ownership('j_buf_integral', {
calculate = function(self, card, context)
		if context.joker_main and not card.getting_sliced then
			if buf.compat.talisman then
				card.ability.extra.mult_amount = to_number(card.ability.extra.mult_amount)
			end
            return {
                message = localize({
					type = "variable",
					key = "a_powchips",
                    vars = {
                        number_format(card.ability.extra.mult_amount),
                    },
				}),
				e_chips = card.ability.extra.mult_amount,
                colour = G.C.DARK_EDITION,
			}
        end
		
		if context.after and not context.blueprint then  -- go back to original func at EoR
			card.ability.extra.mult_amount = 1
		end
    end,
},true)



--jank fix for jokergebra/integral to avoid overflow
local jebra_FX = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
    local ret = jebra_FX(effect, scored_card, key, amount, from_edition)
	for i = 1, #G.jokers.cards do
		if i > 1 and G.jokers.cards[i].config.center.key == 'j_buf_jokergebra' then
			local jokergebra = G.jokers.cards[i]
			if G.jokers.cards[i-1] == scored_card then
				if (key == 'mult' or key == 'h_mult' or key == 'mult_mod') and amount then
					if from_edition then  -- if the scored joker has an edition that adds mult, add the amount to calculation
						jokergebra.ability.extra.mult_amount = amount * 5
					elseif jokergebra.ability.extra.check and jokergebra.ability.extra.mult_amount ~= nil then
						jokergebra.ability.extra.mult_amount = (jokergebra.ability.extra.mult_amount) + amount * 5
						jokergebra.ability.extra.spc_count = 0
						jokergebra.ability.extra.check = false
					end
				elseif (key == 'x_mult' or key == 'xmult' or key == 'Xmult' or key == 'x_mult_mod' or key == 'Xmult_mod') and amount ~= 1 then
					if jokergebra.ability.extra.spc_check then 
						jokergebra.ability.extra.spc_count = jokergebra.ability.extra.spc_count + 1 
						jokergebra.ability.extra.spc_check = false
					end
				end
				
			end
		end
        if G.jokers.cards[i].config.center.key == 'j_buf_integral' then
            local integral = G.jokers.cards[i]
            if (key == 'x_mult' or key == 'xmult' or key == 'Xmult' or key == 'x_mult_mod' or key == 'Xmult_mod') and amount ~= 1 then
                integral.ability.extra.mult_amount = integral.ability.extra.mult_amount + amount * (0.02)
            end
        end
	end
	
	return ret
end

if not Talisman then
	buf.compat.talisman = true
end