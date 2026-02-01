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
        info_queue[#info_queue + 1] = UNIK.suit_tooltip('dark')
		local quoteset = 'normal'
        local RNDM = math.random(#sundae_quotes[quoteset])
        local extra = ""
        local suits = getDominantSuit(type)
        local suit = G.GAME.current_round.unik_sundae_card and G.GAME.current_round.unik_sundae_card.suit or "Spades"
        if suits and #suits == 1 then
            suit = suits[1]
        end
        if RNDM == 4 then
            extra = localize(suit or "Spades","suits_plural") .. "!"
        end
		return {
		vars = {localize( suit or "Spades", "suits_plural"),center.ability.extra.x_mult,localize(sundae_quotes[quoteset][RNDM] .. "" ) .. extra, colours = {G.C.SUITS[suit],},
	},
    
    }
	end,
	pronouns = "she_her",
    calculate = function(self, card, context)	
        if context.individual and context.cardarea == G.play then
            if not G.GAME.current_round.unik_sundae_card then
                G.GAME.current_round.unik_sundae_card = { suit = "Spades" }
            end
            local suits = getDominantSuit('dark')
            if suits and #suits == 1 then
                if context.other_card:is_suit(suits[1]) then
                    return {
                        x_mult = card.ability.extra.x_mult,
                        card = card
                    }
                end
            else
                if context.other_card:is_suit(G.GAME.current_round.unik_sundae_card.suit) then
                    return {
                        x_mult = card.ability.extra.x_mult,
                        card = card
                    }
                end
            end
        end
        if context.after and context.cardarea == G.jokers and not context.repetition and not context.retrigger_joker then
            local firstDark = nil
            local firstSuit = nil
            for i,v in pairs(context.scoring_hand) do
                if UNIK.is_suit_type(v,'dark') then
                    firstDark = v
                    break;
                end
            end
            if firstDark then
                for i = 1, UNIK.dark_suits do
                    if UNIK.dark_suits[i] == firstDark.base.suit then
                        firstSuit = UNIK.dark_suits[i]
                        break;
                    end
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
                            assert(SMODS.change_base(validCards[i], firstDark))
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
--returns a table containing suits
function getDominantSuit(type)
    local suitTable = {}
    local highestCount = 0
    local highestSuits = {}
    if type == 'dark' then
        
    elseif type == 'light' then
    else
        print("INVALID SUIT TYPE DETECTED: Suit must be 'light' or 'dark'")
        return nil
    end
    for k, v in ipairs(G.playing_cards) do
        if UNIK.is_suit_type(v,type) then
            for i = 1, #UNIK[type..'_suits'] do
                suitTable.UNIK[type..'_suits'][i] = suitTable.UNIK[type..'_suits'][i] or 0
                if v:is_suit(UNIK.dark_suits[i]) then
                    suitTable.UNIK[type..'_suits'][i] = suitTable.UNIK[type..'_suits'][i] + 1
                    
                end
            end
        end
    end
    for i,v in pairs(suitTable) do
        --designates highest suit
        if v > highestCount then
            highestCount = v
            highestSuits = {i}
        elseif v == highestCount then
            highestSuits[#highestSuits+1] = i
        end
    end
    print(highestSuits)
    return highestSuits
end

function reset_sundae_card()
    G.GAME.current_round.unik_sundae_card = { suit = "Spades" }
    local suits = getDominantSuit('dark')
    if suits then
        local suit = pseudorandom_element(suits, pseudoseed("unik_sundae_cookie_22222" .. G.GAME.round_resets.ante))
        G.GAME.current_round.unik_sundae_card.suit = suit
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