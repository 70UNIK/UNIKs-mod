--labels for blinds if aiko's is installed
AKYRS.DescriptionDummy{
    key = "epic_blind"
}
AKYRS.DescriptionDummy{
    key = "legendary_blind"
}
AKYRS.DescriptionDummy{
    key = "unskippable_blind"
}
AKYRS.DescriptionDummy{
    key = "all_unskippable_blinds"
}
AKYRS.DescriptionDummy{
    key = "nuke_high_score_penalty"
}
AKYRS.DescriptionDummy{
    key = "instant_death_risk"
}


--hook\
local other_icon_pos = AKYRS.other_mods_blind_icons_pos
AKYRS.other_mods_blind_icons_pos = function(key)
    
    if key == "epic_blind" or key == "epic_blind_no_almanac" then          return  { x = 0, y = 0} end
    if key == "legendary_blind" then          return  { x = 1, y = 0} end
    if key == "unskippable_blind" then          return  { x = 2, y = 0} end
    if key == "all_unskippable_blinds" then          return  { x = 3, y = 0} end
    return other_icon_pos(key)
end

-- local other_icon = AKYRS.other_mods_blind_icons
-- AKYRS.other_mods_blind_icons = function(blind,ability_text_table,extras)
    
--     extras = extras or {}
--     local icon_size = extras.icon_size or 0.5
--     local fsz = extras.text_size or 0.5
--     local dfctysz = extras.difficulty_text_size or 0.5
--     local bsz = extras.border_size or 1
--     local set_parent_child = extras.set_parent_child or false
--     local cache = extras.cached_icons or false
--     local full_ui = extras.full_ui or false
--     local hide = extras.hide or {  }
--     local row = extras.row or false
--     local info_queue = extras.info_queue or {}
--     local z = {}
--     if blind.boss and blind.boss.epic then
--         if (pseudorandom(pseudoseed("funny_desc_no_almanac")) < ((G.GAME.probabilities.normal * 1) / 4)) then
--              AKYRS.generate_icon_blinds("epic_blind_no_almanac",{table = z,cache = cache,icon_size = icon_size,full_ui = full_ui,font_size = fsz,text_size_for_full = dfctysz, atlas = "unik_akio_icons", info_queue = info_queue})
--         else
--             AKYRS.generate_icon_blinds("epic_blind",{ table = z,cache = cache,icon_size = icon_size,full_ui = full_ui,font_size = fsz,text_size_for_full = dfctysz, atlas = "unik_akio_icons",info_queue = info_queue})
--         end
--     end
--     if blind.boss and blind.boss.legendary then
--         AKYRS.generate_icon_blinds("legendary_blind",{table = z,cache = cache,icon_size = icon_size,full_ui = full_ui,font_size = fsz,text_size_for_full = dfctysz, atlas = "unik_akio_icons", info_queue = info_queue})
--     end
--     if blind.debuff.unik_unskippable_blind then
--         AKYRS.generate_icon_blinds("unskippable_blind",{table = z,cache = cache,icon_size = icon_size,full_ui = full_ui,font_size = fsz,text_size_for_full = dfctysz, atlas = "unik_akio_icons", info_queue = info_queue})
--     end
--     --test to see if the hook even works
--     other_icon(blind,ability_text_table,extras)
-- end

--clone override to display epic blind stuff
