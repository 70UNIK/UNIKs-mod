--remove all perishable stickers on all jokers, perishables become eternal (when possible)
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_preservatives',
    atlas = 'unik_normal_jokers',
    rarity = 2,
	pos = { x = 2, y = 3 },
    cost = 5,
	blueprint_compat = false, --nope!
    perishable_compat = true,
	eternal_compat = false,
    attributes = { 'stickers','food','modify_card'},
    in_pool = function(self)
        if G.jokers and G.jokers.cards then
            for i,v in pairs(G.jokers.cards) do 
                if v.ability.perishable then
                    return true
                end
            end
        end
		if G.GAME.modifiers.enable_perishables_in_shop then
			return true
		end
		return false
	end,
    config = {extra = {jokers = 6} },
    loc_vars = function(self, info_queue,card)
        info_queue[#info_queue + 1] = {key = 'perishable', set = 'Other', vars = {G.GAME.perishable_rounds or 1, G.GAME.perishable_rounds or G.GAME.perishable_rounds}}
        return {vars = {card.ability.extra.jokers }}
    end,
    pools = { ["Food"] = true},
    update = function(self,card,dt)
        if card.added_to_deck and G.jokers and G.playing_cards and G.consumeables then
             for i,v in pairs(G.jokers.cards) do
                if v.ability and v.ability.perishable then
                    v.ability.perishable = nil
                    v.debuff = false
                    card.ability.extra.jokers = card.ability.extra.jokers - 1
                    if (card.ability.extra.jokers <= 0) then
                        selfDestruction(card,'k_eaten_ex',G.C.PERISHABLE)
                    else
                         card_eval_status_text(card, 'extra', nil, nil, nil, { 
                        message = "" .. card.ability.extra.jokers,
                            colour = G.C.PERISHABLE,
                            card = card
                        })
                    end
                    
                end
            end
            -- for i,v in pairs(G.playing_cards) do
            --     if v.ability and v.ability.perishable then
            --         v.ability.perishable = nil
            --         v.ability.eternal = true
            --     end
            -- end
            -- for i,v in pairs(G.consumeables.cards) do
            --     if v.ability and v.ability.rental then
            --         v.ability.perishable = nil
            --         v.ability.eternal = true
            --     end
            -- end
        end
       
    end,
    check_for_unlock = function(self, args)
        if args.type == 'modify_jokers' and G.jokers then
            for _, v in ipairs(G.jokers.cards) do
                if v.config.center_key == "j_blueprint" or v.config.center_key == "j_brainstorm"  then 
                    if v.ability.unik_disposable or v.ability.perishable or v.ability.unik_decaying or v.ability.unik_niko then
                        return true
                    end
                end  
            end
        end
    end,
    locked_loc_vars = function(self, info_queue, card)
         info_queue[#info_queue + 1] = {key = 'perishable', set = 'Other', vars = {G.GAME.perishable_rounds or 1, G.GAME.perishable_rounds or G.GAME.perishable_rounds}}
          info_queue[#info_queue + 1] = {key = 'unik_disposable', set = 'Other'}
        local other_name1 = localize('k_unknown')
        local other_name2 = localize('k_unknown')
        if G.P_CENTERS['j_blueprint'].unlocked then
            info_queue[#info_queue + 1] = G.P_CENTERS.j_blueprint
            
            other_name1 = localize { type = 'name_text', set = 'Joker', key = 'j_blueprint' }
        end
        if G.P_CENTERS['j_brainstorm'].unlocked then
            info_queue[#info_queue + 1] = G.P_CENTERS.j_brainstorm
            
            other_name2 = localize { type = 'name_text', set = 'Joker', key = 'j_brainstorm' }
        end
        return {
        vars = {
            other_name1,other_name2
        }
        }
    end,
    unlocked = false,
  	discovered = false,
}