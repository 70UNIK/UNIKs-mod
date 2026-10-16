SMODS.Joker {
    key = 'unik_riif_roof',
    atlas = 'unik_normal_jokers',
    rarity = 2,
	pos = { x = 1, y = 0 },
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    demicoloncompat = true,
    config = { extra = { Xmult = 1.3} },
    attributes = { 'xmult','joker','rarity'},
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.Xmult} }
	end,
    check_for_unlock = function(self, args)
        if args.type == 'modify_jokers' and G.jokers then
            local baseball = false
            local non_commons = 0
            local commons = 0
            for _, v in ipairs(G.jokers.cards) do
                if v.config.center_key == "j_baseball" and not baseball then 
                    baseball = true 
                else
                    if v.config.center.rarity == 1 then 
                        commons = commons + 1
                    else
                        non_commons = non_commons + 1
                    end
                end  
            end
            return baseball and non_commons == 0 and commons > 0
        end
    end,
    locked_loc_vars = function(self, info_queue, card)
        local other_name = localize('k_unknown')
        if G.P_CENTERS['j_baseball'].unlocked then
            info_queue[#info_queue + 1] = G.P_CENTERS.j_baseball
            
            other_name = localize { type = 'name_text', set = 'Joker', key = 'j_baseball' }
        end
        return {
        vars = {
            other_name
        }
        }
    end,
    unlocked = false,
  	discovered = false,
    pronouns = "he_him",
    calculate = function(self, card, context)
        if context.forcetrigger then
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
                Xmult_mod = card.ability.extra.Xmult
            }
        end
        if (context.other_joker and card ~= context.other_joker) then
            if context.other_joker.config.center.rarity == 1 then --Common
				return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
                    Xmult_mod = card.ability.extra.Xmult
				}
            end
        end
    end
}
