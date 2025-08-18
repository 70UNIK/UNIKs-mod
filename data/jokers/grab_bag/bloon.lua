SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_bloon',
    atlas = 'unik_grab_bag_jokers',
    pos = { x = 0, y = 1 },
    rarity = "gb_boss",
	-- Modest
    config = { extra = { Xmult = 2.5}, },
    cost = 7,
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	demicoloncompat = true,
    discovered = true,
    unlocked = true,
    loc_vars = function(self, info_queue, center)
        if not center.edition or (center.edition and not center.edition.unik_bloated) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_unik_bloated
		end
		return { vars = {center.ability.extra.Xmult} }
	end,
    calculate = function(self, card, context)
		if context.forcetrigger then

            return {

                x_mult = card.ability.extra.Xmult,
                colour = G.C.MULT,
            }
        end
        if context.before and context.cardarea == G.jokers and G.GAME.current_round.hands_played == 0 then
            for i,v in pairs(G.play.cards) do
                if not v.edition then
                    v:set_edition({ unik_bloated = true }, true,nil, true)
                elseif v.edition and not v.edition.unik_bloated then
                    v:set_edition({ unik_bloated = true }, true,nil, true)
                end
            end
            return {

            }
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card and context.other_card.edition and context.other_card.edition.unik_bloated then
                return {
                    x_mult = card.ability.extra.Xmult,
                    colour = G.C.MULT,
                }
			end
        end
	end,
    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_unik_bloon")
    end,
    set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("GrabBag")[1] }, badges)
    end,
}