local wl_quotes = {
	normal = {
		'k_unik_white_lily_normal1',
        'k_unik_white_lily_normal2',
        'k_unik_white_lily_normal3',
        'k_unik_white_lily_normal4',
        'k_unik_white_lily_normal5',
        'k_unik_white_lily_normal6',
	},
}


local function White_lily_copy(card)
    local negative = false
    if not #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
        negative = true
    end
    local create = 1
	G.GAME.joker_buffer = G.GAME.joker_buffer + create

    local _card = copy_card(card, nil, nil, nil, nil)
    _card:add_to_deck()
    _card:start_materialize()
    G.jokers:emplace(_card)
    if negative then
        _card:set_edition({negative = true},true)
    end
    _card.ability.destroyed_by_megatron = nil
    _card.ability.unik_lily_mark = true

    G.GAME.joker_buffer = 0

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
    rarity = "unik_ancient",
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
    cost = 50,
	blueprint_compat = true,
    perishable_compat = false,
    demicoloncompat = true,
	eternal_compat = true,
    pronouns = "she_her",
    -- Mainline:
    -- Commit can only be used on her ONCE, if she recieves COMMIT again, she cannot create a copy 
    -- Madness: No COMMIT limit, feel free to go ham on creating free Exotics
    --Why 0.15? Exponents can be op, scaling exponents even more so. ^1.5 or close to that is very strong in vanilla balance.
    config = { extra = { Emult = 0.0, Emult_mod = 0.1}, immutable = {base_emult = 1.0,limit = 2.0} },
	loc_vars = function(self, info_queue, center)
        local quoteset = 'normal'
        local key = 'j_unik_white_lily_cookie'
        if center.ability.extra.Emult + center.ability.immutable.base_emult >= center.ability.immutable.limit then
            key = 'j_unik_white_lily_cookie_capped'
        end
		return { 
            key = key, vars = {center.ability.extra.Emult + center.ability.immutable.base_emult,tostring(center.ability.extra.Emult_mod),center.ability.immutable.limit,
        localize(wl_quotes[quoteset][math.random(#wl_quotes[quoteset])] .. "")} }
	end,
    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            if not  card.ability.immutable.sold and not card.ability.unik_lily_mark then
                SMODS.scale_card(card, {
                    ref_table =card.ability.extra,
                    ref_value = "Emult",
                    scalar_value = "Emult_mod",
                    base = 1,
                    message_key = "a_powmult",
                    operation = function(ref_table, ref_value, initial, scaling)
						ref_table[ref_value] = math.min(initial + scaling,card.ability.immutable.limit - card.ability.immutable.base_emult)
					end,
                    message_colour = G.C.DARK_EDITION,
                        force_full_val = true,
                })
                White_lily_copy(card)
            end
        end
    end,
    add_to_deck = function(self,card,from_debuff)
        card.ability.immutable.sold = false
    end,
    pools = { ["unik_cookie_run"] = true, ["unik_copyrighted"] = true },
    calculate = function(self, card, context)
        if context.forcetrigger then
            return {
                e_mult = card.ability.extra.Emult + card.ability.immutable.base_emult,
                colour = G.C.DARK_EDITION,
            }
        end
        if context.joker_main then
            if (to_big(card.ability.extra.Emult + card.ability.immutable.base_emult) > to_big(1)) then
                return {
                    e_mult = card.ability.extra.Emult + card.ability.immutable.base_emult,
                    colour = G.C.DARK_EDITION,
                }
            end
		end
        if not context.blueprint and context.unik_destroying_joker and card.ability.extra.Emult + card.ability.immutable.base_emult < card.ability.immutable.limit then
                SMODS.scale_card(card, {
                    ref_table =card.ability.extra,
                    ref_value = "Emult",
                    scalar_value = "Emult_mod",
                    base = 1,
                    message_key = "a_powmult",
                    operation = function(ref_table, ref_value, initial, scaling)
						ref_table[ref_value] = math.min(initial + scaling,card.ability.immutable.limit - card.ability.immutable.base_emult)
					end,
                    message_colour = G.C.DARK_EDITION,
                        force_full_val = true,
                })
            
                                return {

            }
        end
         if context.selling_self then
            card.ability.immutable.sold = true
        end
    end,
}

function unik_set_sell_cost(card, amount)
  if not card.set_cost then return end
  -- This is called just so it calculates the cost of the card... a bit silly
  
  card.ability.extra_value = amount - math.max(1, math.floor(card.cost / 2))
  card:set_cost()
end

--Brand new! Context copied from paperback
-- Add new context that happens after destroying jokers
local remove_ref = Card.remove
function Card.remove(self)
  -- Check that the card being removed is a joker that's in the player's deck and that it's not being sold
  if self.added_to_deck and self.ability.set == 'Joker' and (not G.CONTROLLER.locks.selling_card or self.ability.destroyed_by_scattering) then
        SMODS.calculate_context({unik_destroying_joker = true, unik_destroyed_joker = self})
        if next(find_joker("j_unik_white_lily_cookie")) then
            White_lily_copy(card)
        end
        self.ability.destroyed_by_scattering = nil
  end

  local ret = remove_ref(self)
  self.ability.destroyed_by_scattering = nil
  return ret
end
