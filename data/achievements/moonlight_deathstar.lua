--own moonlight cookie and deathstar without perkeo
SMODS.Achievement{
    key = "unik_death_star_moonlight",
    order = 1,
    bypass_all_unlocked = true,
    hidden_text = true,
    atlas = "achievements",
    pos = { x = 3, y = 0 },
    --reset_on_startup = true,
    unlock_condition = function(self, args)
        local moonlight = false
        local perkeo = false
        local deathstar = false
        if args.type == "modify_jokers" then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].config.center.key == "j_unik_moonlight_cookie" then
					moonlight = true
				end
                if G.jokers.cards[i].config.center.key == "j_perkeo" then
					perkeo = true
				end
                if G.jokers.cards[i].config.center.key == "j_cry_stella_mortis" then
					deathstar = true
				end
			end
            if deathstar and moonlight and not perkeo then
                return true
            end
		end
    end,
}