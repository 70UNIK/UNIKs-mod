--All non editioned jokers and cards become corrupted after play or discard
SMODS.Atlas({ 
    key = "unik_darkness", 
    atlas_table = "ANIMATION_ATLAS", 
    path = "unik_darkness.png", 
    px = 34, 
    py = 34, 
frames = 21 })
SMODS.Blind{
    key = 'unik_darkness',
    config = {},
	boss = {
		min = 8,
	},
    atlas = "unik_darkness",
    pos = { x = 0, y = 0},
    boss_colour= HEX("222222"),
    dollars = 5,
    mult = 2,
    in_pool = function()
        if G.GAME.round_resets.blind_ante > G.GAME.win_ante then
			return true
		else
			return false
		end
	end,
    glitchy_anim = true,
    calculate = function(self, blind, context)
		if context.discard and not G.GAME.blind.disabled then
			--visual cue to wiggle all jokers
			for i,v in pairs(G.hand.cards) do
                if (not v.edition)then
                    v:set_edition({ unik_corrupted = true }, true,nil, true)

                end
            end

            for i,v in pairs(G.jokers.cards) do
                if (not v.edition)then
                    v:set_edition({ unik_corrupted = true }, true,nil, true)
                end
            end
            G.GAME.blind.triggered = true
            G.GAME.blind:wiggle()
		end
	end,
    cry_before_play = function(self)
        for i,v in pairs(G.hand.cards) do
            if (not v.edition)then
                v:set_edition({ unik_corrupted = true }, true,nil, true)

            end
        end

        for i,v in pairs(G.jokers.cards) do
            if (not v.edition)then
                v:set_edition({ unik_corrupted = true }, true,nil, true)
            end
        end
        G.GAME.blind.triggered = true
        G.GAME.blind:wiggle()
	end,
}