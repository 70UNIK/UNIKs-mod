--wild cards become crosses by default
SMODS.Joker {
    key = 'unik_tic_tac',
    atlas = 'unik_rare',
	pos = { x = 4, y = 2 },
    rarity = 3,
    cost = 7,
    blueprint_compat = false,
    perishable_compat = true,
	eternal_compat = false,
    immutable = true,
    config = {extra = {triggers = 15}},
    pools = { ["Food"] = true},
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = UNIK.suit_tooltip('light')
        info_queue[#info_queue + 1] = UNIK.suit_tooltip('dark')
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_noughts_info" }
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_crosses_info" }
        return {
            vars = {localize("unik_Noughts","suits_plural"),localize("unik_Crosses","suits_plural"),center.ability.extra.triggers,
                colours = {G.C.SUITS['unik_Noughts'],G.C.SUITS['unik_Crosses']}
            },
            
        }
	end,
    calculate = function(self, card, context)
        if context.after and context.cardarea == G.jokers and not context.repetition and not context.retrigger_joker then
            local trigger = false
            local validCards = {}
            for i,v in pairs(context.scoring_hand) do
                if card.ability.extra.triggers > 0 then
                    local triggered = false
                    if UNIK.is_suit_type(v,'light') and v.base.suit ~= 'unik_Noughts' then
                        -- assert(SMODS.change_base(v, 'unik_Noughts'))
                        triggered = true
                        trigger = true
                    end
                    if UNIK.is_suit_type(v,'dark') and v.base.suit ~= 'unik_Crosses' then
                        -- assert(SMODS.change_base(v, 'unik_Crosses'))
                        triggered = true
                        trigger = true
                    end
                    if triggered then
                        validCards[#validCards+1] = v
                        
                        card.ability.extra.triggers = card.ability.extra.triggers - 1
                    end
                end
            end

            for i=1, #validCards do
                local percent = 1.15 - (i-0.999)/(#validCards-0.998)*0.3
                G.E_MANAGER:add_event(Event({
                    delay = 0.15,
                    trigger= 'after',
                    func = function()
                        validCards[i]:flip();play_sound('card1', percent);validCards[i]:juice_up(0.3, 0.3);
                        return true
                    end
                }))
            end
            for i=1, #validCards do
                G.E_MANAGER:add_event(Event({
                        delay = 0.1,
                        trigger= 'after',
                        func = function()
                            if UNIK.is_suit_type(validCards[i],'light') and validCards[i].base.suit ~= 'unik_Noughts' then
                                assert(SMODS.change_base(validCards[i], 'unik_Noughts'))
                            end
                            if UNIK.is_suit_type(validCards[i],'dark') and validCards[i].base.suit ~= 'unik_Crosses' then
                                assert(SMODS.change_base(validCards[i], 'unik_Crosses'))
                            end
                            return true
                        end
                }))
            end
            for i=1, #validCards do
                local percent = 0.85 + ( i - 0.999 ) / ( #validCards - 0.998 ) * 0.3
                G.E_MANAGER:add_event(Event({
                    delay = 0.15,
                    trigger= 'after',
                    func = function()
                        validCards[i]:flip(); play_sound('tarot2', percent, 0.6); validCards[i]:juice_up(0.3, 0.3);
                        return true
                    end
                }))
            end
            
            
            if card.ability.extra.triggers > 0 and trigger then
                return{
                    message = card.ability.extra.triggers .. "",
                    colour = G.C.SUITS['unik_Noughts'],
                }
            else
                if card.ability.extra.triggers <= 0 then
                    selfDestruction(card,'k_eaten_ex',G.C.SUITS['unik_Noughts'])
                end
            end
            
        end
    end,
}