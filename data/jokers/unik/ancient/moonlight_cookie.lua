SMODS.Atlas {
	key = "unik_moonlight",
	path = "unik_moonlight_cookie.png",
	px = 71,
	py = 95
}
--from maxie
local moonlight_quotes = {
	normal = {
		'k_unik_moonlight_normal1',
		'k_unik_moonlight_normal2',
		'k_unik_moonlight_normal3',
	},
	-- drama = {
	-- 	'k_unik_moonlight_scared1',
	-- },
	-- gods = {
	-- 	'k_unik_moonlight_godsmarble1',
	-- 	'k_unik_moonlight_godsmarble2',
	-- 	'k_unik_moonlight_godsmarble3',
	-- }
}

SMODS.Joker {
	key = 'unik_moonlight_cookie',
    atlas = 'unik_moonlight',
    rarity = "unik_ancient",
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
    cost = 50,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
	pronouns = "she_her",
    config = { extra = { exp_levelup = 1.4,spawn_rate = 5} },
	loc_vars = function(self, info_queue, center)
		local quoteset = 'normal'
		return {  
			vars = {center.ability.extra.exp_levelup,
			localize(moonlight_quotes[quoteset][math.random(#moonlight_quotes[quoteset])] .. ""),center.ability.extra.spawn_rate
		} 
		}
	end,
    pools = { ["unik_cookie_run"] = true, ["unik_copyrighted"] = true },
	set_ability = function(self, card, initial, delay_sprites)
	end,
    calculate = function(self, card, context)
		if (context.hand_levelup_held_consume and ((context.levelup_amount and lenient_bignum(context.levelup_amount) > lenient_bignum(0)) or not context.levelup_amount))
		 then
			local v = context.other_consumeable_lvlup
			local hand = context.levelup_poker_hand
			if v.debuff then
				card_eval_status_text(card, "debuff", nil, nil, nil, nil)
				v:juice_up(0.8, 0.5)
				return
			end
			if v.ability.hand_type and v.ability.hand_type == hand then
				return {
					x_mult = card.ability.extra.exp_levelup,
					x_chips = card.ability.extra.exp_levelup,
					message = localize("k_upgrade_ex")
				}
			end
			if v.ability.hand_types then
				for i = 1,#v.ability.hand_types do
					--print(v.ability.hand_types[i])
					if v.ability.hand_types[i] == hand then
						return {
							x_mult = card.ability.extra.exp_levelup,
							x_chips = card.ability.extra.exp_levelup,
							message = localize("k_upgrade_ex")
						}
					end
				end
				--print(hand)
			end
			if v.config.center.key == "c_black_hole" then
				return {
					x_mult = card.ability.extra.exp_levelup,
					x_chips = card.ability.extra.exp_levelup,
					message = localize("k_upgrade_ex")
				}
			end
			if v.config.center.key == "c_cry_planetlua" then
				return {
					x_mult = card.ability.extra.exp_levelup,
					x_chips = card.ability.extra.exp_levelup,
					message = localize("k_upgrade_ex"),
					probability = {v,"planetlua",1,v and v.ability.extra.odds or 5}
				}
			end
			return{
				
			}
		end
		
    end,

}

local levelUpHook = level_up_hand
function level_up_hand(card, hand, instant, amount)
	levelUpHook(card, hand, instant, amount)
	if not G.GAME.unik_level_up_buffer then
		G.GAME.unik_level_up_buffer = true
		local eval = {}
		local speed = 1
		local pitch = 1
		for i,v in pairs(G.consumeables.cards) do
			--print("consumable")
			eval = {}
			
			SMODS.calculate_context({hand_levelup_held_consume = true,other_consumeable_lvlup = v, levelup_poker_hand = hand, levelup_amount = amount},eval)
			v.ability.unik_used_up_by_this_context = false
			for x = 1, #eval do
				
				if eval[x] and type(eval[x]) == 'table' then
					
					if not v.ability.unik_used_up_by_this_context then
						for i,w in pairs(eval[x]) do
						--	print(eval[x])
							--v.ability.unik_used_up_by_this_context = true
							local triggered = false
							local values = {}
							local repetitions = 1
							
							if v.ability.immutable and v.ability.immutable.overflow_amount then
								repetitions = v.ability.immutable.overflow_amount or 1
								--planetlua
								if w.probability and type(w.probability) == 'table' then
									local newrepetitions = 0
									for i = 1, repetitions do
										if SMODS.pseudorandom_probability(
											w.probability[1],
											w.probability[2],
											w.probability[3],
											w.probability[4]
										) then
											newrepetitions = newrepetitions + 1
										end
									end
									repetitions = newrepetitions
								end
								
							else
								--planetlua
								if w.probability and type(w.probability) == 'table' then
									if SMODS.pseudorandom_probability(
											w.probability[1],
											w.probability[2],
											w.probability[3],
											w.probability[4]
										) then
											repetitions = 1
										else
											repetitions = 0
										end
								end
							end
							
							if w.x_chips then
								triggered = true
								values.x_chips = w.x_chips
							end
							if w.x_mult then
								triggered = true
								values.x_mult = w.x_mult
							end
							if repetitions == 0 then
								speed = speed * 1.15
								G.E_MANAGER:add_event(Event({
									trigger = "immediate",
									func = function()
										
										pitch = pitch * 1.15
										return true
									end,
								}))
								card_eval_status_text(v, "extra", nil, nil, nil, {
									message = localize('k_nope_ex'),
									colour = G.C.RED,
									card=v,
									delay = instant and 0.01 or 1/speed
								})
								w.card:juice_up(0.8, 0.5)
							elseif triggered then
								
								speed = math.min(speed * 1.15,speed+1)
								G.E_MANAGER:add_event(Event({
									trigger = "immediate",
									func = function()
										pitch = math.min(pitch * 1.15,pitch+1)
										return true
									end,
								}))
								if not instant and (not Talisman or not Talisman.config_file.disable_anims) then
											
									update_hand_text(
										{ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3/speed },
										{
											handname = localize(hand, 'poker_hands'),
											chips = G.GAME.hands[hand].chips,
											mult = G.GAME.hands[hand].mult,
											level = G.GAME.hands[hand].level
										}
									)
								end


								if not instant and (not Talisman or not Talisman.config_file.disable_anims) then
									
									if values.x_chips then
										G.GAME.hands[hand].chips = G.GAME.hands[hand].chips*values.x_chips^repetitions
										if not instant and (not Talisman or not Talisman.config_file.disable_anims) then
											
											update_hand_text({delay = 0}, {chips = tostring("X"..math.ceil((values.x_chips^ repetitions)*100)/100), StatusText = true})
											G.E_MANAGER:add_event(Event({
												trigger = "immediate",
												func = function()
													play_sound("xchips",0.8+pitch*0.1,1)
													v:juice_up(0.8, 0.5)
													return true
												end,
											}))
										end

									end
									if values.x_mult then
										G.GAME.hands[hand].mult = G.GAME.hands[hand].mult*values.x_mult^ repetitions
										if not instant and (not Talisman or not Talisman.config_file.disable_anims) then
											update_hand_text({delay = 0}, {mult = tostring("X"..math.ceil((values.x_mult^ repetitions)*100)/100), StatusText = true})
											G.E_MANAGER:add_event(Event({
										trigger = "immediate",
												func = function()
													play_sound("multhit2",0.8+pitch*0.1,1)
													v:juice_up(0.8, 0.5,1)
													return true
												end,
											}))
										end
										
									end
									card_eval_status_text(w.card, "extra", nil, nil, nil, {
										message = w.message,
										colour = w.colour or G.C.FILTER,
										card=w.card,
										delay = instant and 0.01 or 1/speed
									})
								end
								

							end

							if w.retrigger_card and w.repetitions then
								card_eval_status_text(w.retrigger_card, "extra", nil, nil, nil, {
									message = w.message or localize("k_again_ex"),
									colour = w.colour or G.C.FILTER,
									card=w.retrigger_card,
									delay = instant and 0.01 or 1/speed
								})

							end
						end
					end
			end
		end
		
    end
		G.GAME.unik_level_up_buffer = nil
	end
	
	

end