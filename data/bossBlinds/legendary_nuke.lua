--Doomsday device: ^0.75 blind size, kills you if exceeding ^1.5 blind size. Carries over the effects of Indigo ICBM, as instakills as a normal finisher blind may be wayy too much
--Does NOT have the same requires ^1.5 score 3 times requirements as its assumed it would already have happened during endless
SMODS.Blind{
    key = 'unik_legendary_nuke',
    config = {},
    boss = {min = 1,legendary = true,showdown = true}, 
    atlas = "unik_legendary_blinds",
    pos = {x=0, y=2},
    boss_colour= HEX("600000"),
    dollars = 13,
    mult = 2,
    gameset_config = {
		modest = { disabled = true},
	},
    ignore_showdown_check = true,
    loc_vars = function(self, info_queue, card)
		return { vars = { ((get_blind_amount(G.GAME.round_resets.ante) * 2 * G.GAME.starting_params.ante_scaling)^0.8)^1.666 } } -- no bignum?
	end,
	collection_loc_vars = function(self)
		return { vars = { localize("k_unik_legendary_nuke_placeholder") } }
	end,
    in_pool = function()
        local hasExotic = false
        if not G.jokers or not G.jokers.cards then
			return false
		end
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].config.center.rarity == "cry_exotic" then
                hasExotic = true
            end
        end

        if Cryptid.gameset() ~= "modest" and ((G.GAME.round >= 100 and hasExotic) or G.GAME.modifiers.unik_legendary_at_any_time) then
            if G.GAME.unik_scores_really_big then
                --print(G.GAME.unik_scores_really_big)
                if G.GAME.unik_scores_really_big > 6 then
                    return true
                end
            end
        end
        return false
    end,
    set_blind = function(self, reset, silent)
        local text = localize('k_unik_legendary_nuke_start')
        attention_text({
            scale = 1, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = G.C.UNIK_EYE_SEARING_RED
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