--cannibalizing aikoyori's rank function to somehow implement my own apostles
function UNIK.sprite_info_override(_center,_front, card, orig_a, orig_p)
        --if not _center or not _front then return end
    --print(card.config.center_key,_front.suit,_front.value)
    _center = _center or card.config.center
    _front = _front or card.base
    local hc = G.SETTINGS.colour_palettes[card.base] == "hc" and "_hc" or ""
    if _front.value == "paperback_Apostle" then
        if _front.suit == "unik_Noughts" then
            return G.ASSET_ATLAS['unik_ranks' .. hc], { x = 0, y = 1}
        elseif _front.suit == "unik_Crosses" then
            return G.ASSET_ATLAS['unik_ranks' .. hc], { x = 0, y = 0}
        end

    elseif _front.value == "entr_nilrank" then
        if _front.suit == "unik_Noughts" then
            return G.ASSET_ATLAS['unik_nils' .. hc], { x = 1, y = 1}
        elseif _front.suit == "unik_Crosses" then
            return G.ASSET_ATLAS['unik_nils' .. hc], { x = 1, y = 0}
        end
    end

    return orig_a, orig_p
end

function UNIK.is_pure_rank(card)
    if AKYRS then
        if (card.ability.akyrs_special_card_type and (card.ability.akyrs_special_card_type == "rank")) then
            return true
        end
    end
    return false
end

--nil/pure noughts and crosses give X1.2 values
function UNIK.is_pure_suit(card)
    if AKYRS then
        if (card.ability.akyrs_special_card_type and (card.ability.akyrs_special_card_type == "suit")) then
            return true
        end
    end
    return false
end



if AKYRS then
    local suitAtlasHooker = AKYRS.other_mods_suit_to_atlas
	function AKYRS.other_mods_suit_to_atlas(suit_key, card)
		local is_hc = G.SETTINGS.colour_palettes[suit_key] == "hc" and "_hc" or ""
		if suit_key == "unik_Crosses" then
        	return G.ASSET_ATLAS['unik_nils' .. is_hc], { x = 0, y = 0}
        elseif suit_key == "unik_Noughts" then
        	return G.ASSET_ATLAS['unik_nils' .. is_hc], { x = 0, y = 1}
        end
        return suitAtlasHooker(suit_key, card)
	end
    local noughtCrossOverride = AKYRS.should_score_chips
    AKYRS.should_score_chips = function (_c, card)
        local ret = noughtCrossOverride(_c, card)
            --specifically overriding this cause 
        if card.base.suit == 'unik_Noughts' or card.base.suit == 'unik_Crosses' then
            return true
        end
        return ret
    end
end

-- AKYRS.rank_to_atlas = function (rank_key, card)
--     -- if mod dev is reading this i am open to having your stuff be here if you wanna so contact me
--     if rank_key == "paperback_Apostle" then
--         return G.ASSET_ATLAS['akyrs_paperback_pure'], { x = 2, y = 0}
--     end
--     --          nan check v                           
--     if tonumber(rank_key) and (tonumber(rank_key) == tonumber(rank_key)) and tonumber(rank_key) >= 2 and tonumber(rank_key) <= 10 then
--         return G.ASSET_ATLAS['akyrs_rank_suit_cards'], { x = 11 - tonumber(rank_key), y = 1}
--     end
--     if AKYRS.other_mods_rank_to_atlas(rank_key, card) then
--         return AKYRS.other_mods_rank_to_atlas(rank_key, card)
--     end
--     if AKYRS_CROSSMOD.rank_to_atlas_map[rank_key] then
--         local t = AKYRS_CROSSMOD.rank_to_atlas_map[rank_key]
--         if type(t) == "function" then
--             return t(rank_key, card)
--         end
--         if type(t) == "table" then
--             local a, p = unpack(t)
--             if type(a) == "string" then
--                 return G.ASSET_ATLAS[a], p
--             end
--             return a, p
--         end
--     end
--     return G.ASSET_ATLAS['akyrs_rank_suit_cards'], { x = 10, y = 1}
-- end