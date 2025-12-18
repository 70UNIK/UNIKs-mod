--crossmod only, this uses cryptid's method of 
local poker_hand_info_ref = G.FUNCS.get_poker_hand_info
function G.FUNCS.get_poker_hand_info(_cards)
     G.GAME.unik_light_dark_bonuses =  G.GAME.unik_light_dark_bonuses or {light = {mult = 1.5, chips = 1.5}, dark = {mult = 1.5,chips = 1.5}}
    local text, loc_disp_text, poker_hands, scoring_hand, disp_text = poker_hand_info_ref(_cards)
    if string.find(string.lower(text),'spectrum')  then
        local darks = 0
        local lights = 0
        
        for i = 1, #scoring_hand do
            if UNIK.is_suit_type(scoring_hand[i],'light') then
                lights = lights + 1
            end
            if UNIK.is_suit_type(scoring_hand[i],'dark') then
                darks = darks + 1
            end
        end
        if darks >= #scoring_hand and lights >= #scoring_hand then
            loc_disp_text = localize("k_unik_gray").." "..loc_disp_text
        elseif darks >= #scoring_hand then
            loc_disp_text = localize("k_unik_dark").." "..loc_disp_text
        elseif lights >= #scoring_hand then
            loc_disp_text = localize("k_unik_light").." "..loc_disp_text
        end
    end
    return text, loc_disp_text, poker_hands, scoring_hand, disp_text
end

function UNIK.modLightDarkSpectrum(initial,text,scoring_hand,type)
    G.GAME.unik_light_dark_bonuses =  G.GAME.unik_light_dark_bonuses or {light = {mult = 1.5, chips = 1.5}, dark = {mult = 1.5,chips = 1.5}}
    if not scoring_hand or not text or not type then
        --print("text, scoring hand or type (mult or chips) is unspecified!")
        return initial
    end
    if string.lower(type) ~= 'mult' and string.lower(type) ~= 'chips' then
        print("type must be 'mult' or 'chips'!")
        return initial
    end
    if string.find(string.lower(text),'spectrum')  then
        local darks = 0
        local lights = 0
        
        for i = 1, #scoring_hand do
            if UNIK.is_suit_type(scoring_hand[i],'light') then
                lights = lights + 1
            end
            if UNIK.is_suit_type(scoring_hand[i],'dark') then
                darks = darks + 1
            end
        end
        if darks >= #scoring_hand then
            initial = initial * G.GAME.unik_light_dark_bonuses.dark[type]
        end
        if lights >= #scoring_hand then
            initial = initial * G.GAME.unik_light_dark_bonuses.light[type]
        end
    end
    return initial
end
--light/dark spectrums have a X1.5 boost to mult and chips, its associated planets increase the boost by +X0.1 and +X0.1
--if you have 5 wild cards, they are considered to become a "grey" spectrum (has both light and dark boosts COMBINED)
--dark side of the moon, bright side of the moon, moon