--$2 per discard lost this round at 0 discards
SMODS.Joker {
    key = 'unik_instant_gratification',
    atlas = 'unik_normal_jokers',
	pos = { x = 4, y = 6 },
    rarity = 1,
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    demicoloncompat = true,
    config = { extra = {cash = 1.5}},
    attributes = { 'economy','discard' },
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_hands_lost" }
        return { 
            vars = {center.ability.extra.cash},
        }
	end,
    calculate = function(self, card, context)
        if (context.discard_mod and context.discard_mod_val < 0) or context.force_trigger then
            return {
                dollars = card.ability.extra.cash * math.abs(context.discard_mod_val)
            }
            
        end
    end,
    check_for_unlock = function(self, args)
        if args.type == 'win_custom' and G.jokers then
            for i,v in pairs(G.jokers.cards) do
                if v.config.center.key == 'j_delayed_grat' then
                    return true
                end
            end
        end
    end,
    locked_loc_vars = function(self, info_queue, card)
        local other_name = localize('k_unknown')
        if G.P_CENTERS['j_delayed_grat'].unlocked then
            info_queue[#info_queue + 1] = G.P_CENTERS.j_delayed_grat
            
            other_name = localize { type = 'name_text', set = 'Joker', key = 'j_delayed_grat' }
        end
        return {
        vars = {
            other_name
        }
        }
    end,
    unlocked = false,
  	discovered = false,
}