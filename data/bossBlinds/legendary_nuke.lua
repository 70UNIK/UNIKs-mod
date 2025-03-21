--Doomsday device: ^0.75 blind size, kills you if exceeding ^1.5 blind size. Carries over the effects of Indigo ICBM, as instakills as a normal finisher blind may be wayy too much
--Does NOT have the same requires ^1.5 score 3 times requirements as its assumed it would already have happened during endless
SMODS.Blind{
    key = 'unik_legendary_nuke',
    config = {},
    boss = {min = 1, showdown = true,legendary = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 1},
    boss_colour= HEX("ff0000"),
    dollars = 13,
    mult = 2,
    gameset_config = {
		modest = { disabled = true},
	},
    loc_vars = function(self, info_queue, card)
		return { vars = { ((get_blind_amount(G.GAME.round_resets.ante) * 2 * G.GAME.starting_params.ante_scaling)^0.8)^1.5 } } -- no bignum?
	end,
	collection_loc_vars = function(self)
		return { vars = { localize("k_unik_legendary_nuke_placeholder") } }
	end,
    in_pool = function()

        if G.GAME.round >= 100 or G.GAME.modifiers.unik_legendary_at_any_time then
            if G.GAME.unik_scores_really_big then
                --print(G.GAME.unik_scores_really_big)
                if G.GAME.unik_scores_really_big > 5 then
                    return true
                end
            end
        end
        return false
    end,
    set_blind = function(self, reset, silent)
        local text = localize('k_unik_legendary_nuke_start')
        attention_text({
            scale = 1, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = G.C.RED
        })
        G.GAME.blind.chips = G.GAME.blind.chips^0.8
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        G.HUD_blind:recalculate(true)
        G.GAME.unik_nuke_activate = true
	end,
    disable = function(self)
		G.GAME.unik_nuke_activate = nil
	end,
	defeat = function(self)
		G.GAME.unik_nuke_activate = nil
	end,
}