--gain a double tag whenever you gain a tag (double tag included!)
SMODS.Joker {
    key = 'unik_double_up',
    atlas = 'placeholders',
	pos = { x = 2, y = 0 },
    rarity = 3,
    cost = 5,
	config = {
		extra = {
			tags = 1,
		},
	},
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
    blueprint_compat = true,
	loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'tag_double', set = 'Tag'}
		return {
			vars = {
				number_format(center.ability.extra.tags),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
            G.E_MANAGER:add_event(Event({
				func = function()
					add_tag(Tag("tag_double"))
					play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
					play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
					return true
				end,
			}))
            return {
                message = localize('k_unik_double_up')
			}
        end
        if context.tag_added and not context.tag_added.from_double_up then
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
				func = function()
					local new_tag = Tag("tag_double")
					new_tag.from_double_up = true
					add_tag(new_tag)
					new_tag.from_double_up = nil
					play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
					play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
					return true
				end,
			}))
            return {
                message = localize('k_unik_double_up')
			}
        end
	end,
}