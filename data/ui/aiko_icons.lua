--aiko icons 2.0
-- Now I can fully add them in as I wish
--Epic/Legendary Blinds and unskippable ante.

AKYRS.DescriptionDummy{
    key = "unik_all_unskippable_blinds"
}
AKYRS.DescriptionDummy{
    key = "unik_epic_blind"
}
AKYRS.DescriptionDummy{
    key = "unik_legendary_blind"
}
local original_blind_icon_pos = AKYRS.other_mods_blind_icons_pos
AKYRS.other_mods_blind_icons_pos = function(key)
    -- insert your code over here
    if key == "unik_epic" then 
        return G.ASSET_ATLAS["unik_akio_icons"], { x = 0, y = 0 } 
    end
    if key == "unik_legendary" then 
        return G.ASSET_ATLAS["unik_akio_icons"], { x = 1, y = 0 } 
    end
    if key == "unik_all_unskippable_blinds" then 
        return G.ASSET_ATLAS["unik_akio_icons"], { x = 3, y = 0 } 
    end
    return original_blind_icon_pos(key)
end

local original_other_mods_blind_icon = AKYRS.other_mods_blind_icons
AKYRS.other_mods_blind_icons = function(blind,ability_text_table,extras,data)
    if blind.debuff.unik_all_unskippable_blinds then
        AKYRS.generate_icon_blinds("unik_all_unskippable_blinds",data)
    end
    original_other_mods_blind_icon(blind,ability_text_table,extras,data)
end