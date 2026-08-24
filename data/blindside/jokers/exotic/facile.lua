--^2.5 mult to joker per blind scored after the 10th scored blind
SMODS.Atlas({ 
    key = "unik_blindside_facile", 
    atlas_table = "ANIMATION_ATLAS", 
    path = "unik_blindside_facile.png", 
    px = 34, 
    py = 34, 
frames = 21 })

BLINDSIDE.Joker({
    key = 'unik_blindside_facile',
    atlas = 'unik_blindside_facile',
    pos = {x=0, y=0},
    boss_colour = HEX("36CDBE"),
    mult = 25,
    base_dollars = 16,
    order = 999999,
    boss = {min = 1,showdown = true,exotic = true},
    active = true,
    in_pool = function(self, args)
        return UNIK.hasBlindside() and CanSpawnExotic()
    end,
    debuff = {
        akyrs_blind_difficulty = "unik_blindside_exotic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
    glitchy_anim = {min = 0, max = 5},
    death_card = {
        card = 'j_cry_facile' and (SMODS.Mods["Cryptid"] or {}).can_load or 'j_unik_blindside_facile_cry', 
        mod_card = function(self, card) --used to apply editions and/or stickers
            
        end,
        quotes = {'unik_blindside_facile_lose'},
        say_times = 6,
    },
    loc_vars = function(self,blind)
        return { vars = { 1.75 } }
    end,
    collection_loc_vars = function(self)
        return { vars = { 1.75 } }
    end,
    calculate = function(self, blind, context)
        
        if context.scoring_hand and context.individual and context.cardarea == G.play and not G.GAME.blind.disabled then
            if context.other_card.facing ~= 'back' then
                if G.GAME.unik_facile_count >= 10 then
                    return {
                        message = "^" ..  1.75 .. localize('k_unik_jmult'),
                        colour = G.C.BLACK,
                        focus = context.other_card,
                        func = function ()
                            
                            UNIK.blindside_chips_modifyV2({e_mult = 1.75})   
                            BLINDSIDE.change_fire_amount({amount = 13})
                            BLINDSIDE.add_fire()
                            G.E_MANAGER:add_event(Event({
                                func = (function()
                                G.GAME.blind:wiggle()
                                return true
                                end)
                            }))
                                            G.E_MANAGER:add_event(Event({
                                trigger = 'before',
                                delay = 0.8,
                                func = function ()
                                    return true
                                end
                            }))
                        end
                    }
                else
                    G.GAME.unik_facile_count = G.GAME.unik_facile_count or 0
                    G.GAME.unik_facile_count = G.GAME.unik_facile_count + 1
                    local num = G.GAME.unik_facile_count
                    return {
                        message = num .. "",
                        colour = G.C.BLACK,
                        focus = context.other_card,
                    }
                end
            end
            
            
        end
        if context.before then
            G.GAME.unik_facile_count = 0
        end
        if context.after then
            G.GAME.unik_facile_count = 0
        end
        
    end,
})