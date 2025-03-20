local function White_lily_copy(card)
    local _card = copy_card(card, nil, nil, nil, nil)
    _card:add_to_deck()
    _card:start_materialize()
    G.jokers:emplace(_card)
    _card.ability.banana = nil
    _card.ability.perishable = nil -- Done manually to bypass perish compat
    _card.ability.eternal = nil
    _card.ability.cry_rigged = nil
    _card.ability.cry_hooked = nil
    _card.ability.unik_disposable = nil
    _card.ability.unik_depleted = nil
    _card.ability.pinned = nil
    _card.ability.cry_flickering = nil
    _card.ability.cry_possessed = nil
    _card.ability.extra.copying = false
    _card.ability.extra.Emult = _card.ability.extra.Emult + _card.ability.extra.Emult_mod
    _card.ability.extra_value = _card.ability.extra_value - (math.floor(_card.sell_cost*100*0.2)/100)
    --avoid permanently doubling her values to her copy so the multiply properties must transfer
    if card.config.cry_multiply then
        _card.config.cry_multiply = card.config.cry_multiply
    end
    _card:set_cost()

    card_eval_status_text(_card, "extra", nil, nil, nil, {
        message = localize({
            type = "variable",
            key = "a_powmult",
            vars = {
                number_format(to_big(_card.ability.extra.Emult)),
            },
        }),
        colour = G.C.DARK_EDITION,
        card = _card
    })
end
--TODO: fix if she self destructs while //MULTIPLY is active on her.
SMODS.Joker {
	key = 'unik_white_lily_cookie',
    atlas = 'placeholders',
    rarity = "cry_exotic",
	pos = { x = 0, y = 1 },
    cost = 50,
	blueprint_compat = true,
    perishable_compat = false,
	eternal_compat = true,
    config = { extra = { Emult = 1.0, Emult_mod = 0.1, sold = false,copying = false} },
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.Emult,center.ability.extra.Emult_mod} }
	end,
    add_to_deck = function(self, card, from_debuff)
        card.ability.perishable = nil
    end,
    pools = { ["unik_cookie_run"] = true, ["unik_copyrighted"] = true },
    calculate = function(self, card, context)
        if context.joker_main and (to_big(card.ability.extra.Emult) > to_big(1)) then
			return {
                message = localize({
					type = "variable",
					key = "a_powmult",
                    vars = {
                        number_format(card.ability.extra.Emult),
                    },
				}),
				Emult_mod = card.ability.extra.Emult,
                colour = G.C.DARK_EDITION,
			}
		end
        if context.ending_shop and not context.repetition and not context.blueprint then
            if card.ability.extra.copying == false then
                card.ability.extra.copying = true
                selfDestruction(card,"k_unik_plant_no_face",HEX("bfb2f6"))
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.2,
                    func = function()
                        White_lily_copy(card)
                        return true
                    end,
                }))
                
            end
        end
        if context.cry_start_dissolving and not context.repetition and not context.blueprint and context.card == card and card.ability.extra.sold == false and card.ability.extra.copying == false then
            card.ability.extra.copying = true
            White_lily_copy(card)
		end
        --selling her will NOT clone her
        if context.selling_self and not context.repetition and not context.blueprint then
            card.ability.extra.sold = true
        end
    end,
}
