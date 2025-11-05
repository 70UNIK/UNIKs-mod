SMODS.Joker {
    key = "unik_energy_compressor",
    atlas = 'placeholders',
    rarity = 2,
    cost = 4,
    pos = { x = 1, y = 0 },
    blueprint_compat = false,
    perishable_compat = true,
	eternal_compat = true,
    immutable = true,
    pronouns = "it_its",
    calculate = function(self, card, context)
        if context.before and not context.blueprint and not context.retrigger_joker then
			G.GAME.unik_store_scoring = true
		end
        if context.unik_energy_compressor and context.energy_compressor_effect ~= nil and context.energy_compressor_value ~= nil and not context.blueprint and not context.retrigger_joker then
            print(context.energy_compressor_effect)
            return {
                [context.energy_compressor_effect] = context.energy_compressor_value
            }
        end
        if context.after then
            G.GAME.unik_store_scoring = nil
        end
    end
}

local scie = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
    if next(find_joker('j_unik_energy_compressor')) and key and G.GAME.unik_store_scoring then
        local stored = false
        G.GAME.unik_stored_scoring = G.GAME.unik_stored_scoring or {
            {type = "x_chips",instances = {}}, -- 1
            {type = "xlog_chips",instances = {}}, -- 2
            {type = "e_chips",instances = {}}, -- 3
            {type = "ee_chips",instances = {}}, -- 4
            {type = "eee_chips",instances = {}}, -- 5
            {type = "hyper_chips",instances = {}}, -- 6
            {type = "x_mult",instances = {}}, -- 7
            {type = "xlog_mult",instances = {}}, --8
            {type = "e_mult",instances = {}}, --9
            {type = "ee_mult",instances = {}},--10
            {type = "eee_mult",instances = {}},--11
            {type = "hyper_mult",instances = {}},--12
        }
        -- if (key == "mult" or key == "mult_mod") then
        --     stored = true
        --     G.GAME.unik_stored_scoring.mult[#G.GAME.unik_stored_scoring.mult+1] = amount
        -- end
        if (key == 'x_mult' or key == 'xmult' or key == 'Xmult_mod' or key == 'x_mult_mod') then
            stored = true
            local index = 7
            G.GAME.unik_stored_scoring[index].instances[#G.GAME.unik_stored_scoring[index].instances+1] = amount
        end
        if  (key == "xlog_mult" or key == "xlogmult" or key == "xlog_mult_mod") then
            stored = true
            local index = 8
            G.GAME.unik_stored_scoring[index].instances[#G.GAME.unik_stored_scoring[index].instances+1] = amount
        end
        if (key == 'e_mult' or key == 'emult' or key == 'Emult_mod') and amount ~= 1 then
            stored = true
            local index = 9
            G.GAME.unik_stored_scoring[index].instances[#G.GAME.unik_stored_scoring[index].instances+1] = amount
        end
        if (key == 'ee_mult' or key == 'eemult' or key == 'EEmult_mod') and amount ~= 1 then
            stored = true
            local index = 10
            G.GAME.unik_stored_scoring[index].instances[#G.GAME.unik_stored_scoring[index].instances+1] = amount
        end
        if (key == 'eee_mult' or key == 'eeemult' or key == 'EEEmult_mod') and amount ~= 1 then
            stored = true
            local index = 11
            G.GAME.unik_stored_scoring[index].instances[#G.GAME.unik_stored_scoring[index].instances+1] = amount
        end
        if (key == 'hyper_mult' or key == 'hypermult' or key == 'hypermult_mod') and type(amount) == 'table' then
            stored = true
            local index = 12
            G.GAME.unik_stored_scoring[index].instances[#G.GAME.unik_stored_scoring[index].instances+1] = amount
        end

        -- if (key == "chip" or key == "chips" or key == "chip_mod" or key == "chips_mod") then
        --     stored = true
        --     G.GAME.unik_stored_scoring.chips[#G.GAME.unik_stored_scoring.chips+1] = amount
        -- end
        if (key == 'x_chips' or key == 'xchips' or key == 'Xchip_mod') and amount ~= 1 then
            stored = true
            local index = 1
            G.GAME.unik_stored_scoring[index].instances[#G.GAME.unik_stored_scoring[index].instances+1] = amount
        end
        if  (key == "xlog_chips" or key == "xlogchips" or key == "xlog_chips_mod") then
            stored = true
            local index = 2
            G.GAME.unik_stored_scoring[index].instances[#G.GAME.unik_stored_scoring[index].instances+1] = amount
        end
        if (key == "e_chips" or key == "echips" or key == "Echip_mod") and amount ~= 1 then
            stored = true
            local index = 3
            G.GAME.unik_stored_scoring[index].instances[#G.GAME.unik_stored_scoring[index].instances+1] = amount
        end
        if (key == 'ee_chips' or key == 'eechips' or key == 'EEchip_mod') and amount ~= 1 then
            stored = true
            local index = 4
            G.GAME.unik_stored_scoring[index].instances[#G.GAME.unik_stored_scoring[index].instances+1] = amount
        end
        if  (key == 'eee_chips' or key == 'eeechips' or key == 'EEEchip_mod') and amount ~= 1 then
            stored = true
            local index = 5
            G.GAME.unik_stored_scoring[index].instances[#G.GAME.unik_stored_scoring[index].instances+1] = amount
        end
        if (key == 'hyper_chips' or key == 'hyperchips' or key == 'hyperchip_mod') and type(amount) == 'table' then
            stored = true
            local index = 6
            G.GAME.unik_stored_scoring[index].instances[#G.GAME.unik_stored_scoring[index].instances+1] = amount
        end
        
        if stored then
            key = nil
            for i,v in pairs(G.jokers.cards) do
                if v.config.center.key == 'j_unik_energy_compressor' then
                    card_eval_status_text(
                        v,
                        "extra",
                        nil,
                        nil,
                        nil,
                        { message = localize("k_unik_stored"), colour = G.C.DARK_EDITION,delay = 0.35 }
                    )
                end
            end
            if not effect.remove_default_message then
                if from_edition then
                    card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = localize('k_unik_redirected'), colour =  G.C.EDITION,delay = 0.35})
                elseif key ~= 'EEchip_mod' then
                    card_eval_status_text(scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, {message = localize('k_unik_redirected'), colour =  G.C.PURPLE,delay = 0.35})
                end
            end
            return true
        end
        
    end
    local ret = scie(effect, scored_card, key, amount, from_edition)
    if ret then
        return ret
    end
end