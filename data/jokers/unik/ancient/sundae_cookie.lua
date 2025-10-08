--Beware of using wild cards! Like Niko, Sundae Cookie treats wild cards as "has spades, clubs, halberds and crowns", so will randomly select if multiple suits are present!
SMODS.Atlas {
	key = "unik_sundae_cookie",
	path = "unik_sundae_cookie.png",
	px = 71,
	py = 95
}

local sundae_quotes = {
	normal = {
		'k_unik_sundae_normal1',
        'k_unik_sundae_normal2',
        'k_unik_sundae_normal3',
        'k_unik_sundae_normal4',
	},
}

SMODS.Joker {
	key = 'unik_sundae_cookie',
    atlas = 'unik_sundae_cookie',
    rarity = "unik_ancient",
	
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
    cost = 50,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
	demicoloncompat = true,
    config = { extra = {x_mult = 2.5}},
	loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = UNIK.suit_tooltip('light')
		local quoteset = 'normal'
        local RNDM = math.random(#sundae_quotes[quoteset])
        local extra = ""
        if RNDM == 4 then
            extra = localize(
					G.GAME.current_round.unik_sundae_card and G.GAME.current_round.unik_sundae_card.suit or "Spades",
					"suits_plural"
				) .. "!"
        end
		return {
		vars = {localize(
					G.GAME.current_round.unik_sundae_card and G.GAME.current_round.unik_sundae_card.suit or "Spades",
					"suits_plural"
				),center.ability.extra.x_mult
	,localize(sundae_quotes[quoteset][RNDM] .. "" ) .. extra,
    colours = {
					G.C.SUITS[G.GAME.current_round.unik_sundae_card and G.GAME.current_round.unik_sundae_card.suit or "Spades"],
				},
	},
    
    }
	end,
	pronouns = "she_her",
    calculate = function(self, card, context)	
        if context.individual and context.cardarea == G.play then
            if not G.GAME.current_round.unik_sundae_card then
                G.GAME.current_round.unik_sundae_card = { suit = "Spades" }
            end
            if context.other_card:is_suit(G.GAME.current_round.unik_sundae_card.suit) then
                return {
                    x_mult = card.ability.extra.x_mult,
                    card = card
                }
            end
        end
    end,
}

function reset_sundae_card()
    local currSuit = G.GAME.current_round.unik_sundae_card or { suit = "Spades" }
    G.GAME.current_round.unik_sundae_card = { suit = "Spades" }
    local avaliableSuits = {}
    
	for k, v in ipairs(G.playing_cards) do
		if UNIK.is_suit_type(v,'light') then
            for i = 1, #UNIK.dark_suits do
            if v:is_suit(UNIK.dark_suits[i]) and currSuit.suit ~= UNIK.dark_suits[i] then
                local exists = false
                for z = 1, #avaliableSuits do
                    if UNIK.dark_suits[i] == avaliableSuits[z] then
                        exists = true
                    end
                end
                if not exists then
                    avaliableSuits[#avaliableSuits + 1] = UNIK.dark_suits[i]
                end
                
            end
        end
			-- valid_castle_cards[#valid_castle_cards + 1] = v
		end
	end
    --print(avaliableSuits)
    if avaliableSuits[1] then
        local suit = pseudorandom_element(avaliableSuits, pseudoseed("unik_sundae_cookie_22222" .. G.GAME.round_resets.ante))
        G.GAME.current_round.unik_sundae_card.suit = suit
    else
        G.GAME.current_round.unik_sundae_card.suit = currSuit.suit
    end
end
local rcc = reset_castle_card
function reset_castle_card()
	rcc()
    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        func = function()
            reset_sundae_card()
            return true
        end
    }))
    
end