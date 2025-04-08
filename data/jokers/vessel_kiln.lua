--2.5x chips, all future tags become VESSEL TAGS
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_vessel_kiln',
    atlas = 'unik_uncommon',
    rarity = 2,
	pos = { x = 3, y = 1 },
    config = { extra = { x_chips = 3} }, 
    cost = 7,
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_unik_vessel
		return { vars = {center.ability.extra.x_chips} }
	end,
	gameset_config = {
		modest = {extra = {x_chips = 2} },
	},
    add_to_deck = function(self, card, from_debuff)
		G.GAME.unik_vesselled = true
	end,
	-- Inverse of above function.
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.unik_vesselled = nil
	end,
    calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = localize({ type = "variable", key = "a_xchips", vars = { card.ability.extra.x_chips } }),
				Xchip_mod = card.ability.extra.x_chips,
                colour = G.C.CHIPS,
			}
		end
	end
}
--override function to always generate vessel tags 
local overrideTagHook = add_tag
function add_tag(_tag)
    local res
    if G.GAME.unik_vesselled then
        local emp = Tag("tag_unik_vessel")
        emp.ability.shiny = cry_rollshinybool()
        res = overrideTagHook(emp)
    else
        res = overrideTagHook(_tag)
    end
    return res
end