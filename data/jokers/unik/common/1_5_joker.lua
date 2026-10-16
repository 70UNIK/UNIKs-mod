--10 mult for playing 5 cards (not all will have to score), +4 mult for any additional cards above 5
SMODS.Atlas {
	key = "unik_one_and_a_half_joker",
	path = "unik_one_and_a_half_joker.png",
	px = 71,
	py = 144
}
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_1_5_joker',
    atlas = 'unik_one_and_a_half_joker',
    rarity = 1,
	pos = { x = 0, y = 0 },
	-- Modest
    config = { extra = { mult = 10, mult_mod = 8}, immutable = {hand_size = 5}, },
    cost = 4,
	attributes = { 'mult' },
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	demicoloncompat = true,
	display_size = { w = 71, h = 144 },
    loc_vars = function(self, info_queue, center)
		local key = 'j_unik_1_5_joker'
		--only display the additional ones if you managed to play a hand above 5 cards (cryptid, entropy, linked groups)
		if (G.hand and G.hand.config and G.hand.config.highlighted_limit and G.hand.config.highlighted_limit > 5) or G.GAME and G.GAME.unik_scored_over_5 then
			key = 'j_unik_1_5_joker_exp'
		end
		return { key =key, vars = {center.ability.extra.mult,center.ability.extra.mult_mod,center.ability.immutable.hand_size} }
	end,
    calculate = function(self, card, context)
		if context.joker_main then
			if #context.full_hand >= card.ability.immutable.hand_size then
                return {
                    message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult + card.ability.extra.mult_mod * (#context.full_hand - card.ability.immutable.hand_size)}},
                    mult_mod = card.ability.extra.mult
                }
			end
		end
		if context.forcetrigger then
			local handsize = 5
			if context.full_hand then
				handsize = math.max(#context.full_hand,5)
			end
			return {
				message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult + card.ability.extra.mult_mod * (handsize - card.ability.immutable.hand_size)}},
				mult_mod = card.ability.extra.mult
			}
		end
	end,
	check_for_unlock = function(self, args)
        if args.type == 'unik_blind_setter' and args.blind and args.blind.key == 'bl_psychic' and G.jokers then
			for i,v in pairs(G.jokers.cards) do
				if v.config.center.key == 'j_half' then
					return true
				end
			end
        end
    end,
    locked_loc_vars = function(self, info_queue, card)
        local other_name = localize('k_unknown')
        if G.P_CENTERS['j_half'].unlocked then
            info_queue[#info_queue + 1] = G.P_CENTERS.j_half
            
            other_name = localize { type = 'name_text', set = 'Joker', key = 'j_half' }
        end
        return {
        vars = {
            other_name
        }
        }
    end,
    unlocked = false,
  	discovered = false,
}

local blinder = Blind.set_blind
function Blind:set_blind(blind, reset, silent)
	local ret = blinder(self,blind,reset,silent)
	check_for_unlock({ type = 'unik_blind_setter',blind = blind })
	return ret
end