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
        if (#G.jokers.cards + G.GAME.joker_buffer > G.jokers.config.card_limit) then
            negative = true
        end
        

        local _card = nil
        --create a new card instead with edition if it's a decrementing one
        if card.config.center.pools and (card.config.center.pools.autocannibalism_food) then
            _card = create_card("Joker", G.jokers, nil, nil, nil, nil, card.config.center.key)
            if card.edition then
                _card:set_edition(card.edition.key,true)
            end
            
        else
            _card = copy_card(card, nil, nil, nil, nil)
        end
        _card:add_to_deck()
        _card:start_materialize()
        G.jokers:emplace(_card)
        if negative then
            _card:set_edition({negative = true},true)
        end
        _card.ability.destroyed_by_megatron = nil
        _card.ability.unik_lily_mark = true
        
    

    
    G.E_MANAGER:add_event(Event({
        delay = 0,
        trigger= 'before',
        func = function()
            SMODS.calculate_context({unik_white_lily_increment = true})
            return true
        end
    }))
    
    

end
SMODS.Atlas {
	key = "unik_white_lily",
	path = "unik_white_lily.png",
	px = 71,
	py = 95
}

--helps with white lily persistance even if she gets destroyed
function UNIK.white_lily_present()
    G.GAME.unik_white_lily_persistance = G.GAME.unik_white_lily_persistance or 0
    if next(find_joker("j_unik_white_lily_cookie")) or G.GAME.unik_white_lily_persistance > 0 then
        return true
    end
    return false
end
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
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_decrementing_food_jokers" }
        local quoteset = 'normal'
        local key = 'j_unik_white_lily_cookie'
        if center.ability.extra.Emult + center.ability.immutable.base_emult >= center.ability.immutable.limit then
            key = 'j_unik_white_lily_cookie_capped'
        end
		return { 
            key = key, vars = {center.ability.extra.Emult + center.ability.immutable.base_emult,tostring(center.ability.extra.Emult_mod),center.ability.immutable.limit,
        localize(wl_quotes[quoteset][math.random(#wl_quotes[quoteset])] .. "")} }
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
        if not context.blueprint and context.unik_white_lily_increment
        and card.ability.extra.Emult + card.ability.immutable.base_emult < card.ability.immutable.limit
        then
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
    local originalArea = self.area
    local white_lily = false
    G.GAME.unik_white_lily_persistance = G.GAME.unik_white_lily_persistance or 0
    -- Check that the card being removed is a joker that's in the player's deck, is a joker cardarea (or not in the cardarea) and that it's not being sold
    if not G.GAME.ignore_delete_context then
        if self.added_to_deck and self.ability.set == 'Joker' and (not self.unik_dissolve_sell_flag) and ((originalArea and originalArea == G.jokers) or (not originalArea) or (originalArea and originalArea ~= G.shop_jokers and originalArea ~= G.shop_booster and originalArea ~= G.shop_vouchers and originalArea ~= G.pack_cards and originalArea ~= G.shop_jokers))  then
            if G and G.GAME then
                if self.config.center.key == 'j_unik_white_lily_cookie' then
                    G.GAME.unik_white_lily_persistance = G.GAME.unik_white_lily_persistance + 1
                    white_lily = true
                end
                --SMODS.calculate_context({unik_destroying_joker = true, unik_destroyed_joker = self})
                if UNIK.white_lily_present() and not self.ability.unik_lily_mark and 
                not UNIK.detrimental_rarities[self.config.center.rarity] and not self.ability.unik_taw then
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                     G.E_MANAGER:add_event(Event({
                        delay = 0,
                        trigger= 'immediate',
                        func = function()
                            White_lily_copy(self)
                            G.GAME.joker_buffer = 0
                            return true
                        end
                    }))
                    
                end
            end
        end
    end
    G.E_MANAGER:add_event(Event({
        delay = 0,
        trigger= 'after',
        func = function()
            if white_lily then
                G.GAME.unik_white_lily_persistance = G.GAME.unik_white_lily_persistance - 1
            end
            return true
        end
    }))
    print("WLs present: " ..G.GAME.unik_white_lily_persistance)

    local ret = remove_ref(self)
    return ret
end

local deleter = Game.delete_run
function Game:delete_run()
    G.GAME.ignore_delete_context = true
    local ret = deleter(self)
    G.GAME.ignore_delete_context = nil
    return ret
end

