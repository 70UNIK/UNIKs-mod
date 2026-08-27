--only UNIK's mod jokers can appear, self destructs after obtaining 3 jokers.
SMODS.Joker {
    key = 'unik_pink_chocolate',
    atlas = "unik_normal_jokers",
	pos = { x = 8, y = 0 },
    rarity = 2,
    cost = 7, 
	config = {
		extra = {
			cards = 7,
		},
	},
	perishable_compat = true,
    eternal_compat = false,
    blueprint_compat = false,
    demicolon_compat = false,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				center.ability.extra.cards
			},
		}
	end,
    pools = { ["Food"] = true},
	calculate = function(self, card, context)
        if ((context.unik_emplace and context.added and context.added ~= card and context.cardarea == G.jokers) or (context.using_consumeable and context.consumeable.ability.set == 'Spectral') ) 
         and not context.blueprint and not context.retrigger_joker and not G.GAME.repress_chocolate_unik then
            G.GAME.repress_chocolate_unik = true
            if card.ability.extra.cards > 1 then
                 card.ability.extra.cards =  card.ability.extra.cards  - 1
                 G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.repress_chocolate_unik = nil
                        return true
                    end,
                }))
                 return {
                    message = "" ..  card.ability.extra.cards,
                    colour = G.C.UNIK_UNIK,
                 }
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.repress_chocolate_unik = nil
                        return true
                    end,
                }))
                selfDestruction(card,'k_eaten_ex',G.C.UNIK_UNIK)
            end
        end
	end,
}
function UNIK.has_pink_choc()
    if next(find_joker("j_unik_pink_chocolate")) then
        return true
    end
    return false
end
-- function UNIK.check_total_non_UNIK_joker_count()
--     for _, v in pairs(G.P_CENTERS) do
        
--     end
-- end