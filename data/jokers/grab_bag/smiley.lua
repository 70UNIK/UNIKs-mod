--First played hand Becomes positive. Scored positive cards give X3 Mult, decrease by X0.5 per card held.
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_smiley',
    atlas = 'unik_grab_bag_jokers',
    pos = { x = 5, y = 0 },
    rarity = "gb_boss",
	-- Modest
    config = { extra = { Xmult = 3, decrease = 0.5}, },
    cost = 7,
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	demicoloncompat = true,
    discovered = true,
    unlocked = true,

    loc_vars = function(self, info_queue, center)
        local dispMult = center.ability.extra.Xmult
        if G.hand and G.hand.cards and G.hand.highlighted then
            dispMult =  math.max(1,center.ability.extra.Xmult - ((#G.hand.cards - #G.hand.highlighted) * center.ability.extra.decrease))
        end
        
        if not center.edition or (center.edition and not center.edition.unik_positive) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_unik_positive
		end
		return { vars = {math.max(1,dispMult), center.ability.extra.decrease} }
	end,
    calculate = function(self, card, context)
		if context.forcetrigger then

            return {

                x_mult = math.max(1,card.ability.extra.Xmult - (#G.hand.cards * card.ability.extra.decrease)),
                colour = G.C.MULT,
            }
        end
        if context.before and context.cardarea == G.jokers and G.GAME.current_round.hands_played == 0 then
            for i,v in pairs(G.play.cards) do
                if not v.edition then
                    v:set_edition({ unik_positive = true }, true,nil, true)
                elseif v.edition and not v.edition.unik_positive then
                    v:set_edition({ unik_positive = true }, true,nil, true)
                end
            end
            return {

            }
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card and context.other_card.edition and context.other_card.edition.unik_positive then
                return {
                    x_mult = math.max(1,card.ability.extra.Xmult - (#G.hand.cards * card.ability.extra.decrease)),
                    colour = G.C.MULT,
                }
			end
        end
	end,
    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_unik_smiley")
    end,
    set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("GrabBag")[1] }, badges)
    end,
}