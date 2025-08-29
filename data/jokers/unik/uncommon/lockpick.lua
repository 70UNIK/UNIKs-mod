--Always negative
--You can sell eternal jokers.
--Self destructs after selling an eternal joker
SMODS.Joker {
    key = 'unik_lockpick',
    atlas = 'unik_uncommon',
    rarity = 2,
	pos = { x = 4, y = 1 },
    cost = 5,
    blueprint_compat = false,
    perishable_compat = true,
	eternal_compat = false,
    loc_vars = function(self, info_queue, center)
		return {
			key = Cryptid.gameset_loc(self, {modest = "modest" }), 
		}
	end,
    calculate = function(self, card, context)
        if
			context.selling_card and not context.blueprint
		then
			if context.card.ability.eternal then
                context.card.sell_cost = -context.card.sell_cost
                 if not G.GAME.banned_keys then
                    G.GAME.banned_keys = {}
                end
                if not G.GAME.banned_keys then
                    G.GAME.cry_banished_keys = {}
                end
                G.GAME.cry_banished_keys[context.card.config.center.key] = true
            end
		end
    end,
    in_pool = function(self)
        for i,v in pairs(G.jokers.cards) do 
            if v.ability.eternal then
                return true
            end
        end
		if G.GAME.modifiers.enable_eternals_in_shop then
			return true
		end
		return false
	end,
}