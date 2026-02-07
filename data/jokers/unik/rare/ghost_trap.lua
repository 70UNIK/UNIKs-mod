--If a cursed Joker is spawned, destroy it. It runs constantly if there are at least 1 cursed joker(s)
--For each destroyed cursed Joker, gain 1.5x Mult.
--If exceeding 8 cursed jokers, it will self destruct and RELEASE ALL CURSED JOKERS contained inside.
--Selling or its destruction will also release all cursed jokers.
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_ghost_trap',
    atlas = 'unik_rare',
    rarity = 3,
	pos = { x = 0, y = 0 },
    cost = 8,
	blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = true,
	experimental = true,
	demicoloncompat = true,
    config = { extra = {x_mult = 1.0, x_mult_mod = 1.5,limit = 10,destroyed = false} },
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.x_mult,center.ability.extra.x_mult_mod,center.ability.extra.limit} }
	end,
	add_to_deck = function(self, card, from_debuff)
		for i,v in pairs(G.jokers.cards) do
			if UNIK.detrimental_rarities[v.config.center.rarity] and not card.ability.extra.destroyed then
				v.ability.getting_captured = true
				selfDestruction(v,"k_unik_pentagram_purified",G.C.MULT)
				if card.ability.extra.limit > 0 then
					SMODS.scale_card(card, {
						ref_table =card.ability.extra,
						ref_value = "x_mult",
						scalar_value = "x_mult_mod",
						message_key = "a_xmult",
						message_colour = G.C.MULT,
					})
					card.ability.extra.limit = card.ability.extra.limit - 1
				elseif not card.ability.extra.destroyed  then
					card.ability.extra.destroyed = true
					selfDestruction(card,'k_unik_ghost_trap_explode',G.C.MULT)
				end
			end
		end
        
	end,
	-- on self destruction, release all cursed jokers

    calculate = function(self, card, context)
		if (context.joker_main and (to_big(card.ability.extra.x_mult) > to_big(1))) then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
				Xmult_mod = card.ability.extra.x_mult,
			}
		end
		if context.forcetrigger and not context.blueprint and not context.retrigger_joker and not context.repetition then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
				Xmult_mod = card.ability.extra.x_mult,
			}
		end
		if context.unik_add_to_deck and context.added then
			if (UNIK.detrimental_rarities[context.added.config.center.rarity]) 
			and not context.added.ability.getting_captured then
				context.added.ability.getting_captured = true
				selfDestruction(context.added,"k_unik_pentagram_purified",G.C.MULT)
				if card.ability.extra.limit > 0 then
					SMODS.scale_card(card, {
						ref_table =card.ability.extra,
						ref_value = "x_mult",
						scalar_value = "x_mult_mod",
						message_key = "a_xmult",
						message_colour = G.C.MULT,
					})
					card.ability.extra.limit = card.ability.extra.limit - 1
				elseif not card.ability.extra.destroyed  then
					card.ability.extra.destroyed = true
					selfDestruction(card,'k_unik_ghost_trap_explode',G.C.MULT)
				end
			end
			
		end
    end,
}

--ghost trap: if purchased/obtained, then ignore detrimentals/curseds
local alerter = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
	local totalJokers = #G.jokers.cards
	for i,v in pairs(G.jokers.cards) do
		if v.config.center.rarity == 'unik_detrimental' or v.config.center.rarity == 'cry_cursed'then
			totalJokers = totalJokers - 1
		end
	end
	if (card.ability.set == 'Joker' and card.config.center.key == 'j_unik_ghost_trap' and totalJokers < G.jokers.config.card_limit + card.ability.card_limit - card.ability.extra_slots_used) then
		return true
	end
	local res = alerter(card)
	return res
end