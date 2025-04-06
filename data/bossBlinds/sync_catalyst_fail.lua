--exclusive to plasma deck or if you have sync catalyst, this will prevent chips and mult from being balanced.--All rankless and suitless cards (stone cards) are debuffed
SMODS.Blind{
    key = 'unik_sync_catalyst_fail',
    config = {},
	boss = {
		min = 1,
	},
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 9},
    boss_colour= G.C.DARK_EDITION,
    dollars = 5,
    mult = 1.5,
	--Only appear if you have at least 5 stone cardsSMODS.has_no_suit(v)
	in_pool = function()
		if G.jokers then
			if G.jokers.cards then
				for i = 1,#G.jokers.cards do
                    if G.jokers.cards[i].config.center.key == "j_cry_sync_catalyst" then
                        return true
                    end
                end
			end
		end
        --Apply effect if with plasma sleeve
        if CardSleeves and G.GAME.selected_sleeve then
            if G.GAME.selected_sleeve == 'sleeve_casl_plasma' then
                return true
            end
        end
        if G.GAME then
            if G.GAME.selected_back.name == "Plasma Deck" then
                return true
            end
        end
        --TODO: plasma sleeve

        return false
	end,
    recalc_debuff = function(self, card, from_blind)
        if (card.area == G.jokers) and card.config.center.key == "j_cry_sync_catalyst" then
            return true
        end
        return false
	end,
    set_blind = function(self)
		G.GAME.unik_killed_by_leak = true
		--To make it work with obsidian orb, it uses flag
		G.GAME.unik_disable_catalyst = true
	end,
	disable = function(self)
		G.GAME.unik_killed_by_leak = nil
		G.GAME.unik_disable_catalyst = nil
	end,
	defeat = function(self)
		G.GAME.unik_killed_by_leak = nil
		G.GAME.unik_disable_catalyst = nil
	end,
}