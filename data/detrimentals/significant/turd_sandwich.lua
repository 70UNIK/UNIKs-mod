UNIK.detriment{
    key = "unik_turd_sandwich",
    atlas = "unik_detriments",
	pos = { x = 1, y = 6 },
    config = { extra = { x_mult = 0.4,mult = -18,x_mult_mod = 0.01,mult_mod = 0.3} }, --why emult? 
    severity = 2,
    immutable = true,
    dongtong_compat = false,
    blueprint_compat = true,
    attributes = { 'detrimental','mult','xmult','detriment','scaling'},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult,card.ability.extra.x_mult,card.ability.extra.mult_mod,card.ability.extra.x_mult_mod,1} }
	end,
    calculate = function(self, card, context)
        if context.joker_main then
             SMODS.calculate_effect({
                x_mult = card.ability.extra.x_mult,
                colour = G.C.RED,
            }, context.blueprint_card or card)
            return {
                -- x_mult = card.ability.extra.x_mult,
                mult = card.ability.extra.mult,
            }
        end
        if (context.discard and not context.blueprint) then
            if  card.ability.extra.x_mult < 1 then
                SMODS.scale_card(card, {
                    ref_table =card.ability.extra,
                    ref_value = "x_mult",
                    scalar_value = "x_mult_mod",
                    message_key = "a_xmult",
                    message_colour = G.C.MULT,
                    delay = 0.15,
                })
                SMODS.scale_card(card, {
                    ref_table =card.ability.extra,
                    ref_value = "mult",
                    scalar_value = "mult_mod",
                    message_key = "a_mult",
                    message_colour = G.C.MULT,
                    delay = 0.15,
                })
            end
			
            if card.ability.extra.x_mult >= 1 and not card.destroyed then
                selfDestruction(card,"k_eaten_ex",G.C.BLACK)
            end
            return {

            }
		end
    end,
}