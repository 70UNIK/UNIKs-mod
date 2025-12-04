SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_mountain_dew',
    atlas = 'unik_uncommon',
	pos = { x = 9, y = 0 },
    rarity = 2,
    config = { extra = { triggers = 10 } },
    cost = 6,
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = false,
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.triggers} }
	end,
    pools = { ["Food"] = true},
    calculate = function(self, card, context)
		if (context.using_consumeable and context.consumeable.ability.set == 'unik_summit') or context.forcetrigger then
             if not context.blueprint and not context.retrigger_joker then
                card.ability.extra.triggers = card.ability.extra.triggers - 1
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                func = function()
                    add_tag(Tag("tag_double"))
                    play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
                    play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                    return true
                end,
            }))
            if card.ability.extra.triggers <= 0 then
                selfDestruction(card,'k_drank_ex',G.C.UNIK_SUMMIT)
            else
                return {
                    message = card.ability.extra.triggers .. " ",
                    colour = G.C.UNIK_SUMMIT
                }
            end
            
        end
	end
}