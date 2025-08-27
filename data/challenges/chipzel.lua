--reworked chipzel challenge: all mult triggers affect chips, mult = 1.
SMODS.Challenge{
    key = "unik_chips_only",
	rules = {
		custom = {
			{ id = "unik_mult_set_to_one" },
		},
		modifiers = {},
	},
    jokers = {
        { id = "j_unik_jsab_chelsea", stickers = {"cry_absolute" }},
	},
	deck = {
		type = "Challenge Deck",
	},
    restrictions = {
        --Ban all solely +mult, xMult and ^Mult jokers; they would be worthless against this
        --Also ban all jokers that generate Jolly Jokers, jolly jokers would be worthless
        banned_cards = {
            --My cards
         
        },
        banned_tags = {
           
        },
        --The trophy would be an absolute joke, hence its disabled 
        banned_other = {
            {id = 'bl_cry_trophy', type = 'blind'},
            {id = 'bl_unik_salmon_steps', type = 'blind'},
        },
    },

}

-- -- Chipzel's effect
-- local chipzel_mod_mult = mod_mult
-- function mod_mult(_mult)
-- 	hand_chips = hand_chips or 0
--     --Trophy effect first
-- 	if G.GAME.trophymod then
-- 		_mult = math.min(_mult, math.max(hand_chips, 0))
-- 	end
--     --Then chipzel's effect
--     if G.GAME.modifiers.unik_mult_set_to_one then
--         mod_chips(_mult)
--         _mult = math.min(_mult, 1)
--     end
-- 	return chipzel_mod_mult(_mult)
-- end
