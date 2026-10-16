

local niko_quotes = {
	normal = {
		'k_unik_niko_normal1',
        'k_unik_niko_normal2',
        'k_unik_niko_normal3',
        'k_unik_niko_normal4',
	},
    trigger = {
        'k_unik_niko_trigger1',
        'k_unik_niko_trigger2',
        'k_unik_niko_trigger3',
    },
}

SMODS.Joker {
	key = 'unik_niko',
    atlas = 'unik_character_jokers',
    rarity = "unik_ancient",
	
	pos = { x = 0, y = 6 },
	soul_pos = { x = 1, y = 6 },
    cost = 50,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
	demicoloncompat = true,
    config = { extra = {cards = 2,repetitions = 1}},
    attributes = { 'retrigger', 'suit','modify_card','perma_bonus' },
	loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = UNIK.suit_tooltip('light')
		local quoteset = 'normal'
		return {
            vars = {center.ability.extra.cards,center.ability.extra.repetitions,localize(niko_quotes[quoteset][math.random(#niko_quotes[quoteset])] .. "")},
        }
	end,
	pronouns = "they_them",
    calculate = function(self, card, context)	
        if context.before and context.cardarea == G.jokers then
            if G.GAME.current_round.hands_played == 0 then
                local limit = card.ability.extra.cards
                local cards = {}
                for i,v in pairs(context.scoring_hand) do
                    if UNIK.is_suit_type(v,'light') and limit > 0 then
                        v.ability.perma_repetitions = v.ability.perma_repetitions or 0
                        v.ability.perma_repetitions = v.ability.perma_repetitions + 1
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
                local quoteset = 'trigger'
                if #cards > 0 then
                    if not context.blueprint_card then
                         return {
                            message = localize(niko_quotes[quoteset][math.random(#niko_quotes[quoteset])] .. ""),
                            colour = HEX("991A79"),
                        }
                    else
                         return {
                            message = localize("k_upgrade_ex"),
                            
                        }
                    end
                end
               
            end
        end
        if context.first_hand_drawn then
            if not context.blueprint then
                local eval = function() return G.GAME.current_round.hands_played == 0 end
                juice_card_until(card, eval, true)
            end
        end
    end,
        check_for_unlock = function(self, args)
        if args.type == 'win_custom' and G.jokers then
            local back = G.GAME.selected_back
            local back_config = back and back.effect.center
            for i,v in pairs(G.jokers.cards) do
                if v.config.center.key == 'j_ancient' and back_config.key == 'b_checkered' then
                    return true
                end
            end
        end
    end,
    locked_loc_vars = function(self, info_queue, card)
        local other_name = localize('k_unknown')
        local other_name2 = localize('k_unknown')
        if G.P_CENTERS['b_checkered'].unlocked then
            info_queue[#info_queue + 1] = G.P_CENTERS.b_checkered
            
            other_name = localize { type = 'name_text', set = 'Back', key = 'b_checkered' }
        end
        if G.P_CENTERS['j_ancient'].unlocked then
            info_queue[#info_queue + 1] = G.P_CENTERS.j_ancient
            
            other_name2 = localize { type = 'name_text', set = 'Joker', key = 'j_ancient' }
        end
        return {
            vars = {
                other_name,
                other_name2
            }
        }
    end,
    unlocked = false,
  	discovered = false,
}