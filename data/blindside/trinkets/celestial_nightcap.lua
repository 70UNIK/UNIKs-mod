--literally nerfed moonlight cookie (simply +1 mult and +5 chips)
SMODS.Joker {
    key = 'unik_blindside_celestial_nightcap',
    atlas = 'unik_trinkets',
    pos = {x = 0, y = 0},
    rarity = 'bld_keepsake',
    cost = 15,
	blueprint_compat = true,
	eternal_compat = true,
    config = { extra = { mult = 1, chips = 5} },
    in_pool = function(self, args)
        return UNIK.hasBlindside()
    end,
	loc_vars = function(self, info_queue, center)
		return {  
			vars = {center.ability.extra.mult,center.ability.extra.chips} 
		}
	end,
    calculate = function(self, card, context)
		if context.unik_after_levelup and context.hands and context.level_up > 0 then
			if type(context.hands) == 'string' then context.hands = {context.hands} end
			for i,v in ipairs(context.hands) do
							local amount = context.amount or 1
			if amount > 0 then
				G.GAME.hands[v].chips = G.GAME.hands[v].chips+card.ability.extra.chips*amount
			if not context.instant and (not Talisman or not Talisman.config_file.disable_anims) then
				
				update_hand_text({delay = 0.25}, {
					chips = tostring("+"..math.ceil((card.ability.extra.chips)*100)/100), 
					level = G.GAME.hands[v].level,
					handname = localize(v, 'poker_hands'),
				StatusText = true})
				G.E_MANAGER:add_event(Event({
					trigger = "immediate",
					func = function()
						play_sound("chips1",0.95,1)
						return true
					end,
				}))
			end
			if not context.instant then
				delay(0.5)
			end
			
			G.GAME.hands[v].mult = G.GAME.hands[v].mult+card.ability.extra.mult*amount
			if not context.instant and (not Talisman or not Talisman.config_file.disable_anims) then
				update_hand_text({delay = 0.25}, {
					mult = tostring("+"..math.ceil((card.ability.extra.mult)*100)/100), 
					level = G.GAME.hands[v].level,
					handname = localize(v, 'poker_hands'),
					StatusText = true})
				G.E_MANAGER:add_event(Event({
					trigger = "immediate",
					func = function()
						play_sound("multhit1",0.95,1)
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