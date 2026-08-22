BLINDSIDE.Joker({
    blindside_joker = true,
    key = 'unik_blindside_toothy_joker',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=33},
    boss_colour = HEX("A0395A"),
    mult = 10,
    base_dollars = 6,
    order = 1,
    big = {min = 1},
    active = true,
    --can spawn if at least 5 blinds with editions are in deck.
    in_pool = function(self, args)
        if G.GAME.selected_back.effect.center.config.extra and G.playing_cards then
            if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
            G.GAME.unik_blindside_cinemas_used_this_run = G.GAME.unik_blindside_cinemas_used_this_run or 0
            if G.GAME.unik_blindside_cinemas_used_this_run > 1 then
                return G.GAME.blindside_banana_generated  and not (G.GAME.modifiers.enable_bld_elites and G.GAME.round_resets.ante == 5) and G.GAME.modifiers.enable_bld_tough_jokers
            end
        else
        return false
        end
    end,
   pool_override = function()
        return  G.GAME.blindside_banana_generated  and not (G.GAME.modifiers.enable_bld_elites and G.GAME.round_resets.ante == 5) and G.GAME.modifiers.enable_bld_tough_jokers
    end,
    joker_set = function ()
         G.GAME.unik_blindside_cinemas_used_this_run = G.GAME.unik_blindside_cinemas_used_this_run or 0
        UNIK.blindside_chips_modifyV2({chips_base = 0.05 * G.GAME.unik_blindside_cinemas_used_this_run}) 
        G.GAME.blind:wiggle()
        BLINDSIDE.change_fire_amount({amount = 0.1})
        BLINDSIDE.add_fire(G.GAME.unik_blindside_cinemas_used_this_run)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                BLINDSIDE.chipsupdate()
            return true end }))
    end,
    disable = function()
         G.GAME.unik_blindside_cinemas_used_this_run = G.GAME.unik_blindside_cinemas_used_this_run or 0
        UNIK.blindside_chips_modifyV2({chips_base = -0.05 * G.GAME.unik_blindside_cinemas_used_this_run}) 
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                BLINDSIDE.chipsupdate()
            return true end }))
    end,
    enable = function()
        G.GAME.unik_blindside_cinemas_used_this_run = G.GAME.unik_blindside_cinemas_used_this_run or 0
        UNIK.blindside_chips_modifyV2({chips_base = 0.05 * G.GAME.unik_blindside_cinemas_used_this_run }) 
        G.GAME.blind:wiggle()
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                BLINDSIDE.chipsupdate()
            return true end }))
    end,
     loc_vars = function (self)
        G.GAME.unik_blindside_cinemas_used_this_run = G.GAME.unik_blindside_cinemas_used_this_run or 0
        return {
            vars = {
                G.GAME.unik_blindside_cinemas_used_this_run or 0
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                0
            }
        }
    end,
        calculate = function(self, blind, context)
        if context.setting_blind and G.GAME.modifiers.enable_bld_deplete_hands and G.GAME.current_round.hands_left > 1 then
            ease_hands_played(-1)
        end
    end,
})

local cuc = Card.use_consumeable
function Card:use_consumeable(area, copier)
    local cuk = cuc(self, area, copier)
    if self.ability.consumeable and self.ability.set == 'bld_obj_filmcard' then
        G.GAME.unik_blindside_cinemas_used_this_run = G.GAME.unik_blindside_cinemas_used_this_run or 0
        G.GAME.unik_blindside_cinemas_used_this_run = G.GAME.unik_blindside_cinemas_used_this_run + 1
    end
    return cuk
end