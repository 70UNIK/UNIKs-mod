--Patchless version of blind exponents, for maximum compat.

function UNIK.custom_base_size(blind,discovered,vars)
    if discovered then 
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
            return {n=G.UIT.T, config={text = exponents .. blind.unik_exponent[2].. exponents2 .. localize('k_unik_base'), scale = 0.4, colour = G.C.RED}}
         elseif blind.high_score_size then
            return {n=G.UIT.T, config={text = localize('k_unik_high_score'), scale = 0.4, colour = G.C.RED}}
         end
    end
    return nil
end