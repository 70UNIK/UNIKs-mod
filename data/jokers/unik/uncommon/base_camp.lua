SMODS.Joker {
    key = 'unik_base_camp',
    atlas = 'unik_uncommon',
    rarity = 2,
	pos = { x = 7, y = 3 },
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    demicolon_compat = true,
    immutable = true,
    loc_vars = function(self, info_queue, center)
        if G.GAME and not G.GAME.unik_base_camp_bonus then
            G.GAME.unik_base_camp_bonus = {
                e_mult = 0,
                e_chips = 0,
                chips = 0,
                mult = 0,
                dollars = 0,
                x_mult = 0,
                x_chips = 0,
            }
        end
        local table
        if G and G.GAME and G.GAME.unik_base_camp_bonus then
            table = G.GAME.unik_base_camp_bonus
        else
            table = {
                e_mult = 0,
                e_chips = 0,
                chips = 0,
                mult = 0,
                dollars = 0,
                x_mult = 0,
                x_chips = 0,
            }
        end
        local string = 'j_unik_base_camp'.. 1
        if table.e_mult > 0 then
            string = 'j_unik_base_camp' .. 2
            if table.e_chips > 0 then
                string = 'j_unik_base_camp' .. 4
            end
        end
        if table.e_chips > 0 then
            string = 'j_unik_base_camp' .. 3
            if table.e_mult > 0 then
                string = 'j_unik_base_camp' .. 4
            end
        end
		return { key = string,vars = {table.mult, table.chips, 1+table.x_mult, 1+table.x_chips, 1+table.e_mult, 1+table.e_chips,table.dollars, } }
	end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            if not G.GAME.unik_base_camp_bonus then
                G.GAME.unik_base_camp_bonus = {
                    e_mult = 0,
                    e_chips = 0,
                    chips = 0,
                    mult = 0,
                    dollars = 0,
                    x_mult = 0,
                    x_chips = 0,
                }
            end
            local table = G.GAME.unik_base_camp_bonus
            if table.e_chips > 0 and table.e_mult > 0 then
                 return {
                    mult = table.mult,
                    chips = table.chips,
                    x_mult = table.x_mult + 1,
                    x_chips =table.x_chips + 1,
                    e_mult = table.e_mult + 1,
                    e_chips = table.e_chips + 1,
                }
            end
            if table.e_mult > 0 then
                 return {
                    mult = table.mult,
                    chips = table.chips,
                    x_mult = table.x_mult + 1,
                    x_chips =table.x_chips + 1,
                    e_mult = table.e_mult + 1,
                }
            end
            if table.e_chips > 0 then
                return {
                    mult = table.mult,
                    chips = table.chips,
                    x_mult = table.x_mult + 1,
                    x_chips =table.x_chips + 1,
                    e_chips = table.e_chips + 1,
                }
            end
            return {
                mult = table.mult,
                chips = table.chips,
                x_mult = table.x_mult + 1,
                x_chips =table.x_chips + 1,
            }
        end
    end,
    calc_dollar_bonus = function(self, card)
        if not G.GAME.unik_base_camp_bonus then
            G.GAME.unik_base_camp_bonus = {
                e_mult = 0,
                e_chips = 0,
                chips = 0,
                mult = 0,
                dollars = 0,
                x_mult = 0,
                x_chips = 0,
            }
        end
		local bonus = G.GAME.unik_base_camp_bonus.dollars
        if bonus > 0 then
			return bonus
		end
	end,
}