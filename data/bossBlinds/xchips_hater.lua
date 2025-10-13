SMODS.Blind{
    key = 'unik_xchips_hater',
    config = {},
	boss = {
		min = 0,
	},
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 28},
    boss_colour= G.C.CHIPS,
    dollars = 5,
    mult = 2,
    pronouns = "he_him",
    death_message = "special_lose_xchips_hater",
    set_blind = function(self, reset, silent)
        G.GAME.unik_xchips_becomes_mult = true
    end,
    disable = function(self)
        G.GAME.unik_xchips_becomes_mult = nil
    end,
    defeat = function(self)
        G.GAME.unik_xchips_becomes_mult = nil
    end,
    in_pool = function()
        G.GAME.unik_xchips_triggers = G.GAME.unik_xchips_triggers or 0
        if G.GAME.unik_xchips_triggers > 5 then
            return true
        end
        return false
	end,
}

local scie = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
    if G.GAME.unik_xchips_becomes_mult then
        if (key == "e_chips" or key == "echips" or key == "Echip_mod") then
            key = 'x_mult'
        end
        
        if (key == 'x_chips' or key == 'xchips' or key == 'Xchip_mod') then
            key = 'mult'
        end
        if (key == 'ee_chips' or key == 'eechips' or key == 'EEchip_mod') then
            key = 'e_mult'
        end
        if  (key == 'eee_chips' or key == 'eeechips' or key == 'EEEchip_mod') then
            key = 'ee_mult'
        end
        if (key == 'hyper_chips' or key == 'hyperchips' or key == 'hyperchip_mod') then
            key = 'hyper_mult'
        end
    else
        G.GAME.unik_xchips_triggers = G.GAME.unik_xchips_triggers or 0
        if (key == "e_chips" or key == "echips" or key == "Echip_mod") then
            G.GAME.unik_xchips_triggers =  G.GAME.unik_xchips_triggers + 1
        end
        
        if (key == 'x_chips' or key == 'xchips' or key == 'Xchip_mod') then
            G.GAME.unik_xchips_triggers =  G.GAME.unik_xchips_triggers + 1
        end
        if (key == 'ee_chips' or key == 'eechips' or key == 'EEchip_mod') then
            G.GAME.unik_xchips_triggers =  G.GAME.unik_xchips_triggers + 1
        end
        if  (key == 'eee_chips' or key == 'eeechips' or key == 'EEEchip_mod') then
            G.GAME.unik_xchips_triggers =  G.GAME.unik_xchips_triggers + 1
        end
        if (key == 'hyper_chips' or key == 'hyperchips' or key == 'hyperchip_mod') then
            G.GAME.unik_xchips_triggers =  G.GAME.unik_xchips_triggers + 1
        end
    end
    local marked_for_destruction = false
    if next(find_joker('j_unik_xchips_hater')) then
        
        if (key == "e_chips" or key == "echips" or key == "Echip_mod") then
            key = nil
            marked_for_destruction = true
        end
        
        if (key == 'x_chips' or key == 'xchips' or key == 'Xchip_mod') then
            key = nil
             marked_for_destruction = true
        end
        if (key == 'ee_chips' or key == 'eechips' or key == 'EEchip_mod') then
            key = nil
             marked_for_destruction = true
        end
        if  (key == 'eee_chips' or key == 'eeechips' or key == 'EEEchip_mod') then
            key = nil
             marked_for_destruction = true
        end
        if (key == 'hyper_chips' or key == 'hyperchips' or key == 'hyperchip_mod') then
            key = nil
             marked_for_destruction = true
        end
    end
    if marked_for_destruction then
        scored_card.ability.fuck_xchips = true
    end
    if scored_card and scored_card.ability and scored_card.ability.no_score then
        key = nil
    end

    local decrement_multeasers = false
    if (key == "chip" or key == "chips" or key == "chip_mod" or key == "chips_mod") then
        decrement_multeasers = true
    end
    local destroy_multeasers = false
    if (key == "e_chips" or key == "echips" or key == "Echip_mod") then
        destroy_multeasers = true
    end
    
    if (key == 'x_chips' or key == 'xchips' or key == 'Xchip_mod') then
        destroy_multeasers = true
    end
    if (key == 'ee_chips' or key == 'eechips' or key == 'EEchip_mod') then
        destroy_multeasers = true
    end
    if  (key == 'eee_chips' or key == 'eeechips' or key == 'EEEchip_mod') then
        destroy_multeasers = true
    end
    if (key == 'hyper_chips' or key == 'hyperchips' or key == 'hyperchip_mod') then
        destroy_multeasers = true
    end
    if G.jokers and destroy_multeasers then
        for i,v in pairs(G.jokers.cards) do
            if v.config.center.key == 'j_unik_multesers' and not v.ability.extra.destroyed then
                v.ability.extra.destroyed = true
                selfDestruction(v,'k_eaten_ex',G.C.MULT)
                
            end
        end
    end
    if G.jokers and decrement_multeasers then
        for i,v in pairs(G.jokers.cards) do
            if v.config.center.key == 'j_unik_multesers' and not v.ability.extra.destroyed then
                if not v.ability.unik_depleted and lenient_bignum(v.ability.extra.mult - v.ability.extra.mult_mod) <= lenient_bignum(0) then
                    v.ability.extra.destroyed = true
                    selfDestruction(v,'k_eaten_ex',G.C.MULT)
                elseif v.ability.unik_depleted and lenient_bignum(v.ability.extra.mult - v.ability.extra.mult_mod) <= lenient_bignum(v.ability.extra.depleted_threshold) then
                    v.ability.extra.destroyed = true
                    selfDestruction(v,'k_eaten_ex',G.C.MULT)
                else
                    SMODS.scale_card(v, {
                        ref_table = v.ability.extra,
                        ref_value = "mult",
                        scalar_value = "mult_mod",
                        operation = "-",
                        message_key = 'a_mult_minus',
                        message_colour = G.C.MULT,
                    })
                end
            end
        end
    end
    
    local ret = scie(effect, scored_card, key, amount, from_edition)
    if ret then
        return ret
    end
end