SMODS.Atlas {
	key = "unik_niko",
	path = "unik_niko.png",
	px = 71,
	py = 95
}

local niko_quotes = {
	normal = {
		'k_unik_niko_normal1',
        'k_unik_niko_normal2',
        'k_unik_niko_normal3',
	},
}

SMODS.Joker {
	key = 'unik_niko',
    atlas = 'unik_niko',
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
        local RNDM = math.random(#niko_quotes[quoteset])
        local extra = ""
        if RNDM == 3 then
            extra = localize(
					G.GAME.current_round.unik_niko_card and G.GAME.current_round.unik_niko_card.suit or "Hearts",
					"suits_plural"
				) .. "..."
        end
		return {
		vars = {localize(
					G.GAME.current_round.unik_niko_card and G.GAME.current_round.unik_niko_card.suit or "Hearts",
					"suits_plural"
				),center.ability.extra.x_mult
	,localize(niko_quotes[quoteset][RNDM] .. "" ) .. extra,
    colours = {
					G.C.SUITS[G.GAME.current_round.unik_niko_card and G.GAME.current_round.unik_niko_card.suit or "Hearts"],
				},
	},
    
    }
	end,
	pronouns = "they_them",
    calculate = function(self, card, context)	
        if context.individual and context.cardarea == G.play then
            if not G.GAME.current_round.unik_niko_card then
                G.GAME.current_round.unik_niko_card = { suit = "Hearts" }
            end
            if context.other_card:is_suit(G.GAME.current_round.unik_niko_card.suit) then
                return {
                    x_mult = card.ability.extra.x_mult,
                    card = card
                }
            end
        end
    end,
}

--Beware of using wild cards! Niko treats wild cards as "has hearts, diamonds and fluerons + stars", so will randomly select if multiple suits are present!
function reset_niko_card()
    local currSuit = G.GAME.current_round.unik_niko_card or { suit = "Hearts" }
    G.GAME.current_round.unik_niko_card = { suit = "Hearts" }
    local avaliableSuits = {}
    
	for k, v in ipairs(G.playing_cards) do
		if UNIK.is_suit_type(v,'light') then
            for i = 1, #UNIK.light_suits do
            if v:is_suit(UNIK.light_suits[i]) and currSuit.suit ~= UNIK.light_suits[i] then
                local exists = false
                for z = 1, #avaliableSuits do
                    if UNIK.light_suits[i] == avaliableSuits[z] then
                        exists = true
                    end
                end
                if not exists then
                    avaliableSuits[#avaliableSuits + 1] = UNIK.light_suits[i]
                end
                
            end
        end
			-- valid_castle_cards[#valid_castle_cards + 1] = v
		end
	end
    --print(avaliableSuits)
    if avaliableSuits[1] then
        local suit = pseudorandom_element(avaliableSuits, pseudoseed("unik_niko2222" .. G.GAME.round_resets.ante))
        G.GAME.current_round.unik_niko_card.suit = suit
    else
        G.GAME.current_round.unik_niko_card.suit = currSuit.suit
    end
end
local rcc = reset_castle_card
function reset_castle_card()
	rcc()
    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        func = function()
            reset_niko_card()
            return true
        end
    }))
    
end