--+1

BLINDSIDE.Joker({
    key = 'unik_blindside_fat_joker',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=10},
    boss_colour = HEX('DA2954'),
    mult = 10,
    base_dollars = 8, --hahahahahahahahahahhaaa
    order = 1,
    boss = {min = 1},
    active = true,
    death_card = {
        card = 'j_unik_fat_joker', 
        mod_card = function(self, card) --used to apply editions and/or stickers
            
        end,
        quotes = {'unik_blindside_fat_joker_lose'},
        say_times = 15,
    },
    blindside_joker = true,
     loc_vars = function (self)
        local mult = 1.5
        local interval = 2
        local final = 0
        if G.playing_cards and G.GAME.starting_deck_size then
            final = math.max(0,math.ceil((math.ceil(#G.playing_cards) - math.ceil(G.GAME.starting_deck_size/2))/interval) * mult)
        end
        return {
            vars = {
                mult,interval,math.ceil((G.GAME.starting_deck_size or 1)/2),final
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                1.5,2,localize('k_unik_fat_joker_placeholder'),0
            }
        }
    end,
    joker_set = function ()
        local times = 0
        local mult = 1.5
        if G.playing_cards and G.GAME.starting_deck_size then
            times = math.max(0,math.ceil((math.ceil(#G.playing_cards) - math.ceil(G.GAME.starting_deck_size/2))/2))
        end
        
        if times > 0 then
            G.GAME.playing_with_fire_num = G.GAME.playing_with_fire_num + times
            G.GAME.playing_with_fire = G.GAME.playing_with_fire + (G.GAME.used_vouchers.v_bld_swearjar and 2 or 1) * times
            G.GAME.playing_with_fire_each = G.GAME.used_vouchers.v_bld_swearjar and "bld_playing_with_fire_each_3" or "bld_playing_with_fire_each_2"
            BLINDSIDE.chipsmodify(times * mult, 0, 0)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                BLINDSIDE.chipsupdate()
            return true end }))
        end
    end,
})