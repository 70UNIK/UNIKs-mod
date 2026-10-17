SMODS.Joker {
    key = 'unik_meaty_stick',
    atlas = 'unik_normal_jokers',
	pos = { x = 3, y = 8 },
    rarity = 1,
    cost = 7,
    config = {
        extra = {
            xMult = 1.5
        }
    },
    attributes = { 'xmult','joker','stick' },
	perishable_compat = true,
    eternal_compat = false,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local xMult = PB_UTIL.calculate_stick_xMult(card)

        return {
            vars = {
                card.ability.extra.xMult,
                xMult
            }
        }
    end,

    calculate = PB_UTIL.stick_joker_logic,
	in_pool = function(self)
		return false
	end,
    set_badges = function (self, card, badges)
		if card.config.center.discovered then
			SMODS.create_mod_badges({ mod = SMODS.find_mod("paperback")[1] }, badges)
		end
    end,
    check_for_unlock = function(self, args) return false end,
    discovered = false,
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        local other_name = localize('k_unknown')
        if G.P_CENTERS['j_unik_nem_nuong'].unlocked then
            info_queue[#info_queue + 1] = G.P_CENTERS.j_unik_nem_nuong
            other_name = localize { type = 'name_text', set = 'Joker', key = 'j_unik_nem_nuong' }
        end
        return {
            vars = {
                other_name
            }
        }
    end,
}