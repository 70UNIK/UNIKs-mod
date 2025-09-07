--Patchless version of blind exponents, for maximum compat.

local blindPopupUIHook = create_UIBox_blind_popup
function create_UIBox_blind_popup(blind, discovered, vars)
    local ret = blindPopupUIHook(blind,discovered,vars)
    if discovered then 
        local info_queue = {}
        if AKYRS then
            AKYRS.add_blind_extra_info(blind,nil,{text_size = 0.25, difficulty_text_size = 0.3, full_ui = true, info_queue = info_queue})
        end
        
  
        local _dollars = blind.dollars
        local target = {type = 'raw_descriptions', key = blind.key, set = 'Blind', vars = vars or blind.vars}
        if blind.collection_loc_vars and type(blind.collection_loc_vars) == 'function' then
            local res = blind:collection_loc_vars() or {}
            target.vars = res.vars or target.vars
            target.key = res.key or target.key
        end
        local loc_target = localize(target)
        local ability_text = {}
        if loc_target then 
            for k, v in ipairs(loc_target) do
                ability_text[#ability_text + 1] = {n=G.UIT.R, config={align = "cm"}, nodes={{n=G.UIT.T, config={text = v, scale = 0.35, shadow = true, colour = G.C.WHITE}}}}
            end
        end
         local stake_sprite = get_stake_sprite(G.GAME.stake or 1, 0.4)

        if blind.unik_exponent then
            local exponents = ""
            local exponents2 = ""
            for i = 1, blind.unik_exponent[1] do
            exponents = exponents .. "^"
            end
            if blind.unik_exponent[1] > 5 then
            exponents = ""
            exponents2 = "{" .. blind.unik_exponent[1] .. "}"
            end
            if AKYRS and #info_queue > 0 then
                ret.nodes[1].nodes[1].nodes[2].nodes[1].nodes[2] = {n=G.UIT.R, config={align = "cm"}, nodes={
                    {n=G.UIT.O, config={object = stake_sprite}},
                    {n=G.UIT.T, config={text = exponents .. blind.unik_exponent[2].. exponents2 .. localize('k_unik_base'), scale = 0.4, colour = G.C.RED}},
                }}
            else
                ret.nodes[2].nodes[1].nodes[2] = {n=G.UIT.R, config={align = "cm"}, nodes={
                    {n=G.UIT.O, config={object = stake_sprite}},
                    {n=G.UIT.T, config={text = exponents .. blind.unik_exponent[2].. exponents2 .. localize('k_unik_base'), scale = 0.4, colour = G.C.RED}},
                }}
            end

         elseif blind.high_score_size then
            if AKYRS and #info_queue > 0 then
                ret.nodes[1].nodes[1].nodes[2].nodes[1].nodes[2] = {n=G.UIT.R, config={align = "cm"}, nodes={
                    {n=G.UIT.O, config={object = stake_sprite}},
                    {n=G.UIT.T, config={text = localize('k_unik_high_score'), scale = 0.4, colour = G.C.RED}},
                }}
            else
                ret.nodes[2].nodes[1].nodes[2] = {n=G.UIT.R, config={align = "cm"}, nodes={
                    {n=G.UIT.O, config={object = stake_sprite}},
                    {n=G.UIT.T, config={text = localize('k_unik_high_score'), scale = 0.4, colour = G.C.RED}},
                }}
            end
            
         end
    end
    return ret
end
    