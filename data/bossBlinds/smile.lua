SMODS.Blind{
    key = 'unik_smiley',
    config = {},
	boss = {
		min = 5,
	},
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 21},
    boss_colour= HEX("ffd61d"),
    dollars = 5,
    mult = 2,
    set_blind = function(self, reset, silent)
        G.GAME.unik_positive_draw = true
    end,
    --doesnt actually flip cards
    -- stay_flipped = function(self, area, card)
	-- 	if
    --         G.GAME.current_round.hands_played == 0
    --         and G.GAME.current_round.discards_used == 0
    --     then
    --         if card.edition and card.edition.key then
    --             card.ability.original_edition = card.edition.key
    --         end
    --         if not card.edition then
    --             card.ability.revert_positive_unik = true
    --         end
    --         card:set_edition({ unik_positive = true }, true,nil, true)
    --         G.GAME.blind.triggered = true
    --         G.GAME.blind:wiggle()
           
    --     end
	-- end,
    disable = function(self)
        for i,v in pairs(G.playing_cards) do
            if v.ability and v.ability.original_edition then
                v:set_edition(v.ability.original_edition, true,nil, true)
                v.ability.original_edition = nil
            end
            if v.ability and v.ability.revert_positive_unik then
                v:set_edition(nil, true,nil, true)
                v.revert_positive_unik = nil
            end
        end
        G.GAME.unik_positive_draw = nil
    end,
    defeat = function(self)
        for i,v in pairs(G.playing_cards) do
            if v.ability and v.ability.original_edition then
                v.ability.original_edition = nil
            end
            if v.ability and v.ability.revert_positive_unik then
                v.revert_positive_unik = nil
            end
        end   
        G.GAME.unik_positive_draw = nil
    end,
}