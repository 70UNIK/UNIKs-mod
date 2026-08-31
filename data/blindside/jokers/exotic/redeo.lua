--+1 ante per $10 spent this ante, if less than $(this run) spend this ante, on blind select, ^2 ante
SMODS.Atlas({ 
    key = "unik_blindside_redeo", 
    atlas_table = "ANIMATION_ATLAS", 
    path = "unik_blindside_redeo.png", 
    px = 34, 
    py = 34, 
frames = 21 })
BLINDSIDE.Joker({
    key = 'unik_blindside_redeo',
    atlas = 'unik_blindside_redeo',
    pos = {x=0, y=0},
    boss_colour = HEX("605db4"),
    mult = 10,
    base_dollars = 16,
    order = 999999,
    boss = {min = -66,showdown = true,exotic = true},
    active = true,
    in_pool = function(self, args)
        return UNIK.hasBlindside() and CanSpawnExotic()
    end,
    track_ante_purchases = true,
    debuff = {
        akyrs_blind_difficulty = "unik_blindside_exotic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
    glitchy_anim = {min = 0, max = 5},
    death_card = {
        card = 'j_cry_redeo' and (SMODS.Mods["Cryptid"] or {}).can_load or 'j_unik_blindside_redeo_cry', 
        mod_card = function(self, card) --used to apply editions and/or stickers
            
        end,
        quotes = {'unik_blindside_redeo_lose'},
        say_times = 6,
    },
    loc_vars = function(self,blind)
        local money = G.GAME.global_spent_pause_val
        if not G.GAME.global_spent_pause_val or G.GAME.global_spent_pause_val^0.9 < 100 then
            money = 100
        end
        return { vars = { 1,20,money,2,G.GAME.unik_ante_spent } }
    end,
    collection_loc_vars = function(self)
        return { vars = { 1,20,localize("k_unik_redeo_placeholder"),2,0} }
    end,
    joker_set = function ()
        G.GAME.global_spent_pause_val = G.GAME.global_spent_pause_val or 0
        print(G.GAME.global_spent_pause_val)
        local requirement = math.max(G.GAME.global_spent_pause_val^0.9,100)
        print (G.GAME.unik_ante_spent .. " " .. requirement)
        G.GAME.unik_old_ante = G.GAME.round_resets.ante
        if G.GAME.unik_ante_spent < requirement then
            local difference = G.GAME.round_resets.ante^2 - G.GAME.round_resets.ante
            ease_ante(difference)
            G.GAME.blind:wiggle()
            BLINDSIDE.change_fire_amount({amount = 10})
            BLINDSIDE.add_fire(difference)
            
        else
            local difference = math.floor(G.GAME.unik_ante_spent/25)
            ease_ante(difference)
            G.GAME.blind:wiggle()
            BLINDSIDE.change_fire_amount({amount = 10})
            BLINDSIDE.add_fire(difference)
            
        end
         G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
                G.GAME.blind.basechips = math.max(1,get_blind_amount(G.GAME.round_resets.ante)*G.GAME.starting_params.ante_scaling)
                G.GAME.blind.basechips_text = number_format(to_big(G.GAME.blind.basechips), 100000)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                BLINDSIDE.chipsupdate()
            return true end }))
            return true end }))
        
    end,

})