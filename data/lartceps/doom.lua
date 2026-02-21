--All cards lose Scored and held X0.5 Mult, X0.5 Chips, 4 Mult, 30 Chips, and $3.
SMODS.Consumable {
    set = 'unik_lartceps', 
	atlas = 'unik_lartceps',
    cost = 0,
	pos = {x = 2, y = 2},
	key = 'unik_mount_doom',
    config = {extra= {mult = 4, chips = 30, x_mult = 0.5, x_chips = 0.5, money = 3, e_mult = 0.01}},
    no_doe = true,
    no_grc = true,
	no_ccd = true,
    can_use = function(self, card)
        return true
    end,
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.chips,center.ability.extra.mult,center.ability.extra.x_chips,center.ability.extra.x_mult,center.ability.extra.e_mult,center.ability.extra.money}}
	end,
    use = function(self, card, area, copier)
        local used_consumable = copier or card
        for i = 1, #G.playing_cards do
            local highlighted = G.playing_cards[i]
                highlighted.ability["perma_h_x_mult"] = highlighted.ability["perma_h_x_mult"] or 0
                highlighted.ability["perma_h_x_mult"] = highlighted.ability["perma_h_x_mult"] - card.ability.extra.x_mult
                highlighted.ability["perma_p_dollars"] = highlighted.ability["perma_p_dollars"] or 0
                highlighted.ability["perma_p_dollars"] = highlighted.ability["perma_p_dollars"] - card.ability.extra.money
                highlighted.ability["perma_x_chips"] = highlighted.ability["perma_x_chips"] or 0
                highlighted.ability["perma_x_chips"] = highlighted.ability["perma_x_chips"] - card.ability.extra.x_chips
                highlighted.ability["perma_e_mult"] = highlighted.ability["perma_e_mult"] or 0
                highlighted.ability["perma_e_mult"] = highlighted.ability["perma_e_mult"] - card.ability.extra.e_mult
                highlighted.ability["perma_mult"] = highlighted.ability["perma_mult"] or 0
                highlighted.ability["perma_mult"] = highlighted.ability["perma_mult"] - card.ability.extra.mult
                highlighted.ability["perma_h_x_chips"] = highlighted.ability["perma_h_x_chips"] or 0
                highlighted.ability["perma_h_x_chips"] = highlighted.ability["perma_h_x_chips"] - card.ability.extra.x_chips
                 highlighted.ability["perma_x_mult"] = highlighted.ability["perma_x_mult"] or 0
                highlighted.ability["perma_x_mult"] = highlighted.ability["perma_x_mult"] - card.ability.extra.x_mult
                highlighted.ability["perma_bonus"] = highlighted.ability["perma_bonus"] or 0
                highlighted.ability["perma_bonus"] = highlighted.ability["perma_bonus"] - card.ability.extra.chips
                highlighted.ability["perma_h_chips"] = highlighted.ability["perma_h_chips"] or 0
                highlighted.ability["perma_h_chips"] = highlighted.ability["perma_h_chips"] - card.ability.extra.chips
                highlighted.ability["perma_h_mult"] = highlighted.ability["perma_h_mult"] or 0
                highlighted.ability["perma_h_mult"] = highlighted.ability["perma_h_mult"] - card.ability.extra.mult
                highlighted.ability["perma_h_dollars"] = highlighted.ability["perma_h_dollars"] or 0
                highlighted.ability["perma_h_dollars"] = highlighted.ability["perma_h_dollars"] - card.ability.extra.money
        end
    end,
    in_pool = function()
		return lartcepsCheck()
	end,
}