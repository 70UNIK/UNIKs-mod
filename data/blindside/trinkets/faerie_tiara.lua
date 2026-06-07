SMODS.Joker {
    key = 'unik_blindside_faerie_tiara',
    atlas = 'unik_trinkets',
    pos = {x = 4, y = 0},
    rarity = 'bld_keepsake',
    cost = 15,
	blueprint_compat = true,
	eternal_compat = true,
    config = { extra = { active = false,x_mult = 3 }},
    in_pool = function(self, args)
        return UNIK.hasBlindside()
    end,
	loc_vars = function(self, info_queue, center)
        local quote = "k_active_ex"
        if center.ability.extra.active then
            quote = "k_active_ex"
        else
            quote = "k_inactive_ex"
        end
		return {  
			vars = {center.ability.extra.x_mult,localize(quote) ,colours = {center.ability.extra.active and G.C.FILTER or G.C.UI.TEXT_INACTIVE}} 
		}
	end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.active then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
        if context.unik_refresh_blinds and not context.blueprint and not context.retrigger_joker then
            card.ability.extra.active = false
            return {
                message = localize('k_reset'),
                colour = G.C.DARK_EDITION,
            }
        end
        if context.unik_destroying_joker and context.unik_destroyed_joker and not context.blueprint and not context.retrigger_joker then
           -- print("create" .. context.unik_destroyed_joker.config.center.key)
            G.E_MANAGER:add_event(Event({
                trigger="before",
                func = function()
                    if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                local create = 1
                G.GAME.joker_buffer = G.GAME.joker_buffer + create
                
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if create > 0 then
                            local _card = copy_card(context.unik_destroyed_joker, nil, nil, nil, nil)
                            _card:add_to_deck()
                            _card:start_materialize()
                            G.jokers:emplace(_card)
                             _card.ability.destroyed_by_megatron = nil
                            G.GAME.joker_buffer = 0
                        end
                        
                        return true
                    end
                }))
            end
                    return true
                end
            }))
            
            
            if not card.ability.extra.active then
                card.ability.extra.active = true
                return {
                    message = localize('k_active_ex'),
                    colour = G.C.DARK_EDITION,
                }
            end
            
            
            
        end
	end,

}

local function attempt_backup_copy_lily(card)
    if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
        local create = 1
        G.GAME.joker_buffer = G.GAME.joker_buffer + create
        
        G.E_MANAGER:add_event(Event({
            func = function()
                if create > 0 then
                    local _card = copy_card(card, nil, nil, nil, nil)
                    _card:add_to_deck()
                    _card:start_materialize()
                    G.jokers:emplace(_card)
                    _card.ability.destroyed_by_megatron = nil
                    G.GAME.joker_buffer = 0
                end
                
                return true
            end
        }))
        return true
    end
    
    return false
end

local remove_ref = Card.remove
function Card.remove(self)
    local originalArea = self.area
    local white_lily = false
    G.GAME.unik_white_lily_persistance2 = G.GAME.unik_white_lily_persistance2 or 0
    if not G.GAME.ignore_delete_context then
        if self.added_to_deck and self.ability.set == 'Joker' and (not self.unik_dissolve_sell_flag) and ((originalArea and originalArea == G.jokers) or (not originalArea) or (originalArea and originalArea ~= G.shop_jokers and originalArea ~= G.shop_booster and originalArea ~= G.shop_vouchers and originalArea ~= G.pack_cards and originalArea ~= G.shop_jokers))  then
            
            if G and G.GAME then
                
                SMODS.calculate_context({unik_destroying_joker = true, unik_destroyed_joker = self})
                if G.GAME.unik_white_lily_persistance2 and G.GAME.unik_white_lily_persistance2 > 0 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            attempt_backup_copy_lily(self)
                            return true
                        end
                    }))
                    
                end
                if self.config.center.key == 'j_unik_blindside_faerie_tiara' then
                    G.GAME.unik_white_lily_persistance2 = G.GAME.unik_white_lily_persistance2 + 1
                    white_lily = true
                end
            end
        end
    end
    if white_lily then
        G.E_MANAGER:add_event(Event({
            delay = 0,
            trigger= 'after',
            func = function()
                G.GAME.unik_white_lily_persistance2 = G.GAME.unik_white_lily_persistance2 - 1
                return true
            end
        }))
    end
    local ret = remove_ref(self)
    return ret
end