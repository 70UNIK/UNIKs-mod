--Rework: This joker gains ^0.2 Mult when a joker (itself included) is destroyed. Creates a copy of itself if destroyed. Strong but now requires effort, while not being too unbalanced with dagger.


local function White_lily_copy(card)
    local _card = copy_card(card, nil, nil, nil, nil)
    _card:add_to_deck()
    _card:start_materialize()
    G.jokers:emplace(_card)
    _card.ability.destroyed_by_megatron = nil
    -- SMODS.scale_card(_card, {
    --     ref_table =_card.ability.extra,
    --     ref_value = "Emult",
    --     scalar_value = "Emult_mod",
    --     base = 1,
    --     message_key = "a_powmult",
    --     message_colour = G.C.DARK_EDITION,
    --         force_full_val = true,
    -- })
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
    config = { extra = { Emult = 0.0, Emult_mod = 0.1,cost = 0}, immutable = {base_emult = 1.0,sold = false,destroyed_joker_buffer = 0} },
	loc_vars = function(self, info_queue, center)
		return { 
            vars = {center.ability.extra.Emult + center.ability.immutable.base_emult,center.ability.extra.Emult_mod} }
	end,
    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            if not  card.ability.immutable.sold and not card.ability.unik_disposable and not card.ability.unik_niko 
            and not card.ability.cry_committed and not card.ability.cry_reworked then
                unik_set_sell_cost(card,0)
                G.GAME.Destroyed_Joker_buffer = G.GAME.Destroyed_Joker_buffer or 0
                if G.GAME.Destroyed_Joker_buffer > 0 then
                    SMODS.scale_card(card, {
                        ref_table =card.ability.extra,
                        ref_value = "Emult",
                        scalar_value = "custom_scaler",
                        scalar_table = {
                            custom_scaler = G.GAME.Destroyed_Joker_buffer * card.ability.extra.Emult_mod,
                        },
                        base = 1,
                        message_key = "a_powmult",
                        message_colour = G.C.DARK_EDITION,
                        force_full_val = true,
                    })
                end
                


                White_lily_copy(card)
            end
        end
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
        if not context.blueprint and context.unik_destroying_joker then
            if context.unik_destroyed_joker ~= card then
                SMODS.scale_card(card, {
                        ref_table =card.ability.extra,
                        ref_value = "Emult",
                        scalar_value = "Emult_mod",
                        base = 1,
                        message_key = "a_powmult",
                        message_colour = G.C.DARK_EDITION,
                         force_full_val = true,
                    })
                    				return {

				}
            end
        end
        if context.selling_self then
            card.ability.immutable.sold = true
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
  G.GAME.Destroyed_Joker_buffer = G.GAME.Destroyed_Joker_buffer or 0
  local removed = false
  if self.added_to_deck and self.ability.set == 'Joker' and not G.CONTROLLER.locks.selling_card then
        G.GAME.Destroyed_Joker_buffer = G.GAME.Destroyed_Joker_buffer + 1
        removed = true
        SMODS.calculate_context({unik_destroying_joker = true, unik_destroyed_joker = self})
            
  end

  local ret = remove_ref(self)
  if removed then
    G.E_MANAGER:add_event(Event({
			trigger = "after",
			func = function()
				G.GAME.Destroyed_Joker_buffer = math.max(G.GAME.Destroyed_Joker_buffer - 1,0)
                --print(G.GAME.Destroyed_Joker_buffer)
				return true
			end,
		}))
    
  end
  return ret
end
