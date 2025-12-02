--same as rich get richer... but you start with an eternal UNIK, eternal Chelsea and an et
SMODS.Challenge{
    key = "unik_rich_get_richer_2",
	rules = {
        custom = {
            {id = 'chips_dollar_cap'},
            {id = 'mult_dollar_cap'},
        },
        modifiers = {
            {id = 'dollars', value = 100},
        }
	},
	jokers = {
        { id = "j_unik_jsab_chelsea", eternal = true},
        { id = "j_unik_unik", eternal = true},
    },
	deck = {
		type = "Challenge Deck",
       
	},
    vouchers = {
        {id = 'v_seed_money'},
        {id = 'v_money_tree'},
    },
    restrictions = {
        banned_cards = function(self)
            local bannedCards = {}
            bannedCards[#bannedCards+1] = {id = 'j_unik_yes_nothing'}
            bannedCards[#bannedCards+1] = {id = 'j_unik_lockpick'}
            bannedCards[#bannedCards+1] = {id = 'c_unik_expel'}

            return bannedCards
        end,  
    },

}

local multmod = mod_mult
function mod_mult(_mult)
    if G.GAME.modifiers.mult_dollar_cap then
        _mult = math.min(_mult, math.max(G.GAME.dollars, 0))
    end
    return multmod(_mult)
end