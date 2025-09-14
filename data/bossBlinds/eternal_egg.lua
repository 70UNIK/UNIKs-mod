SMODS.Blind	{
    key = 'unik_fuck_eternal_egg',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true},
    boss_colour = HEX("f0e2bc"),
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 30},
    vars = {},
    dollars = 8,
    mult = 2,
    pronouns = "he_him",
	death_message = 'special_lose_eternal_egg',
    set_blind = function(self, reset, silent)
        if not reset then
            G.GAME.blind:wiggle()
            G.GAME.blind.triggered = true
            G.GAME.unik_mortons_fork = true --flag will prevent other booster tags from triggering and draw cards afterwards if in blind.
            G.GAME.lartceps_pack_pity = 0
            if G.jokers.cards then
				G.GAME.blind:wiggle()
				G.GAME.blind.triggered = true
				for i,v in pairs(G.jokers.cards) do
					v:juice_up(0,0.25)
				end
			end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    local key = "p_unik_egg_pack"
                    local card = Card(
                        G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
                        G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
                        G.CARD_W * 1.27,
                        G.CARD_H * 1.27,
                        G.P_CARDS.empty,
                        G.P_CENTERS[key],
                        { bypass_discovery_center = true, bypass_discovery_ui = true }
                    )
                    card.cost = 0
                    card.from_tag = true
                    G.FUNCS.use_card({ config = { ref_table = card } })
                    card:start_materialize()
                    pack_opened = true
                    return true
                end,
            }))
        end
    end
}