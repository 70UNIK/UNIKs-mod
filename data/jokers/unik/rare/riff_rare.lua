

--create an rare joker when selecting big or boss blind
SMODS.Joker {
    key = 'unik_riff_rare',
    atlas = 'unik_rare',
    rarity = 3,
	pos = { x = 2, y = 0 },
    cost = 9,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    demicoloncompat = true,
    immutable = true,
    pools = {["riff_raff"] = true },
    calculate = function(self, card, context)
        if context.forcetrigger and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local create = 1
			G.GAME.joker_buffer = G.GAME.joker_buffer + create
            
            G.E_MANAGER:add_event(Event({
				func = function()
                    if create > 0 then
                        card:juice_up(0.3, 0.4)
                        local card2 = create_card("Joker", G.jokers, nil, 0.99, nil, nil, nil, "unik_riff_rare")
                        card2:add_to_deck()
                        G.jokers:emplace(card2)
                        card2:start_materialize()
                        G.GAME.joker_buffer = 0
                    end
					
					return true
				end
			}))
			return{
				message = localize("k_plus_joker"), 
                colour = G.C.MULT,
			}
        end
        if context.setting_blind and context.blind ~= G.P_BLINDS.bl_small and  #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local create = 1
			G.GAME.joker_buffer = G.GAME.joker_buffer + create
            
            G.E_MANAGER:add_event(Event({
				func = function()
                    if create > 0 then
                        card:juice_up(0.3, 0.4)
                        local card2 = create_card("Joker", G.jokers, nil, 0.99, nil, nil, nil, "unik_riff_rare")
                        card2:add_to_deck()
                        G.jokers:emplace(card2)
                        card2:start_materialize()
                        G.GAME.joker_buffer = 0
                    end
					
					return true
				end
			}))
			return{
				message = localize("k_plus_joker"), 
                colour = G.C.MULT,
			}
        end
    end,
}