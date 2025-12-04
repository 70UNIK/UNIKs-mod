SMODS.Blind	{
    key = 'unik_epic_bellows',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = HEX("8f2d14"),
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 32},
    vars = {},
    dollars = 13,
    mult = 2,
    pronouns = "it_its",
    debuff = {
        akyrs_blind_difficulty = "unik_epic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
	press_play = function(self)
G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
        for i = 1, #G.hand.cards do
            G.E_MANAGER:add_event(Event({delay = 0.1, func = function() 
                ease_ante(1)
                G.hand.cards[i]:juice_up()
                G.GAME.blind:wiggle()
                return true end })) 
            G.E_MANAGER:add_event(Event({func = function()
                G.GAME.blind.chips = ((get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling)*1)
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                G.HUD_blind:recalculate(true)
                G.hand_text_area.blind_chips:juice_up()
                play_sound('chips2')
            return true end }))
        end
        return true end })) 
	end,
}