SMODS.Challenge{
    key = "unik_common_muck",
	rules = {
		custom = {
			{ id = "unik_common_only" },
		},
		modifiers = {},
	},
    jokers = {
        { id = "j_unik_riif_roof"},
	},
	deck = {
		type = "Challenge Deck",
	},
    restrictions = {
        --Ban all jokers except commons (Riif roof is the only uncommon)
        banned_cards = {},
        banned_tags = {
            --Ban empowered and gamblers tag, as well as rare, uncommon and epic tags
            {id = 'tag_cry_gambler'},
            {id = 'tag_cry_empowered'},
            {id = 'tag_rare'},
            {id = 'tag_uncommon'},
            {id = 'tag_cry_epic'},
            {id = 'tag_cry_bettertop_up'},
        },
        --The box is banned
        banned_other = {
            {id = 'bl_cry_box', type = 'blind'},
            {id = 'bl_cry_striker', type = 'blind'},
            {id = 'bl_cry_pin', type = 'blind'},
        },
    },

}

-- Chipzel's effect
local chipzel_mod_mult = mod_mult
function mod_mult(_mult)
	hand_chips = hand_chips or 0
    --Trophy effect first
	if G.GAME.trophymod then
		_mult = math.min(_mult, math.max(hand_chips, 0))
	end
    --Then chipzel's effect
    if G.GAME.modifiers.unik_mult_set_to_one then
        _mult = math.min(_mult, 1)
    end
	return chipzel_mod_mult(_mult)
end
