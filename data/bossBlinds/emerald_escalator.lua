SMODS.Blind{
    key = 'unik_emerald_escalator',
    config = {},
	boss = {
		min = 1, showdown = true
	},
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 35},
    boss_colour= HEX("50c878"),
    dollars = 8,
    mult = 0.7,
    pronouns = "it_its",
    calculate = function(self, blind, context)
		if context.post_trigger and not G.GAME.blind.disabled and not context.other_context.fixed_probability and not context.other_context.fix_probability and not context.other_context.mod_probability then
             G.E_MANAGER:add_event(Event({func = function()
                G.GAME.blind.chips = G.GAME.blind.chips*1.25
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                G.HUD_blind:recalculate(true)
                G.hand_text_area.blind_chips:juice_up()
                G.GAME.blind.triggered = true
                    G.GAME.blind:wiggle()
                play_sound('chips2')
            return true end }))
		end
	end,
    disable = function(self, silent)
		G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
	end,
    -- unik_before_play = function(self)
    --     for i,v in pairs(G.hand.cards) do
    --         if (not v.edition)then
    --             v:set_edition({ unik_corrupted = true }, true,nil, true)

    --         end
    --     end

    --     for i,v in pairs(G.jokers.cards) do
    --         if (not v.edition)then
    --             v:set_edition({ unik_corrupted = true }, true,nil, true)
    --         end
    --     end
    --     G.GAME.blind.triggered = true
    --     G.GAME.blind:wiggle()
	-- end,
}