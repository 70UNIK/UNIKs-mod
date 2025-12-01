--gain a double tag whenever you gain a tag (double tag included!)
SMODS.Joker {
    key = 'unik_double_up',
    atlas = 'unik_rare',
	pos = { x = 0, y = 2 },
    rarity = 3,
    cost = 5,
	config = {
		extra = {
			tags = 2,
		},
	},
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
    blueprint_compat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.tags),
			},
		}
	end,
	pools = {  ["Food"] = true},
	calculate = function(self, card, context)
		if context.forcetrigger then
			for i = 1, card.ability.extra.tags do
				 G.E_MANAGER:add_event(Event({
					trigger = 'before',
					func = function()
						add_tag(Tag("tag_double"))
						play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
						play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
						return true
					end,
				}))
			end
            return {
                message = localize('k_unik_double_up')
			}
        end
        if context.tag_added and not context.tag_added.from_double_up then
			for i = 1, card.ability.extra.tags do
				 G.E_MANAGER:add_event(Event({
					trigger = 'before',
					func = function()
						local ab = copy_table(context.tag_added.ability)
						local new_tag = Tag(context.tag_added.key)	
						new_tag.from_double_up = true
						add_tag(new_tag)
						new_tag.from_double_up = nil
						new_tag.ability = ab
						play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
						play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
						return true
					end,
				}))
			end
            return {
                message = localize('k_unik_double_up')
			}
        end
	end,
}