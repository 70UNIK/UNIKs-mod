--weird pool inject

--character cards
--spawns character jokers/bos styled ones
--soul spawns at 0.008% rate
--awakening very rarely spawns here.

UNIK.bos_Characters = {
    ['j_' .. UNIK.get_bos_prefix() .. '_oxy'] = true,
    ['j_' .. UNIK.get_bos_prefix() .. '_honey'] = true,
    ['j_' .. UNIK.get_bos_prefix() .. '_haro']  = true,
    ['j_' .. UNIK.get_bos_prefix() .. '_pickel'] = true,
    ['j_' .. UNIK.get_bos_prefix() .. '_cheese'] = true,
    ['j_' .. UNIK.get_bos_prefix() .. '_ratau'] = true,
    ['j_' .. UNIK.get_bos_prefix() .. '_jen'] = true,
    ['j_' .. UNIK.get_bos_prefix() .. '_poppin'] = true,
    ['j_' .. UNIK.get_bos_prefix() .. '_swabbie'] = true,
    ['j_' .. UNIK.get_bos_prefix() .. '_strelitzia'] = true,
    ['j_' .. UNIK.get_bos_prefix() .. '_jeremy'] = true,
    ['j_' .. UNIK.get_bos_prefix() .. '_survivor'] = true,
    ['j_' .. UNIK.get_bos_prefix() .. '_goob'] = true,
    ['j_' .. UNIK.get_bos_prefix() .. '_cosmo'] = true,
    ['j_' .. UNIK.get_bos_prefix() .. '_toodles'] = true,
    ['j_' .. UNIK.get_bos_prefix() .. '_dandy'] = true,
    ['j_' .. UNIK.get_bos_prefix() .. '_suzaku'] = true,
    ['j_' .. UNIK.get_bos_prefix() .. '_monk'] = true,
    ['j_' .. UNIK.get_bos_prefix() .. '_alice'] = true,
}
UNIK.furlatro_characters = {
    j_fur_gale = true,
    
    j_fur_parrotdash = true,
    j_fur_silver = true,
    j_fur_astral = true,
    j_fur_kalik = true,
    j_fur_maltnoodlez = true,
    j_fur_nemzata = true,
    j_fur_potmario = true,
    j_fur_saph = true
}

UNIK.furlatro_talismanless_characters = {
    j_fur_xavierorjose = true,
    j_fur_danny = true,
    j_fur_sourstone3 = true,
}

function UNIK.get_all_characters()
    local characters = {}
    if UNIK.has_bos() then
        for i,v in pairs(UNIK.bos_Characters) do
            characters[i] = true
        end
    end
    if next(SMODS.find_mod("Furlatro")) then
        for i,v in pairs(UNIK.furlatro_characters) do
            characters[i] = true
        end
        if not UNIK.has_talisman() then
            for i,v in pairs(UNIK.furlatro_talismanless_characters) do
                characters[i] = true
            end
        end
    end

    return characters
end
SMODS.ObjectType({
	key = "character",
	default = "j_unik_pibby",
	cards = UNIK.get_all_characters()
})


function UNIK.all_mod_characters()
    local characters = {}
    for i,v in pairs(G.P_CENTERS) do
        if (v.pools and v.pools["character"]) or v.rarity == 'unik_ancient' or string.sub(i,1,5) == "j_" .. UNIK.get_bos_prefix() then
            characters[i] = true
        end
    end
    return characters
end
function UNIK.all_mod_characters_list()
    local characters = {}
    for i,v in pairs(G.P_CENTERS) do
        if (v.pools and v.pools["character"]) or v.rarity == 'unik_ancient' or string.sub(i,1,5) == "j_" .. UNIK.get_bos_prefix() then
            characters[#characters+1] = i
        end
    end
    return characters
end
--todo:
--redeeming furry convention would also inject mythic furries into the pool, would require fuckery with the booster packs or pool though.
