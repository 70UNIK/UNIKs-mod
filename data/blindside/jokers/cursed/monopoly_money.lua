--Lose at least $6 in this round to double your money when defeated
BLINDSIDE.Joker({
    key = 'unik_blindside_monopoly_money',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=24},
    boss_colour = HEX('9893c2'),
    mult = 25,
    base_dollars = 8,
    order = 1,
    cursed = {min = -66},
    active = true,
    blindside_joker = true,
    in_pool = function(self, args)
        if G.GAME.selected_back.effect.center.config.extra then
            if not UNIK.hasBlindside() then return false end
            return true
        else
        return false
        end
    end,
    debuff = {
        akyrs_blind_difficulty = "unik_blindside_cursed",
    },
    calculate = function(self, blind, context)
        if context.setting_blind and not context.disabled then
            blind.active = true
        end
        if not blind.disabled and context.selling_card and blind.active and context.card.ability.unik_bought_this_ante then
            G.GAME.blind.active = false
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                ease_dollars(G.GAME.dollars, true)
                BLINDSIDE.change_fire_amount({amount = 3})
                BLINDSIDE.add_fire()
                G.GAME.blind.active = nil
                blind:wiggle()
            return true end }))
        end 
    end,
    loc_vars = function (self)

        return {
            vars = {

                
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {

            }
        }
    end,

})

local trinket = BLINDSIDE.add_trinket_to_shop
function BLINDSIDE.add_trinket_to_shop(key, dont_save)
    local ret = trinket(key, dont_save)
    ret.ability.unik_bought_this_ante = true
    return ret
end