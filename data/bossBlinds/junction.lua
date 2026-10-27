SMODS.Blind	{
    key = 'unik_junction',
    config = {},
    boss = {min = 3}, 
    boss_colour = HEX("B53E16"),
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 45},
    vars = {},
    dollars = 5,
    mult = 2,
    set_blind = function(self, reset, silent)
        if not reset then
            G.GAME.blind:wiggle()
            G.GAME.blind.triggered = true
            G.GAME.unik_mortons_fork = true --flag will prevent other booster tags from triggering and draw cards afterwards if in blind.
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    local key = "p_unik_baneful_significant_1"
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