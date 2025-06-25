--+1 chip per status trigger
SMODS.Joker {
    key = 'unik_copycat',
    atlas = "placeholders",
    rarity = 1,
    pos = {x = 1, y = 0},
	cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    config = {
		extra = { chip_mod = 0.5, chips = 0 },
	},
	calculate = function(self, card, context)
		if context.unik_after_message then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
            return {
                message = localize({ type = "variable", key = "a_chips", vars = { card.ability.extra.chips } }),
                colour = G.C.CHIPS,
            }
		end
        if context.joker_main and context.cardarea == G.jokers then
            return {
                message = localize({ type = "variable", key = "a_chips", vars = { card.ability.extra.chips } }),
                chip_mod = card.ability.extra.chips,
            }
        end
	end,
}

--patch to detect card status.
--patch to remove animations
local cest = card_eval_status_text
function card_eval_status_text(a,b,c,d,e,f)
    cest(a,b,c,d,e,f)
    if not G.GAME.unik_halt_message_calc then
        G.GAME.unik_halt_message_calc = true
        SMODS.calculate_context({unik_after_message = true})
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        func = function()
            G.GAME.unik_halt_message_calc = nil
            return true
        end
    })) 
end