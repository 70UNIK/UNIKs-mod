--weird pool inject

--character cards
--spawns character jokers/almanac styled ones
--soul spawns at 0.008% rate
--awakening very rarely spawns here.

UNIK.Almanac_Characters = {
    j_jen_oxy = true,
    j_jen_honey = true,
    j_jen_haro  = true,
    j_jen_pickel = true,
    j_jen_cheese = true,
    j_jen_ratau = true,
    j_jen_jen = true,
    j_jen_poppin = true,
    j_jen_swabbie = true,
    j_jen_strelitzia = true,
    j_jen_jeremy = true,
    j_jen_survivor = true,
    j_jen_goob = true,
    j_jen_cosmo = true,
    j_jen_toodles = true,
    j_jen_dandy = true,
    j_jen_suzaku = true,
    j_jen_monk = true,
    j_jen_alice = true,
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
    if UNIK.has_almanac() then
        for i,v in pairs(UNIK.Almanac_Characters) do
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

--todo:
--redeeming furry convention would also inject mythic furries into the pool, would require fuckery with the booster packs or pool though.
