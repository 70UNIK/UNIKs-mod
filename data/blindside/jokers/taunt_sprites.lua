--Taunt sprites
--All credit goes to the authors and mods of these sprites. these are just added for the sole purpose of quips for when their associated mod is not installed. They are never supposed to be obtained in gameplay; doing so will 
--cause them to self destruct. (If taw, will immediately cause a game over instead)


SMODS.Rarity({
	key = "unik_nil_rarity",
	loc_txt = {},
	badge_colour = HEX("aaaaaa"),
	fallback_joker = 'j_unik_autocannibalism',
    no_doe = true,
    no_collection = true,
    in_pool = function()
        return false
    end
})

SMODS.Atlas {
	key = "unik_taunt_sprites",
	path = "unik_taunt_sprites.png",
	px = 71,
	py = 95
}

if not UNIK.has_bos() then
    print("LOADING TAUNT SPRITE PWX")
    SMODS.Joker({
        key='unik_blindside_taunt_oxy_pwx',
        atlas = 'unik_taunt_sprites',
        order = 10^300,
        cost = 66666666,
        pos = {x = 0, y = 0},
        soul_pos = {x = 1, y = 0},
        no_doe = true,
        no_collection = true,
        in_pool = function()
            return false
        end
    })
    SMODS.Joker({
        key='unik_blindside_taunt_goob_pwx',
        order = 10^300,
        atlas = 'unik_taunt_sprites',
        cost = 66666666,
        pos = {x = 0, y = 1},
        soul_pos = {x = 1, y = 1},
        no_doe = true,
        no_collection = true,
        in_pool = function()
            return false
        end
    })
end
if not next(SMODS.find_mod("Bunco")) then
    print("LOADING TAUNT SPRITE BUNCO")
    SMODS.Joker({
        key='unik_blindside_fiendish_joker_bunc',
        order = 10^300,
        atlas = 'unik_taunt_sprites',
        cost = 66666666,
        pos = {x = 2, y = 0},
        no_doe = true,
        no_collection = true,
        in_pool = function()
            return false
        end
    })
end

if not next(SMODS.find_mod("paperback")) then
    print("LOADING TAUNT SPRITE PAPERBACK")
    SMODS.Joker({
        key='unik_blindside_whitenight_paperback',
        order = 10^300,
        atlas = 'unik_taunt_sprites',
        cost = 66666666,
        pos = {x = 0, y = 2},
        soul_pos = {x = 1, y = 2},
        no_doe = true,
        no_collection = true,
        in_pool = function()
            return false
        end
    })
end
if not (SMODS.Mods["Cryptid"] or {}).can_load then
    print("LOADING TAUNT SPRITE cryprid")
    SMODS.Joker({
        key='unik_blindside_formidiulosus_cry',
        order = 10^300,
        atlas = 'unik_taunt_sprites',
        cost = 66666666,
        pos = {x = 0, y = 3},
        soul_pos = { x = 2, y = 3, extra = { x = 1, y = 3 } },
        no_doe = true,
        no_collection = true,
        in_pool = function()
            return false
        end
    })
    SMODS.Joker({
        key='unik_blindside_exponentia_cry',
        order = 10^300,
        atlas = 'unik_taunt_sprites',
        cost = 66666666,
        pos = {x = 0, y = 4},
        soul_pos = { x = 2, y = 4, extra = { x = 1, y = 4 } },
        no_doe = true,
        no_collection = true,
        in_pool = function()
            return false
        end
    })
    SMODS.Joker({
        key='unik_blindside_facile_cry',
        order = 10^300,
        atlas = 'unik_taunt_sprites',
        cost = 66666666,
        pos = {x = 3, y = 1},
        soul_pos = { x = 5, y = 1, extra = { x = 4, y = 1 } },
        no_doe = true,
        no_collection = true,
        in_pool = function()
            return false
        end
    })
    SMODS.Joker({
        key='unik_blindside_redeo_cry',
        order = 10^300,
        atlas = 'unik_taunt_sprites',
        cost = 66666666,
        pos = {x = 3, y = 2},
        soul_pos = { x = 5, y = 2, extra = { x = 4, y = 2 } },
        no_doe = true,
        no_collection = true,
        in_pool = function()
            return false
        end
    })
    SMODS.Joker({
        key='unik_blindside_effarcire_cry',
        order = 10^300,
        atlas = 'unik_taunt_sprites',
        cost = 66666666,
        pos = {x = 3, y = 0},
        soul_pos = { x = 5, y = 0, extra = { x = 4, y = 0 } },
        no_doe = true,
        no_collection = true,
        in_pool = function()
            return false
        end
    })
end

-- flippy quips
--losing against a cursed joker
for i=1,4 do
    SMODS.JimboQuip{
        key = "unik_blindside_cursed_lose"..tostring(i),
        type = 'bld_loss',
        extra = {center = "m_bld_flip",googly = true},
        filter = function(quip, type) 
            if type == "bld_loss" and G.GAME.blind.config.blind.cursed then return true, {override_base_checks = true} end
        end
    }
end