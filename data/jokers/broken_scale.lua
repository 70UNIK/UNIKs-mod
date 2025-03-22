--Broken Scale: Scaling Jokers 1/3 as fast
--Self destructs after e^2 rounds (>7 rounds)
SMODS.Joker {
    dependencies = {
		items = {
			"set_cry_cursed",
		},
	},
	key = 'unik_broken_scale',
    atlas = 'placeholders',
    rarity = "cry_cursed",
	pos = { x = 3, y = 1 },
    cost = 1,
    config = { extra = {rounds = 0,round_limit = 8} },
    loc_vars = function(self, info_queue, center)
        return { 
            key = Cryptid.gameset_loc(self, { modest = "modest"}),
            vars = { center.ability.extra.rounds,center.ability.extra.round_limit } }
    end,
    pools = { ["unik_boss_blind_joker"] = true},
	blueprint_compat = false,
    perishable_compat = false,
    immutable = true,
    --mainline: scale down to 1/3.
    --modest: scale down to 3/4
	cry_scale_mod = function(self, card, joker, orig_scale_scale, true_base, orig_scale_base, new_scale_base)
        if (Card.get_gameset(card) ~= "modest") then
            return true_base/3
        else
            return true_base*3/4
        end
		
	end,
    calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers and not context.repetition and not context.blueprint then
            card.ability.extra.rounds = card.ability.extra.rounds + 1
            if card.ability.extra.rounds > card.ability.extra.round_limit then
                selfDestruction(card,"k_unik_weapon_destroyed",G.C.BLACK)
            else
                return{
                    message = card.ability.extra.rounds .. "/" .. card.ability.extra.round_limit,
                    colour = G.C.BLACK,
                }
            end
        end
    end
} 