--all played cards become decaying
SMODS.Challenge{
    key = "unik_the_rot",
	rules = {
		custom = {
			{ id = "unik_decay_on_play" },
		},
		modifiers = {},
	},
    jokers = {
	},
    consumeables = {
        {id = 'c_cryptid'},
        {id = 'c_cryptid'},
    },
	deck = {
		type = "Challenge Deck",
	},
    apply = function(self)
        
    end,

}
