SMODS.Atlas {
	key = "unik_poppy",
	path = "unik_poppy.png",
	px = 71,
	py = 95
}
local poppy_quotes = {
	normal = {
		'k_poppy_normal1',
		'k_poppy_normal2',
		'k_poppy_normal3',
		'k_poppy_normal4',
        'k_poppy_normal5',
	},
    trigger = {
        'k_poppy_trigger1',
        'k_poppy_trigger2',
        'k_poppy_trigger3',
        'k_poppy_trigger4',
    }
}
SMODS.Joker {
    key = 'unik_poppy',
    atlas = 'unik_poppy',
	pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    rarity = 3,
    cost = 9,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    immutable = true,
    config = { extra = {retriggers = 0},immutable = { max_retriggers = 100,discarders = 0 }},
    loc_vars = function(self, info_queue, center)
        local quoteset = 'normal'
        return { 
            vars = {math.min(center.ability.extra.retriggers,center.ability.immutable.max_retriggers),localize(poppy_quotes[quoteset][math.random(#poppy_quotes[quoteset])] .. "")} 
            ,
        }
	end,
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.triggered = false
    end,
    calculate = function(self, card, context)
        
        if context.repetition and context.cardarea == G.play then
            if card.ability.extra.retriggers > 0 then
                if context.other_card == context.scoring_hand[#context.scoring_hand] then
                    
                    if not context.blueprint_card then
                        local quoteset = 'trigger'
                         return {
                            message = localize(pseudorandom_element(poppy_quotes[quoteset], pseudoseed("poppy_quotes_trigger")) .. ""),
                            repetitions = to_number(
                                card.ability.extra.retriggers
                            ),
                            
                            colour = HEX("ff8bcb"),
                            card = card,
                        }
                    else
                        return {
                            message = localize("k_again_ex"),
                            repetitions = to_number(
                                card.ability.extra.retriggers
                            ),
                            colour = HEX("ff8bcb"),
                            card = card,
                        }
                    end
                   
                end
            end
		end
        if context.hand_mod and context.hand_mod_val < 0 and not context.blueprint and not context.repetition and not context.retrigger_joker then
            card.ability.extra.retriggers = card.ability.extra.retriggers + math.abs(context.hand_mod_val)
            return {
                message = localize({
                    type = "variable",
                    key = "a_unik_celestial_triggers",
                    vars = {
                        math.min(card.ability.extra.retriggers,card.ability.immutable.max_retriggers)
                    },
                }),
                colour = HEX("ff8bcb"),
                card = card,
            }
        end
        if context.discard_mod and context.discard_mod_val < 0 and not context.blueprint and not context.repetition and not context.retrigger_joker  then
            card.ability.immutable.discarders = card.ability.immutable.discarders + math.abs(context.discard_mod_val)

            if card.ability.immutable.discarders >= 2 then
                while card.ability.immutable.discarders >= 2 do
                    card.ability.extra.retriggers = card.ability.extra.retriggers + 1
                    card.ability.immutable.discarders = card.ability.immutable.discarders - 2
                    if  card.ability.immutable.discarders < 2 then
                        break
                    end
                end
                
                return {
                    message = localize({
                        type = "variable",
                        key = "a_unik_celestial_triggers",
                        vars = {
                            card.ability.extra.retriggers,
                        },
                    }),
                    colour = HEX("ff8bcb"),
                    card = card,
                }
            end
            
        end
        if context.end_of_round and context.cardarea == G.jokers and not context.blueprint and not context.repetition and not context.retrigger_joker then
            card.ability.extra.retriggers = 0
            card.ability.immutable.discarders = 0
            return {
                message = localize('k_reset'),
                colour = HEX("ff8bcb"),
                card = card,
            }
        end
    end,
}
local handyHook = ease_hands_played
function ease_hands_played(mod, instant)
    local initial_hands = G.GAME.current_round.hands_left
    local mod2 = math.max(-G.GAME.current_round.hands_left, mod)
    handyHook(mod,instant)
    
    if G.GAME.blind and G.GAME.blind.in_blind then
        SMODS.calculate_context({ hand_mod = true, hand_mod_val = mod2 })
    end
    
end

local tossyHook = ease_discard
function ease_discard(mod, instant, silent)
    local initial_discards = G.GAME.current_round.discards_left
    local mod2 = math.max(-G.GAME.current_round.discards_left, mod)
    tossyHook(mod,instant,silent)
    
    if G.GAME.blind and G.GAME.blind.in_blind then
        SMODS.calculate_context({ discard_mod = true, discard_mod_val = mod2 })
    end
end 

---initial = 3 hands
---final = -9999 hands
---actually should be -3 hand change, not -10002.
--- -10002 = -100002 + (9999)