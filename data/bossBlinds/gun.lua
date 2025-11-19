SMODS.Blind{
    key = 'unik_gun',
    config = {},
	boss = {
		min = 2,
	},
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 39},
    boss_colour= HEX("ff7500"),
    dollars = 5,
    mult = 2,
    pronouns = "he_him",
    calculate = function(self, blind, context)
		if context.discard and context.other_card and not G.GAME.blind.disabled then
             G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    context.other_card.ability.unik_triggering = true
                    context.other_card.ability.unik_can_autotrigger = true
                    G.GAME.blind.triggered = true
                    G.GAME.blind:wiggle()
                return true
                end,
            }))
		end
	end,
    set_blind = function(self, reset, silent)
        for i,v in pairs(G.consumeables.cards) do
             G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    v.ability.unik_triggering = true
                    v.ability.unik_can_autotrigger = true
                    G.GAME.blind.triggered = true
                    G.GAME.blind:wiggle()
                return true
                end,
            }))

        end

    end
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