--Owned jokers and consumables appear X16 the usual rate (excluding clone man). Stacks additively 
--showman on steroids
SMODS.Joker {
    key = 'unik_cloneman',
    atlas = 'unik_normal_jokers',
    rarity = 3,
	pos = { x = 6, y = 8 },
    cost = 5,
    blueprint_compat = false, --sure I can make it copyable, but if you keep on cloning blueprints and endlessly stacking itself with this, this can still explode.
    perishable_compat = true,
	eternal_compat = true,
    attributes = { 'passive'},
    unlocked = false,
  	discovered = false,
    config = { extra = { 
        multiplier = 5}, --why 4X? well you can copy it, retrigger it, blueprint it
        immutable = { max_multiplier = 100 },
    },
	loc_vars = function(self, info_queue, center)
		return { vars = { math.min(center.ability.immutable.max_multiplier, center.ability.extra.multiplier) } }
	end,
    check_for_unlock = function(self, args)
        if args.type == 'modify_jokers' and G.jokers then
        local showmen = 0
        for _, v in ipairs(G.jokers.cards) do
            if v.config.center_key == "j_ring_master" then showmen = showmen + 1 end
        end
        return showmen > 1
        end
    end,
    locked_loc_vars = function(self, info_queue, card)
        local other_name = localize('k_unknown')
        if G.P_CENTERS['j_ring_master'].unlocked then
            info_queue[#info_queue + 1] = G.P_CENTERS.j_ring_master
            other_name = localize('k_showmen')
        end
        return {
        vars = {
            2,other_name
        }
        }
    end,
}
