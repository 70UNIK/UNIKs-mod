SMODS.Atlas({ 
    key = "unik_blindside_exponentia", 
    atlas_table = "ANIMATION_ATLAS", 
    path = "unik_blindside_exponentia.png", 
    px = 34, 
    py = 34, 
frames = 21 })

BLINDSIDE.Joker({
    key = 'unik_blindside_exponentia',
    atlas = 'unik_blindside_exponentia',
    pos = {x=0, y=0},
    boss_colour = HEX("138746"),
    mult = 100,
    base_dollars = 16,
    order = 999999,
    boss = {min = 1,showdown = true,exotic = true},
    active = true,
    in_pool = function(self, args)
        return UNIK.hasBlindside() and CanSpawnExotic()
    end,
    debuff = {
        akyrs_blind_difficulty = "unik_blindside_exotic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
    glitchy_anim = {min = 0, max = 5},
    death_card = {
        card = 'j_cry_exponentia' and (SMODS.Mods["Cryptid"] or {}).can_load or 'j_unik_blindside_exponentia_cry', 
        mod_card = function(self, card) --used to apply editions and/or stickers
            
        end,
        quotes = {'unik_blindside_exponentia_lose'},
        say_times = 3000000000,
    },
    loc_vars = function(self,blind)
        G.GAME.unik_blind_e_mult = G.GAME.unik_blind_e_mult or 1
        return { vars = { G.GAME.unik_blind_e_mult, 0.06 .. "" } }
    end,
    collection_loc_vars = function(self)
        return { vars = { 1 .. "", 0.06 .. "" } }
    end,
    calculate = function(self, blind, context)
        
        if context.setting_blind and not context.disabled and not G.GAME.blind.disabled then
            G.GAME.unik_blind_e_mult = 1
            G.GAME.unik_dynamic_text_realtime = true
        end
        if context.unik_chelsea_trigger and context.card and not G.GAME.blind.disabled then
           return {
                message = "^" ..  G.GAME.unik_blind_e_mult .. localize('k_unik_jmult'),
                colour = G.C.BLACK,
                focus = context.card,
                func = function ()
                    G.HUD_blind:recalculate(true)
                    UNIK.blindside_chips_modifyV2({e_mult = G.GAME.unik_blind_e_mult})  
                    BLINDSIDE.change_fire_amount({amount = 12})
                    BLINDSIDE.add_fire()
                        G.E_MANAGER:add_event(Event({
                        func = (function()
                        G.GAME.blind:wiggle()
                        return true
                        end)
                    }))
                                        G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.8,
                        func = function ()
                            return true
                        end
                    }))
                end
            }
        end
        if (context.after) and not G.GAME.blind.disabled then
            G.GAME.unik_dynamic_text_realtime = true
            G.GAME.unik_blind_e_mult = G.GAME.unik_blind_e_mult or 1
            if G.GAME.unik_blind_e_mult > 1 then
                UNIK.blindside_chips_modifyV2({e_mult = G.GAME.unik_blind_e_mult})   
                BLINDSIDE.change_fire_amount({amount = 12})
                BLINDSIDE.add_fire()
            end
        end
        if context.unik_exponentia_trigger then
             G.GAME.unik_blind_e_mult = G.GAME.unik_blind_e_mult + 0.06
                G.HUD_blind:recalculate(true)
                return {
                    message = "+^" .. 0.06 .. localize('k_unik_jmult'),
                    colour = G.C.BLACK,
                    focus = context.card or nil,
                    -- func = function ()
                    --     G.GAME.unik_blind_e_mult = G.GAME.unik_blind_e_mult + 0.07
                        
                    -- end
                }
        end
        
    end,
    
    disable = function(self)
        G.GAME.unik_blind_e_mult = 1
        G.GAME.unik_dynamic_text_realtime = nil
    end,
    joker_defeat = function()
        G.GAME.unik_blind_e_mult = 1
        G.GAME.unik_dynamic_text_realtime = nil
    end
})

local scie = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
    local ret = scie(effect, scored_card, key, amount, from_edition)
	
    --print("TEST")
    if string.find(key,'mult') then
		if not G.GAME.block_additional_shit2 then
			G.GAME.block_additional_shit2 = true
			SMODS.calculate_context({unik_exponentia_trigger = true, card = scored_card})
			-- for i,v in pairs(G.play.cards) do
			-- 	if v.config.center.key == 'm_unik_blindside_catterfly' and v.ability.unik_in_scoring_hand and not v.debuff and v ~= scored_card then
			-- 		 SMODS.scale_card(v, {
			-- 			ref_table =v.ability.extra,
			-- 			ref_value = "x_chips",
			-- 			scalar_value = "x_chip_mod",
			-- 			message_key = "a_xchips",
			-- 			message_colour = G.C.CHIPS,
			-- 			force_full_val = true,
			-- 			delay = 0.4,
			-- 		})
			-- 	end
			-- end
			G.GAME.block_additional_shit2 = nil
		end
    end
    return ret
end