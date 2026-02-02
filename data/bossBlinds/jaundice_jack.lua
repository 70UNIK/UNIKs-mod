SMODS.Blind{
    key = 'unik_jaundice_jack',
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 24},
    boss_colour= HEX("f3c851"),
    dollars = 8,
    mult = 2,
    config = {},
       --Disable if doing Jokerless:
    in_pool = function()
        if (G.GAME.modifiers.no_shop_jokers)then
            return false
        end
        return true
	end,
    death_message = "special_lose_unik_jaundice_jack",
    get_loc_debuff_text = function(self)
		return localize("k_unik_jaundice_jack")
	end,
    --Create an eternal ghost
    set_blind = function(self, reset, silent)
        G.GAME.unik_jack_discarded = nil
        G.GAME.unik_pentagram_manager_fix = true

    end,
    calculate = function(self, blind, context)
		if context.discard and not G.GAME.blind.disabled then
			--visual cue to wiggle all jokers
			if context.other_card:get_id() == 11 then
                G.GAME.unik_jack_discarded = true
            end
		end
	end,
    unik_before_play = function(self)
        if not G.GAME.unik_jack_discarded then
            local validCards = {}
            --Get all ghosts 
            for i=1,#G.jokers.cards do
                --print("POSSESS")
                if G.jokers.cards[i].config.center.key ~= "j_hit_the_road" and not G.jokers.cards[i].ability.unik_taw and not G.jokers.cards[i].ability.cry_absolute and not G.jokers.cards[i].config.center.immune_to_vermillion then
                    validCards[#validCards+1] = G.jokers.cards[i]
                end
            end
            if #G.jokers.cards > 0 then
                local jackshit = pseudorandom_element(validCards, pseudoseed("unik_jackshit_select"))
                local index = -1
                for i = 1,#G.jokers.cards do
                    if G.jokers.cards[i] == jackshit then
                        turnJokerIntoJack(i)
                        break
                    end
                end
                
            end
            

        else
            G.GAME.unik_jack_discarded = nil
        end
	end,
    --If disabled, kill ONLY the pinned ghost.
    disable = function(self)
        G.GAME.unik_pentagram_manager_fix = nil
        G.GAME.unik_jack_discarded = nil
    end,
    defeat = function(self)
        G.GAME.unik_pentagram_manager_fix = nil
        G.GAME.unik_jack_discarded = nil
	end,
}
function turnJokerIntoJack(location,jack)
    --avoid cursed jokers and ghosts and absolute jokers
    if (G.jokers.cards[location].config.center.key ~= "j_hit_the_road" and not G.jokers.cards[location].ability.unik_taw and not G.jokers.cards[location].ability.cry_absolute and not G.jokers.cards[location].config.center.immune_to_vermillion) then
        --It will even destroy eternals!
        if G.jokers.cards[location].ability.eternal then
            card_eval_status_text(
                G.jokers.cards[location],
                "extra",
                nil,
                nil,
                nil,
                { message = localize("k_unik_boo_eternal_bypass"), colour = G.C.FILTER }
            )
        else
            card_eval_status_text(
                G.jokers.cards[location],
                "extra",
                nil,
                nil,
                nil,
                { message = localize("k_unik_jackshit"), colour = G.C.FILTER }
            )            
        end
        _card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_hit_the_road")
        G.jokers.cards[location]:remove_from_deck()
        _card:add_to_deck()
        _card:start_materialize()
        
        G.jokers.cards[location] = _card
        _card:set_card_area(G.jokers)
        _card.ability.eternal = nil
        _card.ability.unik_jackshit = nil
        G.jokers:set_ranks()
        G.jokers:align_cards()    
        G.GAME.blind.triggered = true
        G.GAME.blind:wiggle()
        G.ROOM.jiggle = G.ROOM.jiggle + 1
    end
end