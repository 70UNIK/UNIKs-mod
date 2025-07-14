--2.5x chips, all future tags become VESSEL TAGS
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_vessel_kiln',
    atlas = 'unik_uncommon',
    rarity = 2,
	pos = { x = 3, y = 1 },
    config = { extra = { x_chips = 2.5} }, 
    cost = 7,
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	demicoloncompat = true,
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
		if context.joker_main or context.forcetrigger then
			return {
				x_chips = card.ability.extra.x_chips,
                colour = G.C.CHIPS,
			}
		end
	end
}
local vessel_tagger = Cryptid.get_next_tag
function Cryptid.get_next_tag(override)
	if next(SMODS.find_card("j_unik_vessel_kiln")) then
		return "tag_unik_vessel"
	end
	return vessel_tagger(override)
	
end
if JokerDisplay then
	JokerDisplay.Definitions["j_unik_vessel_kiln"] = {
		text = {
			{
				border_nodes = {
					{ text = "X" },
					{
						ref_table = "card.ability.extra",
						ref_value = "x_chips",
						retrigger_type = "exp"
					},
				},
				border_colour = G.C.CHIPS,
			},
		},
	}
end