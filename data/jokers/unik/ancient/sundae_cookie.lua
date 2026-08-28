
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
    atlas = 'unik_character_jokers',
    rarity = "unik_ancient",
	
	pos = { x = 0, y = 4 },
	soul_pos = { x = 1, y = 4 },
    cost = 50,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
	demicoloncompat = true,
    config = { extra = {cards = 2,repetitions = 1}},
	loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = UNIK.suit_tooltip('dark')
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
		local quoteset = 'normal'
		return {
            vars = {center.ability.extra.cards,center.ability.extra.repetitions,localize(sundae_quotes[quoteset][math.random(#sundae_quotes[quoteset])] .. "")},
        }
	end,
	pronouns = "she_her",
    calculate = function(self, card, context)	
        if context.before and context.cardarea == G.jokers then
            if G.GAME.current_round.hands_left == 0 then
                local limit = card.ability.extra.cards
                local cards = {}
                 for i,v in pairs(context.scoring_hand) do
                            if UNIK.is_suit_type(v,'dark') and limit > 0 then
                                v.ability.perma_rescores = v.ability.perma_rescores or 0
                                v.ability.perma_rescores = v.ability.perma_rescores + 1
                                limit = limit - 1
                                cards[#cards+1] = v
                            end
                        end
                 G.E_MANAGER:add_event(Event({
                    delay = 0,
                    func = function()
                        for i,v in pairs(cards) do
                            v:juice_up()
                        end
                        return true
                    end
                }))
                return {
                    extra = {message = localize('k_upgrade_ex'), colour = HEX("991A79")},
                    colour = HEX("991A79"),
                }
            end
        end
        if context.after and not context.blueprint then
            local eval = function() return  G.GAME.current_round.hands_left == 1 end
            juice_card_until(card, eval, true)
        end
    end,
}