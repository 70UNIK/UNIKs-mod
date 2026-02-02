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
        local suits = getDominantSuit('light')
        local suit = G.GAME.current_round.unik_niko_card and G.GAME.current_round.unik_niko_card.suit or "Hearts"
        if suits and #suits == 1 then
            suit = suits[1]
        end
        if RNDM == 3 then
            extra = localize(
					suit or "Hearts",
					"suits_plural"
				) .. "..."
        end
		return {
		vars = {localize(suit or "Hearts","suits_plural"),center.ability.extra.x_mult,localize(niko_quotes[quoteset][RNDM] .. "" ) .. extra,colours = {
					G.C.SUITS[suit or "Hearts"],
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
            local suits = getDominantSuit('light')
            if suits and #suits == 1 then
                if context.other_card:is_suit(suits[1]) then
                    return {
                        x_mult = card.ability.extra.x_mult,
                        card = card
                    }
                end
            else
                if context.other_card:is_suit(G.GAME.current_round.unik_niko_card.suit) then
                    return {
                        x_mult = card.ability.extra.x_mult,
                        card = card
                    }
                end
            end
        end
        if context.after and context.cardarea == G.jokers and not context.repetition and not context.retrigger_joker then
            local firstSuit = nil
            for i,v in pairs(context.scoring_hand) do
                if UNIK.is_suit_type(v,'light') then
                    for i = 1, #UNIK.light_suits do
                    if UNIK.light_suits[i] == v.base.suit then
                        firstSuit = UNIK.light_suits[i]
                        break;
                    end
                end
                    break;
                end
            end
            
            if firstSuit then
                local validCards = {}
            for i,v in pairs(context.scoring_hand) do
                if v.base.suit ~= firstSuit then
                    validCards[#validCards+1] = v
                end
            end

            for i=1, #validCards do
                local percent = 1.15 - (i-0.999)/(#validCards-0.998)*0.3
                G.E_MANAGER:add_event(Event({
                    delay = 0.15,
                    trigger= 'after',
                    func = function()
                        validCards[i]:flip();play_sound('card1', percent);validCards[i]:juice_up(0.3, 0.3);
                        return true
                    end
                }))
            end
            for i=1, #validCards do
                G.E_MANAGER:add_event(Event({
                        delay = 0.1,
                        trigger= 'after',
                        func = function()
                            assert(SMODS.change_base(validCards[i], firstSuit))
                            return true
                        end
                }))
            end
            for i=1, #validCards do
                local percent = 0.85 + ( i - 0.999 ) / ( #validCards - 0.998 ) * 0.3
                G.E_MANAGER:add_event(Event({
                    delay = 0.15,
                    trigger= 'after',
                    func = function()
                        validCards[i]:flip(); play_sound('tarot2', percent, 0.6); validCards[i]:juice_up(0.3, 0.3);
                        return true
                    end
                }))
            end
            end
            
        end
    end,
}

--Beware of using wild cards! Niko treats wild cards as "has hearts, diamonds and fluerons + stars", so will randomly select if multiple suits are present!
function reset_niko_card()
    G.GAME.current_round.unik_niko_card = { suit = "Hearts" }
    local suits = getDominantSuit('light')
    if suits then
        local suit = pseudorandom_element(suits, pseudoseed("unik_niko_22222" .. G.GAME.round_resets.ante))
        G.GAME.current_round.unik_niko_card.suit = suit
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