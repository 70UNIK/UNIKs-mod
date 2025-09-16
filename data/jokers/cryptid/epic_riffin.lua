--create an epic joker on selecting a boss blind (must have room)
SMODS.Joker {
    dependencies = {
		items = {
			"set_cry_epic",
		},
	},
    key = 'unik_epic_riffin',
    atlas = 'unik_epic',
    rarity = 'cry_epic',
	pos = { x = 1, y = 1 },
    cost = 12,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    demicoloncompat = true,
    immutable = true,
    pools = {["riff_raff"] = true },
        discovered = true,
    unlocked = true,
    set_badges = function (self, card, badges)
      SMODS.create_mod_badges({ mod = SMODS.find_mod("cry")[1] }, badges)
    end,
    calculate = function(self, card, context)
        if context.forcetrigger and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local create = 1
			G.GAME.joker_buffer = G.GAME.joker_buffer + create
            
            G.E_MANAGER:add_event(Event({
				func = function()
                    if create > 0 then
                        card:juice_up(0.3, 0.4)
                        --This will need to be updated when refactor branch is complete.
                        local card2 = create_card("Joker", G.jokers, nil, "cry_epic", nil, nil, nil, "unik_epic_riffin")
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
                colour = G.C.RARITY["cry_epic"],
			}
        end
        if context.setting_blind and context.blind.boss and  #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local create = 1
			G.GAME.joker_buffer = G.GAME.joker_buffer + create
            
            G.E_MANAGER:add_event(Event({
				func = function()
                    if create > 0 then
                        card:juice_up(0.3, 0.4)
                        --This will need to be updated when refactor branch is complete.
                        local card2 = create_card("Joker", G.jokers, nil, "cry_epic", nil, nil, nil, "unik_epic_riffin")
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
                colour = G.C.RARITY["cry_epic"],
			}
        end
    end,
}