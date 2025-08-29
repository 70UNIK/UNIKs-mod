--on blind select, other dichrome cards gain +1 hand and discards
SMODS.Joker {
    key = 'unik_binary_asteroid',
    atlas = 'unik_common',
    rarity = 1,
	pos = { x = 2, y = 1 },
    cost = 2,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    demicoloncompat = true,
    immutable = true,
    config = { extra = { discards = 1,hands = 1},immutable = { max_hand_size_mod = 100 }, },
    loc_vars = function(self, info_queue, center)
		return { vars = {math.min(center.ability.extra.hands,center.ability.immutable.max_hand_size_mod),math.min(center.ability.extra.discards,center.ability.immutable.max_hand_size_mod)} }
	end,

    calculate = function(self, card, context)
        if context.forcetrigger then
            G.E_MANAGER:add_event(Event({
				func = function()
					 local res = PB_UTIL.get_lowest_hand_discard()
                        -- Pick hands over discards
                        local func = res.hands and ease_hands_played or ease_discard
                        local message = res.hands and 'a_hands' or 'paperback_a_discards'
                        func(card.ability.extra.hands, true)

                        SMODS.calculate_effect({
                            message = localize {
                            type = 'variable',
                            key = message .. (res.amt < 0 and '_minus' or ''),
                            vars = { card.ability.extra.hands }
                            },
                            colour = res.hands and G.C.CHIPS or G.C.MULT,
                            instant = true
                        }, card)
					return true
				end,
			}))
            return {
                
            }
        end
        if (context.setting_blind and not (context.blueprint_card or card).getting_sliced) then
            for i,v in pairs(G.jokers.cards) do
                if v.edition and v.edition.paperback_dichrome and v ~= card then
                    G.E_MANAGER:add_event(Event({
                    trigger= 'after',
                    delay = 0.1,
                    func = function()
                        local res = PB_UTIL.get_lowest_hand_discard()
                        -- Pick hands over discards
                        local func = res.hands and ease_hands_played or ease_discard
                        local message = res.hands and 'a_hands' or 'paperback_a_discards'

                        func(card.ability.extra.hands, true)

                        SMODS.calculate_effect({
                            message = localize {
                            type = 'variable',
                            key = message .. (res.amt < 0 and '_minus' or ''),
                            vars = { card.ability.extra.hands }
                            },
                            colour = res.hands and G.C.CHIPS or G.C.MULT,
                            instant = true
                        }, card)
                        return true
                    end,
                }))
                end
            end
            return {

            }
         end
    end,
    set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("paperback")[1] }, badges)
    end,
}