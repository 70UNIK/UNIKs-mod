--The inverse of Chipzel, all chips triggers affect mult, chips = 1.
SMODS.Challenge{
    key = "unik_mult_only",
	rules = {
		custom = {
			{ id = "unik_chips_set_to_one" },
		},
		modifiers = {},
	},
    jokers = {
        { id = "j_popcorn", stickers = {"banana" }, edition = "negative" }, 
        { id = "j_cavendish" },    
	},
	deck = {
		type = "Challenge Deck",
	},
    restrictions = {
        --Ban all solely +chips, xChips and ^chips jokers; they would be worthless against this
        banned_cards = {
            --My cards
          
        },
        banned_tags = {

        },
        --The trophy would make this unplayable, hence its banned
        banned_other = {
            {id = 'bl_cry_trophy', type = 'blind'},
            {id = 'bl_unik_salmon_steps', type = 'blind'},
        },
    },

}

--Multiplication's effect
local multiChips = mod_chips
function mod_chips(_chips)
    if G.GAME.modifiers.chips_dollar_cap then
      _chips = math.min(_chips, math.max(G.GAME.dollars, 0))
    end
    if G.GAME.modifiers.unik_chips_set_to_one then
        mod_mult(_chips)
        _chips = math.min(_chips, 1)
    end
    return multiChips(_chips)
  end