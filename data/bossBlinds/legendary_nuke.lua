--Doomsday device: ^0.75 blind size, kills you if exceeding ^1.5 blind size. Carries over the effects of Indigo ICBM, as instakills as a normal finisher blind may be wayy too much
--Does NOT have the same requires ^1.5 score 3 times requirements as its assumed it would already have happened during endless
SMODS.Atlas({ 
    key = "unik_legendary_nuke", 
    atlas_table = "ANIMATION_ATLAS", 
    path = "unik_legendary_nuke.png", 
    px = 34, 
    py = 34, 
frames = 21 })
SMODS.Blind{
    key = 'unik_legendary_nuke',
    config = {},
    boss = {min = 1,legendary = true,showdown = true,no_orb = true}, 
    atlas = "unik_legendary_nuke",
    pos = {x=0, y=0},
    boss_colour= HEX("250088"),
    dollars = 13,
    mult = 1,
    unik_exponent = {1,0.8},
    glitchy_anim = true,
    gameset_config = {
		modest = { disabled = true},
	},
    debuff = {
        akyrs_blind_difficulty = "legendary",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
    death_message = "special_lose_unik_nuke_legendary",
    ignore_showdown_check = true,
    loc_vars = function(self, info_queue, card)
		return { vars = { ((get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling)^0.8)^1.666 } } -- no bignum?
	end,
	collection_loc_vars = function(self)
		return { vars = { localize("k_unik_legendary_nuke_placeholder") } }
	end,
    in_pool = function()
        G.GAME.unik_overshoot = G.GAME.unik_overshoot or 0
        if G.GAME.unik_overshoot then
            --print(G.GAME.unik_scores_really_big)
            if G.GAME.unik_overshoot > 3 then
                return CanSpawnLegendary()
            end
        end
        return false
    end,
    set_blind = function(self, reset, silent)
        local text = localize('k_unik_legendary_nuke_start')
        attention_text({
            scale = 1, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = G.C.UNIK_EYE_SEARING_RED
        })
	end,
    unik_after_defeat = function(self,chips,blind_size)
        if to_big(chips) > to_big(blind_size^1.666) then
            return true
        end
        return false
    end
}