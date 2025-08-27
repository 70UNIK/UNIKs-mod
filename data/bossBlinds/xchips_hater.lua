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
    if next(find_joker('j_unik_xchips_hater')) then
        local marked_for_destruction = false
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
        if  marked_for_destruction then
            G.E_MANAGER:add_event(Event({
                func = function()
                    scored_card.ability.no_score = true
                    scored_card:gore6_break()
                    SMODS.calculate_context({ xchips_hater = true})
                    return true
                end,
            }))
        end
    end
    if scored_card.ability.no_score then
        key = nil
    end
    local ret = scie(effect, scored_card, key, amount, from_edition)
    if ret then
        return ret
    end
end