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
        local retriggers = 0
        retriggers = retriggers + (G.GAME.unik_hands_lost_in_round or 0)
        retriggers = retriggers + math.floor((G.GAME.unik_discards_lost_in_round or 0)/2)
        --explaining her mechanics
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_hands_lost" }
        return { 
            vars = {math.min(retriggers,center.ability.immutable.max_retriggers),localize(poppy_quotes[quoteset][math.random(#poppy_quotes[quoteset])] .. "")} 
            ,
        }
	end,
    pronouns = "she_her",
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.triggered = false
    end,
    pools = {["character"] = true },
    calculate = function(self, card, context)
        
        if context.repetition and context.cardarea == G.play then
            local retriggers = 0
            retriggers = retriggers + (G.GAME.unik_hands_lost_in_round or 0)
            retriggers = retriggers + math.floor((G.GAME.unik_discards_lost_in_round or 0)/2)
            if retriggers > 0 then
                if context.other_card == context.scoring_hand[#context.scoring_hand] then
                    
                    if not context.blueprint_card then
                        local quoteset = 'trigger'
                         return {
                            message = localize(pseudorandom_element(poppy_quotes[quoteset], pseudoseed("poppy_quotes_trigger")) .. ""),
                            repetitions = to_number(
                                math.min(retriggers,card.ability.immutable.max_retriggers)
                            ),
                            
                            colour = HEX("ff8bcb"),
                            card = card,
                        }
                    else
                        return {
                            message = localize("k_again_ex"),
                            repetitions = to_number(
                                math.min(retriggers,card.ability.immutable.max_retriggers)
                            ),
                            colour = HEX("ff8bcb"),
                            card = card,
                        }
                    end
                   
                end
            end
		end
        if context.hand_mod and context.hand_mod_val < 0 and not context.blueprint and not context.repetition and not context.retrigger_joker then
            -- card.ability.extra.retriggers = card.ability.extra.retriggers + math.abs(context.hand_mod_val)
             local retriggers = 0
            retriggers = retriggers + (G.GAME.unik_hands_lost_in_round or 0)
            retriggers = retriggers + math.floor((G.GAME.unik_discards_lost_in_round or 0)/2)
            return {
                message = localize({
                    type = "variable",
                    key = "a_unik_celestial_triggers",
                    vars = {
                        math.min(retriggers,card.ability.immutable.max_retriggers)
                    },
                }),
                colour = HEX("ff8bcb"),
                card = card,
            }
        end
        if context.discard_mod and context.discard_mod_val < 0 and not context.blueprint and not context.repetition and not context.retrigger_joker  then
             local retriggers = 0
            retriggers = retriggers + (G.GAME.unik_hands_lost_in_round or 0)
            retriggers = retriggers + math.floor((G.GAME.unik_discards_lost_in_round or 0)/2)
            -- card.ability.immutable.discarders = card.ability.immutable.discarders + math.abs(context.discard_mod_val)

            -- if card.ability.immutable.discarders >= 2 then
            --     while card.ability.immutable.discarders >= 2 do
            --         card.ability.extra.retriggers = card.ability.extra.retriggers + 1
            --         card.ability.immutable.discarders = card.ability.immutable.discarders - 2
            --         if  card.ability.immutable.discarders < 2 then
            --             break
            --         end
            --     end
                
                
            -- end
            return {
                message = localize({
                    type = "variable",
                    key = "a_unik_celestial_triggers",
                    vars = {
                        math.min(retriggers,card.ability.immutable.max_retriggers)
                    },
                }),
                colour = HEX("ff8bcb"),
                card = card,
            }
            
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

--TODO:
--Hook is disabled when:
--when selecting cards
--or if you permanently gain/lose hands
local handyHook = ease_hands_played
function ease_hands_played(mod, instant)

    if(G.CONTROLLER.locked) or 
        (G.GAME.STOP_USE and G.GAME.STOP_USE > 0) then
        local initial_hands = G.GAME.current_round.hands_left
        local mod2 = math.max(-G.GAME.current_round.hands_left, mod)
        
        
        if G.GAME.blind and G.GAME.blind.in_blind then
            if mod2 < 0 then
                G.GAME.unik_hands_lost_in_round = G.GAME.unik_hands_lost_in_round - mod2
            end
            SMODS.calculate_context({ hand_mod = true, hand_mod_val = mod2 })
            
        end
    end
    handyHook(mod,instant)
    
    
end

local tossyHook = ease_discard
function ease_discard(mod, instant, silent)
    if (G.CONTROLLER.locked) or 
        (G.GAME.STOP_USE and G.GAME.STOP_USE > 0) then
        local initial_discards = G.GAME.current_round.discards_left
        local mod2 = math.max(-G.GAME.current_round.discards_left, mod)
        
        
        if G.GAME.blind and G.GAME.blind.in_blind then
            if mod2 < 0 then
                G.GAME.unik_discards_lost_in_round = G.GAME.unik_discards_lost_in_round - mod2
            end
            SMODS.calculate_context({ discard_mod = true, discard_mod_val = mod2 })
            
            
        end
    end
    tossyHook(mod,instant,silent)
end 

local rcc = reset_castle_card
function reset_castle_card()
	rcc()
    G.GAME.unik_hands_lost_in_round = 0
    G.GAME.unik_discards_lost_in_round = 0
    
end