--set all statistics of played hand to 0
--gains Xmult equal to total mult lost
BLINDSIDE.Joker({
    key = 'unik_blindside_moonlight_cookie',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=1},
    boss_colour = HEX("0035a4"),
    mult = 35,
    base_dollars = 16,
    order = 999999,
    boss = {min = -66,showdown = true,ancient = true},
    active = true,
    in_pool = function(self, args)
        return UNIK.hasBlindside() and CanSpawnAncient()
    end,
    loc_vars = function(self,blind)
        G.GAME.unik_blind_xmult = G.GAME.unik_blind_xmult or 1
        return { vars = { G.GAME.unik_blind_xmult } }
    end,
    collection_loc_vars = function(self)
        return { vars = { 1 .. ""} }
    end,
    debuff = {
        akyrs_blind_difficulty = "unik_blindside_ancient",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
    death_card = {
        card = 'j_unik_moonlight_cookie', 
        mod_card = function(self, card) --used to apply editions and/or stickers
            
        end,
        quotes = {'unik_blindside_moonlight_lose1','unik_blindside_moonlight_lose2'},
        say_times = 6,
    },
    joker_set = function ()
        G.GAME.unik_blind_xmult = 1
        G.GAME.unik_dynamic_text_realtime = true

        G.GAME.blind:wiggle()
            
        for k, v in ipairs(G.handlist) do
            if G.GAME.hands[v].visible then
                update_hand_text(
                    {sound = 'button', volume = 0.7, pitch = 1.1, delay = 0.2}, 
                    {mult = G.GAME.hands[v].mult, chips = G.GAME.hands[v].chips, handname = localize(v, 'poker_hands'), level = G.GAME.hands[v].level}
                )
                delay(0.5)
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    func = function()
                        play_sound("multhit2",0.95,1)
                        G.GAME.blind.children.animatedSprite:juice_up(0.8, 0.5)
                         G.GAME.unik_blind_xmult = G.GAME.unik_blind_xmult + G.GAME.hands[v].mult
                        G.GAME.blind:wiggle()
                        BLINDSIDE.change_fire_amount({amount = 8})
                        BLINDSIDE.add_fire()
                        return true
                    end,
                }))
            end
        end
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                update_hand_text(
				{ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
				{ handname = localize("k_all_hands"), chips = "...", mult = "...", level = "" }
			)
            delay(1.3)
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    play_sound("tarot1")
                    G.GAME.blind.children.animatedSprite:juice_up(0.8, 0.5)
                    G.ROOM.jiggle = G.ROOM.jiggle + 3
                    G.TAROT_INTERRUPT_PULSE = true
                    return true
                end,
            }))
            delay(1.3)
            update_hand_text({ delay = 0 }, { mult = "=0", StatusText = true, forceRed = true })
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.9,
                func = function()
                    play_sound("tarot1")
                    G.GAME.blind.children.animatedSprite:juice_up(0.8, 0.5)
                    G.ROOM.jiggle = G.ROOM.jiggle + 3
                    return true
                end,
            }))
            delay(1.3)
            update_hand_text({ delay = 0 }, { chips = "=0", StatusText = true, forceRed = true})
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.9,
                func = function()
                    play_sound("tarot1")
                    G.GAME.blind.children.animatedSprite:juice_up(0.8, 0.5)
                    G.ROOM.jiggle = G.ROOM.jiggle + 3
                    G.TAROT_INTERRUPT_PULSE = nil
                    return true
                end,
            }))
            update_hand_text({ sound = "button", volume = 1.0, pitch = 0.8, delay = 0 }, { level = "=0" })
            delay(1.3)
            if G.GAME.hands then
                for i,v in ipairs(G.handlist) do
                    G.GAME.hands[v].level = 0
                    G.GAME.hands[v].chips = 0 --ALWAYS NEGATIVE!
                    G.GAME.hands[v].mult = 0 
                end
            end
            update_hand_text(
                { sound = "button", volume = 1.0, pitch = 0.8, delay = 0 },
                { mult = 0, chips = 0, handname = "", level = "" }
            )
            return true end })) 

    end,
    calculate = function(self, blind, context)
         if (context.after) and not G.GAME.blind.disabled then
            G.GAME.unik_dynamic_text_realtime = true
            G.GAME.unik_blind_xmult = G.GAME.unik_blind_xmult or 1
            G.HUD_blind:recalculate(true)
            if G.GAME.unik_blind_xmult > 1 then
                BLINDSIDE.chipsmodifyV2({x_mult = G.GAME.unik_blind_xmult})   
                BLINDSIDE.change_fire_amount({amount = 8})
                BLINDSIDE.add_fire()
            end
           G.GAME.blind:set_text()
            
        end
    end,
    disable = function(self)
        G.GAME.unik_blind_xmult = 1
        G.GAME.unik_dynamic_text_realtime = nil
    end,
    joker_defeat = function()
        G.GAME.unik_blind_xmult = 1
        G.GAME.unik_dynamic_text_realtime = nil
    end
})