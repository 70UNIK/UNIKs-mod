--Rework: This joker gains ^0.2 Mult when a joker (itself included) is destroyed. Creates a copy of itself if destroyed. Strong but now requires effort, while not being too unbalanced with dagger.


local function White_lily_copy(card)
    local _card = copy_card(card, nil, nil, nil, nil)
   --print(_card.ability.extra.initial)

    
    _card:add_to_deck()
    _card:start_materialize()
    G.jokers:emplace(_card)
    if Card.get_gameset(_card) ~= "modest" then
        SMODS.scale_card(_card, {
            ref_table =_card.ability.extra,
            ref_value = "Emult",
            scalar_value = "Emult_mod",
            scaling_message = {
                message = localize({
                    type = "variable",
                    key = "a_powmult",
                    vars = {
                        number_format(to_big(_card.ability.extra.Emult + _card.ability.immutable.base_emult)),
                    },
                }),
                colour = G.C.DARK_EDITION,
            },
            message_colour = G.C.DARK_EDITION,
        })
    else
        SMODS.scale_card(_card, {
            ref_table =_card.ability.extra,
            ref_value = "x_mult",
            scalar_value = "x_mult_mod",
            scaling_message = {
                message = localize({
                    type = "variable",
                    key = "a_xmult",
                    vars = {
                        number_format(to_big(_card.ability.extra.x_mult)),
                    },
                }),
                colour = G.C.MULT,
            },
            message_colour = G.C.MULT,
        })
    end 

end
SMODS.Atlas {
	key = "unik_white_lily",
	path = "unik_white_lily.png",
	px = 71,
	py = 95
}
--TODO: fix if she self destructs while //MULTIPLY is active on her.
--TODO: also disable her cloning functionality if you use BALATRO's SOUL, to not make her way to op, but more importantly, fix a critical issue (she will get destroyed and clone over and over, crashing the game)
SMODS.Joker {
	key = 'unik_white_lily_cookie',
    atlas = 'unik_white_lily',
    rarity = "cry_exotic",
    dependencies = {
		items = {
			"set_cry_exotic",
		},
    },
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
    cost = 50,
	blueprint_compat = true,
    perishable_compat = false,
    demicoloncompat = true,
	eternal_compat = true,
    -- Mainline:
    -- Commit can only be used on her ONCE, if she recieves COMMIT again, she cannot create a copy 
    -- Madness: No COMMIT limit, feel free to go ham on creating free Exotics
    --Why 0.15? Exponents can be op, scaling exponents even more so. ^1.5 or close to that is very strong in vanilla balance.
    config = { extra = { Emult = 0.0, Emult_mod = 0.15, x_mult = 1.0, x_mult_mod = 1.25,cost = 0}, immutable = {base_emult = 1.0} },
	loc_vars = function(self, info_queue, center)
		return { 
            key = Cryptid.gameset_loc(self, { modest = "modest"}), 
            vars = {center.ability.extra.Emult + center.ability.immutable.base_emult,center.ability.extra.Emult_mod,center.ability.extra.x_mult,center.ability.extra.x_mult_mod} }
	end,
    add_to_deck = function(self, card, from_debuff)
        
        card.ability.perishable = nil
        card.ability.extra.copying = false
        card.ability.extra.sold = false
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            if not  G.CONTROLLER.locks.selling_card and not card.ability.unik_disposable and not card.ability.unik_niko
            and not card.ability.cry_committed and not card.ability.cry_reworked then
                unik_set_sell_cost(card,0)
                White_lily_copy(card)
            end
        end
    end,
    pools = { ["unik_cookie_run"] = true, ["unik_copyrighted"] = true },
    calculate = function(self, card, context)
        if context.forcetrigger then
            if Card.get_gameset(card) ~= "modest" then
                return {
                    e_mult = card.ability.extra.Emult + card.ability.immutable.base_emult,
                    colour = G.C.DARK_EDITION,
                }
            else
                return {
                    message = localize({
                        type = "variable",
                        key = "a_xmult",
                        vars = {
                            number_format(card.ability.extra.x_mult),
                        },
                    }),
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT,
                }
            end
        end
        if context.joker_main then
            if Card.get_gameset(card) ~= "modest" then
                if (to_big(card.ability.extra.Emult + card.ability.immutable.base_emult) > to_big(1)) then
                    return {
                        e_mult = card.ability.extra.Emult + card.ability.immutable.base_emult,
                        colour = G.C.DARK_EDITION,
                    }
                end
            else
                if (to_big(card.ability.extra.x_mult) > to_big(1)) then
                    return {
                        message = localize({
                            type = "variable",
                            key = "a_xmult",
                            vars = {
                                number_format(card.ability.extra.x_mult),
                            },
                        }),
                        Xmult_mod = card.ability.extra.x_mult,
                        colour = G.C.MULT,
                    }
                end    
            end

		end
        if not context.blueprint and context.unik_destroying_joker then
            if context.unik_destroyed_joker ~= card then
                if Card.get_gameset(card) ~= "modest" then
                    SMODS.scale_card(card, {
                        ref_table =card.ability.extra,
                        ref_value = "x_mult",
                        scalar_value = "x_mult_mod",
                        scaling_message = {
                            message = localize({
                                type = "variable",
                                key = "a_xmult",
                                vars = {
                                    number_format(to_big(card.ability.extra.x_mult)),
                                },
                            }),
                            colour = G.C.MULT,
                        },
                        message_colour = G.C.MULT,
                    })
                else
                    SMODS.scale_card(card, {
                        ref_table =card.ability.extra,
                        ref_value = "x_mult",
                        scalar_value = "x_mult_mod",
                        scaling_message = {
                            message = localize({
                                type = "variable",
                                key = "a_xmult",
                                vars = {
                                    number_format(to_big(card.ability.extra.x_mult)),
                                },
                            }),
                            colour = G.C.MULT,
                        },
                        message_colour = G.C.MULT,
                    })
                end
            end
        end
    end,
}

function unik_set_sell_cost(card, amount)
  if not card.set_cost then return end
  -- This is called just so it calculates the cost of the card... a bit silly
  card:set_cost()
  card.ability.extra_value = amount - math.max(1, math.floor(card.cost / 2))
  card:set_cost()
end

--Brand new! Context copied from paperback
-- Add new context that happens after destroying jokers
local remove_ref = Card.remove
function Card.remove(self)
  -- Check that the card being removed is a joker that's in the player's deck and that it's not being sold
  if self.added_to_deck and self.ability.set == 'Joker' and not G.CONTROLLER.locks.selling_card then
        SMODS.calculate_context({unik_destroying_joker = true, unik_destroyed_joker = self})
  end

  return remove_ref(self)
end
