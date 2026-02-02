SMODS.Joker {
    key = 'unik_brownie',
    atlas = 'unik_uncommon',
	pos = { x = 3, y = 3 },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = false,
    demicolon_compat = true,
    config = { extra = {x_mult = 1.5,x_mult_mod = 0.01,depleted_threshold = 0,destroyed = false} },
    pools = {  ["autocannibalism_food"] = true,["Food"] = true},
    loc_vars = function(self, info_queue, center)
        local key = 'j_unik_brownie'
        if center.ability.unik_depleted then
            key = 'j_unik_brownie_depleted'
        end
        return { 
            key = key, vars = {center.ability.extra.x_mult,center.ability.extra.x_mult_mod,center.ability.extra.depleted_threshold} }
	end,
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.destroyed = false
    end,
    calculate = function(self, card, context)
        if (context.individual and context.cardarea == G.play) or context.forcetrigger then
            if (card.ability.unik_depleted and card.ability.extra.x_mult - card.ability.extra.x_mult_mod < card.ability.extra.depleted_threshold) or (not card.ability.unik_depleted and card.ability.extra.x_mult - card.ability.extra.x_mult_mod <= 1) then
                if (not card.ability.extra.destroyed) and not context.blueprint and not context.retrigger_joker then
                    card.ability.extra.destroyed = true
                    selfDestruction(card,'k_eaten_ex',G.C.MULT)
                end
            else
                if not context.blueprint then
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "x_mult",
                        scalar_value = "x_mult_mod",
                        operation = "-",
                        message_key = 'a_xmult_minus',
                        message_colour = G.C.RED,
                        delay = 0.2,
                    })
                end
                
                return {
                    x_mult = card.ability.extra.x_mult,
                    card = card
                }
            end
        end
    end,
}
