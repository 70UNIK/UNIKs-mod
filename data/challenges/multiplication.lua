--The inverse of Chipzel, this time Chips is set to 1!
SMODS.Challenge{
    key = "unik_mult_only",
	rules = {
		custom = {
			{ id = "unik_chips_set_to_one" },
            { id = "unik_chips_ban" }, --just to laconically explain the huge banlist
            { id = "unik_chips_ban2" }, --just to laconically explain the huge banlist
		},
		modifiers = {},
	},
    jokers = {

	},
	deck = {
		type = "Challenge Deck",
	},
    restrictions = {
        --Ban all solely +chips, xChips and ^chips jokers; they would be worthless against this
        --Also ban all jokers that generate Jolly Jokers, jolly jokers would be worthless
        banned_cards = {
            --My cards

            -- --Default consumables
            -- { id = "c_justice" },
            -- { id = "c_chariot" },
            -- { id = "c_empress" },
            -- { id = "v_observatory" },
            -- { id = "c_cry_seraph" },
        },
        banned_tags = {
            --Disincourage foil and mosaic
            {id = 'tag_foil'},
            --Cryptid 
            {id = 'tag_cry_mosaic'},
        },
        --The trophy would make this unplayable, hence its banned
        banned_other = {
            {id = 'bl_cry_trophy', type = 'blind'},
            
        },
    },

}
--Multiplication's effect
