SMODS.Sound({
    key = "ransom_jumpscare",
    path = "ransom_jumpscare.ogg",
})

UNIK.detriment{
    key = "unik_ransomware",
    atlas = "unik_detriments",
	pos = { x = 1, y = 3 },
    severity = 3,
    attributes = { 'detrimental','modify_card','destroy_card','banishing','debuff','detriment','activated' },
    config = { extra = {rounds_left = 3,multiplier = 0.4,use_cost = 20} },
    loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = { set = "Other", key = "unik_banishing" }
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_ransomed" }
        return { 
            vars = { center.ability.extra.multiplier,center.ability.extra.rounds_left,colours = { 
			G.C.SECONDARY_SET.Enhanced
		}} }
	end,
	blueprint_compat = false,
    immutable = true,
    dongtong_compat = false,
    in_pool = function(self, args)
        return true
    end,
    add_to_deck = function(self, card, from_debuff)
        card.children.center:set_sprite_pos({x = 1, y = 3})
        if not from_debuff then
            if #G.jokers.cards == 0 then
                selfDestruction_noMessage(card,true)
            else
                for i,v in pairs(G.jokers.cards) do
                    v.ability.unik_ransomed = true
                end
                card.ability.extra.use_cost = math.max(5,math.ceil(G.GAME.dollars*card.ability.extra.multiplier))
            end
            
        end
	end,
     remove_from_deck = function (self, card, from_debuff)
        if not next(SMODS.find_card('detr_unik_ransomware')) then
            for i,v in pairs(G.jokers.cards) do
                    v.ability.unik_ransomed = nil
                    v.debuff = nil
                end
        end
    end,
    all_in_jest = {
        ability_cost = function(self, card)
             return card.ability.extra.use_cost
        end,
        can_use_ability = function(self, card, context)
			if (G.GAME.dollars - G.GAME.bankrupt_at) >= card.ability.extra.use_cost then
                for i,v in pairs(G.jokers.cards) do
                    if v.ability.unik_ransomed then
                        return true
                    end
                end
            end
        end,

        use_ability = function(self, card, args)
            args = args or {}
            SMODS.calculate_context({all_in_jest = {joker_ability_used = true, card = card, retriggered = args.retriggered, args = args}})
            if not args.free then ease_dollars(-card.ability.extra.use_cost) end
			local jokers = 0
            local validJokers = {}
            for i,v in pairs(G.jokers.cards) do
                if v.ability.unik_ransomed then
                    jokers = jokers + 1
                    validJokers[#validJokers+1] = v
                end
            end
            local joker = pseudorandom_element(validJokers, pseudoseed("unik_ransomware_select"))
            joker.ability.unik_ransomed = nil
            joker.debuff = false
            jokers = jokers - 1
            if jokers < 1 then
                selfDestruction(card,'k_unik_ransomware_thanks',HEX("00FF00"),true)
            end
            delay(0.5)
		end,
    },
    update = function(self, card, dt)
        if not card.aij_ability_cost_label or card.config.center.all_in_jest:ability_cost(card) ~= card.aij_ability_cost_label then
            card.aij_ability_cost_label = card.config.center.all_in_jest:ability_cost(card) or "??"
        end
        
    end,
    calculate = function(self, card, context)

        --backup
		if context.joker_type_destroyed and not card.ability.extra.rage_state and not context.blueprint and context.card and context.card ~= card then
            local jokers = 0
            for i,v in pairs(G.jokers.cards) do
                if v.ability.unik_ransomed then
                    jokers = jokers + 1
                end
            end
            if jokers < 1 then
                selfDestruction(card,'k_unik_ransomware_thanks',HEX("00FF00"),true)
            end
        end

        if context.end_of_round and context.cardarea == G.unik_detriment_area and card.ability.extra.rounds_left > 0 and not context.blueprint and not card.ability.extra.rage_state then
			card.ability.extra.rounds_left = card.ability.extra.rounds_left - 1
            local jokers = 0
            for i,v in pairs(G.jokers.cards) do
                if v.ability.unik_ransomed then
                    jokers = jokers + 1
                end
            end
            if jokers < 1 then
                selfDestruction(card,'k_unik_ransomware_thanks',HEX("00FF00"),true)
                return {

                }
            end
			if card.ability.extra.rounds_left > 0 then
				return {
					message = localize{type='variable',key='a_remaining',vars={card.ability.extra.rounds_left}},
					colour = G.C.BLACK
				}	
			else
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    func = function()
                        card.ability.extra.rage_state = true
                        card.children.center:set_sprite_pos({x = 5, y = 6})
                        play_sound('unik_ransom_jumpscare', 1, 13)
                        return true
                    end
                }))
                delay(1*G.SETTINGS.GAMESPEED)
                for i,v in pairs(G.jokers.cards) do
                    if v.ability.unik_ransomed then
                        G.E_MANAGER:add_event(Event({
                            delay = 0.1,
                            trigger = 'before',
                            func = function()
                                if not G.GAME.banned_keys then
                                G.GAME.banned_keys = {}
                                end
                                if not G.GAME.cry_banished_keys then
                                    G.GAME.cry_banished_keys = {}
                                end
                                G.GAME.cry_banished_keys[v.config.center.key] = true
                                v:juice_up(2,2)
                                v:gore6_break()
                                G.ROOM.jiggle = G.ROOM.jiggle + 2
                                return true
                            end
                        }))
                    end
                end
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    func = function()
                        card.ability.extra.rage_state = nil
                        card:gore6_break()
                        return true
                    end
                }))
                
			end
			
		end
    end
}

local updateStickerHook2 = Card.update
function Card:update(dt)
    local ret = updateStickerHook2(self,dt)
    if self.config.center.key == 'detr_unik_ransomware' and self.ability.extra.rage_state then
        self:juice_up(0,3)
        for i,v in pairs(G.jokers.cards) do
            if v.ability.unik_impounded then
                v:juice_up(0,3)
            else
                if v.ability.unik_impounded then
                v:juice_up(0,1)
            end
            end
        end
        if not (G.SETTINGS.paused) then
            G.ROOM.jiggle = G.ROOM.jiggle + 0.5
        end
        
    end

    return ret
end
