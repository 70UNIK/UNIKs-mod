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
	demicolon_compat = true,
	pronouns = "she_her",
    config = { extra = { exp_levelup = 1.3,spawn_rate = 5} },
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
		--forcetrigger,
		if context.forcetrigger then
			local speed = 1
			local hand2 = context.scoring_name or G.FUNCS.get_poker_hand_info(G.play.cards) or nil
			if hand2 then
				for i,v in pairs(G.consumeables.cards) do
					speed = speed * 1.2
					moonlightlevelStructure(hand2,v,card,context.levelup_instant,speed)
				end
			elseif #G.hand.highlighted > 0 then
				local text, disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
				--print(text)
				for i,v in pairs(G.consumeables.cards) do
					speed = speed * 1.2
					moonlightlevelStructure(text,v,card,context.levelup_instant,speed)
				end
			end
			return {
				
			}
		end
		if context.hand_levelup_held_consume and ((context.levelup_amount and lenient_bignum(context.levelup_amount) > lenient_bignum(0)) or not context.levelup_amount) then
			local v = context.other_consumeable_lvlup
			moonlightlevelStructure(context.levelup_poker_hand,v,card,context.levelup_instant,context.levelupspeed)
			return{
				
			}
		end
		
    end,

}

function moonlightlevelStructure(hand,consumeble,card,instant,speed)
	local upgrade = false
	local v = consumeble
		if v.debuff then
			card_eval_status_text(card, "debuff", nil, nil, nil, nil)
			v:juice_up(0.8, 0.5)
			return
		end
		--individual planets
		if v.ability.hand_type then
			--print(v.ability.hand_type)
			--print(hand)
		end
		if v.ability.hand_type and v.ability.hand_type == hand then
			-- card_eval_status_text(card, "extra", nil, nil, nil, {
			-- 	message = localize("k_upgrade_ex"),
			-- 	colour = G.C.DARK_EDITION,
			-- 	card=card,
			-- })
			local hand = hand
			exponentLevelExtra(hand,card.ability.extra.exp_levelup,v,instant,false,speed)
			upgrade = true
			
		end
		--ruutu, etc...
		if v.ability.hand_types then
			for i = 1,#v.ability.hand_types do
				--print(v.ability.hand_types[i])
				if v.ability.hand_types[i] == hand then
					local hand = hand
					exponentLevelExtra(hand,card.ability.extra.exp_levelup,v,instant,false,speed)
					upgrade = true
					break
				end
			end
			--print(hand)
		end
		--Bhole
		if v.config.center.key == "c_black_hole" then
			exponentLevelExtra(hand,card.ability.extra.exp_levelup,v,instant,false,speed)
			upgrade = true
		end
		--planetlua
		if v.config.center.key == "c_cry_planetlua" then
			if v.ability.immutable and v.ability.immutable.overflow_amount then
				for i = 1, v.ability.immutable.overflow_amount do
					if
						SMODS.pseudorandom_probability(
							v,
							"planetlua",
							1,
							v and v.ability.extra.odds or 5
						)
					then
						exponentLevelExtra(hand,card.ability.extra.exp_levelup,v,instant,true,speed)
						upgrade = true
					else
						if not instant then
							card_eval_status_text(v, "extra", nil, nil, nil, {
								message = localize("k_nope_ex"),
								colour = G.C.SECONDARY_SET.Planet,
								delay = 1/speed,
							})
						else
							card_eval_status_text(v, "extra", nil, nil, nil, {
								message = localize("k_nope_ex"),
								colour = G.C.SECONDARY_SET.Planet,
								delay = 0.1/speed,
							})
						end
					end
				end
			else
				if
					SMODS.pseudorandom_probability(
						v,
						"planetlua",
						1,
						v and v.ability.extra.odds or 5
					)
				then
					exponentLevelExtra(hand,card.ability.extra.exp_levelup,v,instant,false,speed)
					upgrade = true
				else
					if not instant then
						card_eval_status_text(v, "extra", nil, nil, nil, {
							message = localize("k_nope_ex"),
							colour = G.C.SECONDARY_SET.Planet,
							delay = 1/speed,
						})
					else
						card_eval_status_text(v, "extra", nil, nil, nil, {
							message = localize("k_nope_ex"),
							colour = G.C.SECONDARY_SET.Planet,
							delay = 0.1/speed,
						})
					end
				end
			end
		end
	if upgrade then
		if not instant then
			card_eval_status_text(card, "extra", nil, nil, nil, {
				message = localize("k_upgrade_ex"),
				colour = G.C.DARK_EDITION,
				delay = 1/speed,
			})
		else
			card_eval_status_text(card, "extra", nil, nil, nil, {
				message = localize("k_upgrade_ex"),
				colour = G.C.DARK_EDITION,
				delay = 0.1/speed,
			})
		end
		
	end
end

function exponentLevelExtra(hand,exponent,v,instant,no_exp,speed)
	--print("g")
	if not instant and (not Talisman or not  Talisman.config_file.disable_anims) then
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
	local repetitions = 1
	if v.ability.immutable and v.ability.immutable.overflow_amount and not no_exp then
		repetitions = v.ability.immutable.overflow_amount or 1
	end
	G.GAME.hands[hand].mult = G.GAME.hands[hand].mult*exponent^ repetitions
	G.GAME.hands[hand].chips = G.GAME.hands[hand].chips*exponent^ repetitions
	if not instant and (not Talisman or not Talisman.config_file.disable_anims) then
		update_hand_text({delay = 0}, {mult = tostring("X"..math.ceil((exponent^ repetitions)*100)/100), StatusText = true})
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			func = function()
				play_sound("multhit2",0.8+speed*0.1,1)
				v:juice_up(0.8, 0.5,1)
				return true
			end,
		}))
		delay(1/speed)
		update_hand_text({delay = 0}, {chips = tostring("X"..math.ceil((exponent^ repetitions)*100)/100), StatusText = true})
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			func = function()
				play_sound("xchips",0.8+speed*0.1,1)
				v:juice_up(0.8, 0.5)
				return true
			end,
		}))
		delay(1/speed)
	end
end

local levelUpHook = level_up_hand
function level_up_hand(card, hand, instant, amount)
	levelUpHook(card, hand, instant, amount)
	if not G.GAME.unik_level_up_buffer then
		G.GAME.unik_level_up_buffer = true
		local speed = 1
		for i,v in pairs(G.consumeables.cards) do
			SMODS.calculate_context({hand_levelup_held_consume = true,other_consumeable_lvlup = v, levelup_poker_hand = hand, levelup_instant = instant, levelup_amount = amount, levelupspeed = speed},eval)
			speed = speed * 1.2
			
		end
		G.GAME.unik_level_up_buffer = nil
	end
	
	

end