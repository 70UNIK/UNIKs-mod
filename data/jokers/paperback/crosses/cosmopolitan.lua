--the next 5 scored crosses will permanently gain +1 retrigger (only applies once per card)
SMODS.Joker {
	key = "unik_cosmopolitan",
	config = {
		extra = {
		suit = "unik_Crosses",
		amount = 1,
		remaining = 5,
		upgrade = "perma_repetitions",
		--blacklist = "cosmopolitan_blacklist"
		}
	},
	rarity = 3,
	pos = { x = 10, y = 3 }, --+10, +0
	atlas = "unik_normal_jokers",
	attributes = { 'perma_bonus','retrigger','suit','unik_crosses','food' },
	cost = 8,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = false,
	soul_pos = nil,
	pools = {
		Food = true
	},
  	add_to_deck = function(self, card, from_debuff)
		-- Changes a G.GAME variable, which is usually a global value that's specific to the current run.
		-- These are initialized in game.lua under the Game:init_game_object() function, and you can look through them to get an idea of the things you can change.
		--generate a seed for cosmopolitan/midori sour so only 1 joker can apply it per card, but
		if not from_debuff then
			local seed = math.random(1000000,9999999)
            local seed2 = math.random(1000000,9999999)
			card.ability.extra.blacklist = 'cosmopolitan_blacklist' ..G.GAME.round_resets.ante .. seed .. seed2
			print(card.ability.extra.blacklist)
		end
	end,
	paperback = {
		suit_drink = true
	},
	in_pool = function(self)
			return UNIK.suit_in_deck('unik_Crosses') 
		end,
	calculate = PB_UTIL.suit_drink_calculate,

	loc_vars = PB_UTIL.suit_drink_loc_vars,
	unlocked = false,
	discovered = false,
	check_for_unlock = function (self, args)
		if args.type == 'paperback_suit_flushes' then
			if G.GAME.paperback.played_flushes['unik_Crosses'] and G.GAME.paperback.played_flushes['unik_Crosses'] >= 5 then
				return true
			end
		end
	end,
    set_badges = function (self, card, badges)
		if card.config.center.discovered then
			SMODS.create_mod_badges({ mod = SMODS.find_mod("paperback")[1] }, badges)
		end
    end,
	locked_loc_vars = function (self, info_queue, card)
		return {vars = {5, localize(card.ability.extra.suit, 'suits_singular'),}}
	end,
}