--^1 Chips per hand, increase this by ^0.07 chips per purple blind scored, all played blinds must be purple
BLINDSIDE.Joker({
    key = 'unik_blindside_unik',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=0},
    boss_colour = HEX("ff6deb"),
    mult = 16,
    base_dollars = 16,
    order = 999999,
    boss = {min = 1,showdown = true,ancient = true},
    active = true,
    blind_data = {e_chips = 1,e_chips_mod = 0.07},
    in_pool = function(self, args)
        return UNIK.hasBlindside() and CanSpawnAncient()
    end,
    loc_vars = function(self,blind)
        G.GAME.unik_blind_e_mult = G.GAME.unik_blind_e_mult or 1
        return { vars = { G.GAME.unik_blind_e_mult, 0.07 .. "" } }
    end,
    collection_loc_vars = function(self)
        return { vars = { 1 .. "", 0.07 .. "" } }
    end,
    get_loc_debuff_text = function(self)
        return localize("k_unik_all_purple")
		
	end,
    death_card = {
        card = 'j_unik_unik', 
        mod_card = function(self, card) --used to apply editions and/or stickers
            
        end,
        quotes = {'unik_blindside_unik_lose1','unik_blindside_unik_lose2','unik_blindside_unik_lose3'},
        say_times = 7,
    },
    calculate = function(self, blind, context)
        if context.setting_blind and not context.disabled and not G.GAME.blind.disabled then
            G.GAME.unik_dynamic_text_realtime = true
            G.GAME.unik_blind_e_mult = 1
        end
        if (context.after) and not G.GAME.blind.disabled then
            G.GAME.unik_blind_e_mult = G.GAME.unik_blind_e_mult or 1
            if G.GAME.unik_blind_e_mult > 1 then
                UNIK.blindside_chips_modifyV2({e_chips = G.GAME.unik_blind_e_mult})   
                G.GAME.playing_with_fire_num = G.GAME.playing_with_fire_num + 1
                G.GAME.playing_with_fire_each = G.GAME.used_vouchers.v_bld_swearjar and "bld_playing_with_fire_each_3" or "bld_playing_with_fire_each_2"
                G.GAME.playing_with_fire = G.GAME.playing_with_fire + 4 + (G.GAME.used_vouchers.v_bld_swearjar and 1 or 0)
            end
           
            
        end
        if context.scoring_hand and context.individual and context.cardarea == G.play and not G.GAME.blind.disabled then
            if context.other_card:is_color('Purple') and context.other_card.facing ~= 'back' then
                G.GAME.unik_blind_e_mult = G.GAME.unik_blind_e_mult + 0.07
                return {
                    message = "+^" .. 0.07 .. localize('k_unik_jchips'),
                    colour = G.C.BLACK,
                    focus = context.other_card,
                    -- func = function ()
                    --     G.GAME.unik_blind_e_mult = G.GAME.unik_blind_e_mult + 0.07
                        
                    -- end
                }
            end
        end
    end,
    debuff_hand = function(self, cards, hand, handname, check)
        for i,v in pairs(cards) do
            if not v:is_color('Purple') then
                return true
            end
        end
        return false
    end,
    disable = function(self)
        G.GAME.unik_dynamic_text_realtime = nil
        G.GAME.unik_blind_e_mult = 1
    end,
    joker_defeat = function()
        G.GAME.unik_dynamic_text_realtime = nil
        G.GAME.unik_blind_e_mult = 1
    end
})

--better version
function UNIK.blindside_chips_modifyV2(operation,silent,originalchips)
    if operation then
        if operation.x_chips and operation.x_chips ~= 1 then
            G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.3, func = function()
            G.GAME.blind.basechips = G.GAME.blind.basechips*operation.x_chips
            G.hand_text_area.blind_chip_text:juice_up()
                G.GAME.blind.basechips_text = number_format(G.GAME.blind.basechips, 100000)
                if not silent then play_sound('xchips',0.95,1) end
                return true
            end}))
        end
        if operation.e_chips and operation.e_chips ~= 1 then
            G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.3, func = function()
            G.GAME.blind.basechips = G.GAME.blind.basechips^operation.e_chips
            G.hand_text_area.blind_chip_text:juice_up()
                G.GAME.blind.basechips_text = number_format(G.GAME.blind.basechips, 100000)
                if not silent then play_sound('unik_echip',0.95,1) end
                return true
            end}))
        end
        if operation.x_mult and operation.x_mult ~= 1 then
            G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.3, func = function()
            G.GAME.blind.mult = G.GAME.blind.mult*operation.x_mult
            G.hand_text_area.blind_mult_text:juice_up()
                G.GAME.blind.mult_text = number_format(G.GAME.blind.mult)
                if not silent then play_sound('multhit2',0.95,1) end
                return true
            end}))
        end
        if operation.e_mult and operation.e_mult ~= 1 then
            G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.3, func = function()
            G.GAME.blind.mult = G.GAME.blind.mult^operation.e_mult
            G.hand_text_area.blind_mult_text:juice_up()
                G.GAME.blind.mult_text = number_format(G.GAME.blind.mult)
                if not silent then play_sound('unik_emult',0.95,1) end
                return true
            end}))
        end
    end
    
end

