--Square trim code
SMODS.Shader({
    key = "blindside_square",
    path = "blindside_square.fs",
})
SMODS.Shader({
    key = "blindside_square_back",
    path = "blindside_square_back.fs",
})



SMODS.Seal:take_ownership("bld_wild",{
    legendary_atlas = 'unik_legendary_blind_enhancements',
    legendary_atlas_coords = {x = 0, y = 0},

},true)

SMODS.Seal:take_ownership("bld_tech",{
    legendary_atlas = 'unik_legendary_blind_enhancements',
    legendary_atlas_coords = {x = 1, y = 1},
    
},true)

SMODS.Seal:take_ownership("bld_spooky",{
    legendary_atlas = 'unik_legendary_blind_enhancements',
    legendary_atlas_coords = {x = 1, y = 0},
    
},true)
SMODS.Seal:take_ownership("bld_astral",{
    legendary_atlas = 'unik_legendary_blind_enhancements',
    legendary_atlas_coords = {x = 3, y = 0},
    
},true)

SMODS.Seal:take_ownership("bld_ruin",{
    legendary_atlas = 'unik_legendary_blind_enhancements',
    legendary_atlas_coords = {x = 2, y = 1},
    
},true)
SMODS.Seal:take_ownership("bld_floral",{
    legendary_atlas = 'unik_legendary_blind_enhancements',
    legendary_atlas_coords = {x = 2, y = 0},
    
},true)

SMODS.Seal:take_ownership("bld_hunter",{
    legendary_atlas = 'unik_legendary_blind_enhancements',
    legendary_atlas_coords = {x = 0, y = 1},
    
},true)
SMODS.Seal:take_ownership("bld_frost",{
    legendary_atlas = 'unik_legendary_blind_enhancements',
    legendary_atlas_coords = {x = 3, y = 1},
    
},true)

SMODS.Seal:take_ownership("bld_sticky",{
    legendary_atlas = 'unik_legendary_blind_enhancements',
    legendary_atlas_coords = {x = 1, y = 2},
    
},true)

--changing upgrade sticker if its a legendary blind