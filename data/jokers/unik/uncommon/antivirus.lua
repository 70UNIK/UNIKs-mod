SMODS.Joker {
    key = "unik_antivirus",
    atlas = 'unik_uncommon',
    rarity = 2,
    cost = 6,
    pos = { x = 1, y = 3 },
    blueprint_compat = false,
    perishable_compat = true,
	eternal_compat = true,
    immutable = true,
    pronouns = "it_its",
    loc_vars = function(self, info_queue, center)
        if not center.ability.unik_shielded then
            info_queue[#info_queue + 1] = { set = "Other", key = "unik_shielded" }
        end
        
	end,
    calculate = function(self, card, context)
        if context.setting_ability and string.sub(context.new, 1, 2) == 'm_' and not context.unik_enhance_card  then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    context.other_card.ability.unik_shielded = true
                    context.other_card.debuff = false
                    return true
                end,
            }))
            
            return {
                message = localize('k_unik_protected'),
                colour = HEX("6bff92"),
                card = card,
            }
        elseif context.unik_enhance_card and context.unik_enhanced_card.debuff then
            if context.unik_enhanced_card.area == G.hand then
                if context.unik_enhanced_card and ((context.unik_enhanced_card.ability and not context.unik_enhanced_card.ability.unik_shielded) or not context.unik_enhanced_card.ability) then
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.1,
                        func = function()
                            context.unik_enhanced_card.ability.unik_shielded = true
                            context.unik_enhanced_card.debuff = false
                            return true
                        end,
                    }))
                    
                    return {
                        message = localize('k_unik_protected'),
                        colour = HEX("6bff92"),
                        card = card,
                    }
                end
            end
        end
    end
}