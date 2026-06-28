
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
    config = { extra = { exp_levelup = 1.5} },
	loc_vars = function(self, info_queue, center)
		local quoteset = 'normal'
		local xmult = 1
		local text = nil
		if G.play then
			text = G.FUNCS.get_poker_hand_info(G.play.cards)
		end
		if (not text or text == 'NULL') and G.hand and G.hand.highlighted then
			text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
		end
		
		if text and text ~= 'NULL' then
			xmult = G.GAME.hands[text].mult
		end
		return {  
			vars = {center.ability.extra.exp_levelup,
			localize(moonlight_quotes[quoteset][math.random(#moonlight_quotes[quoteset])] .. ""),xmult
		} 
		}
	end,
    pools = { ["unik_cookie_run"] = true, ["unik_copyrighted"] = true },
    calculate = function(self, card, context)
		if (context.joker_main) then
			local text = G.FUNCS.get_poker_hand_info(G.play and G.play.cards)
			if G.GAME.hands[text].mult > 1 then
				return {
					x_mult = G.GAME.hands[text].mult
				}
			end
			
		end
		if context.unik_after_levelup and context.hands and context.level_up > 0 then
			if type(context.hands) == 'string' then context.hands = {context.hands} end
			for i,v in ipairs(context.hands) do
							local amount = context.amount or 1
			if amount > 0 then
				G.GAME.hands[v].chips = G.GAME.hands[v].chips*card.ability.extra.exp_levelup^amount
			if not context.instant and (not Talisman or not Talisman.config_file.disable_anims) then
				
				update_hand_text({delay = 0.25}, {
					chips = tostring("X"..math.ceil((card.ability.extra.exp_levelup)*100)/100), 
					level = G.GAME.hands[v].level,
					handname = localize(v, 'poker_hands'),
				StatusText = true})
				G.E_MANAGER:add_event(Event({
					trigger = "immediate",
					func = function()
						play_sound("xchips",0.95,1)
						return true
					end,
				}))
			end
			if not context.instant then
				delay(0.5)
			end
			
			G.GAME.hands[v].mult = G.GAME.hands[v].mult*card.ability.extra.exp_levelup^amount
			if not context.instant and (not Talisman or not Talisman.config_file.disable_anims) then
				update_hand_text({delay = 0.25}, {
					mult = tostring("X"..math.ceil((card.ability.extra.exp_levelup)*100)/100), 
					level = G.GAME.hands[v].level,
					handname = localize(v, 'poker_hands'),
					StatusText = true})
				G.E_MANAGER:add_event(Event({
					trigger = "immediate",
					func = function()
						play_sound("multhit2",0.95,1)
						return true
					end,
				}))
			end
			if not context.instant then
				delay(0.5)
				update_hand_text(
					{sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, 
					{mult = G.GAME.hands[v].mult, chips = G.GAME.hands[v].chips, handname = localize(v, 'poker_hands'), level = G.GAME.hands[v].level}
				)
				delay(0.5)
				update_hand_text(
					{ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
					{ mult = 0, chips = 0, handname = '', level = '' }
				)
			end
			end

			if not context.instant then
				return {
					message = localize("k_upgrade_ex"),
					colour = G.C.DARK_EDITION,
					card = card,
				}
			else
				return {
					message = localize("k_upgrade_ex"),
					colour = G.C.DARK_EDITION,
					card = card,
					delay = 0.05,
				}
			end
			end
			
			
		end
		
    end,

}


local handHook = SMODS.upgrade_poker_hands
function SMODS.upgrade_poker_hands(args)
	local ret = handHook(args)
	if not G.GAME.levelupbuffer then
		G.GAME.levelupbuffer = true
		SMODS.calculate_context({unik_after_levelup = true, card = args.from, hands = args.hands, instant = args.instant, level_up = args.level_up or 1})
		G.GAME.levelupbuffer = nil
	end
	return args
end
