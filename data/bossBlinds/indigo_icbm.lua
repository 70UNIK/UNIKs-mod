SMODS.Blind{
    key = 'unik_indigo_icbm',
    config = {},
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 1},
    boss_colour= HEX("250088"),
    dollars = 8,
    mult = 0.5,
    loc_vars = function(self, info_queue, card)
		return { vars = { 3 * get_blind_amount(G.GAME.round_resets.ante) * 0.5 * G.GAME.starting_params.ante_scaling } } -- no bignum?
	end,
	collection_loc_vars = function(self)
		return { vars = { localize("k_unik_nuke_placeholder") } }
	end,
    set_blind = function(self, reset, silent)
        local text = localize('k_unik_nuke_start')
        attention_text({
            scale = 1, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
        })
        G.GAME.unik_nuke_activate = true
	end,
    disable = function(self)
		G.GAME.unik_nuke_activate = nil
	end,
	defeat = function(self)
		G.GAME.unik_nuke_activate = nil
	end,
}