--Owned jokers and consumables appear X16 the usual rate (excluding clone man). Stacks additively 
--showman on steroids
SMODS.Joker {
    key = 'unik_cloneman',
    atlas = 'unik_epic',
    rarity = 'cry_epic', --Abstract cards make this rare now.
	pos = { x = 2, y = 0 },
    cost = 12,
    blueprint_compat = false, --sure I can make it copyable, but if you keep on cloning blueprints and endlessly stacking itself with this, this can still explode.
    perishable_compat = true,
	eternal_compat = true,
    --Not immutable hopefully
    immutable = true,
    config = { extra = { 
        multiplier = 6}, --why 4X? well you can copy it, retrigger it, blueprint it
        immutable = { max_multiplier = 100 },
    },
	loc_vars = function(self, info_queue, center)
		return { vars = { math.min(center.ability.immutable.max_multiplier, center.ability.extra.multiplier) } }
	end,
    -- calculate = function(self, card, context)
    --     if context.unik_cloneman then
    --         return {
    --             clone_factor = math.min(card.ability.extra.multiplier, card.ability.immutable.max_multiplier)
    --         }
    --     end
    -- end
}
