--hand size set to 1, bet and pair is not allowed
--you're forced to utilise tech blinds, hiss tags, auto handsize blinds such as epic bellows and the dragon
--^2.5 mult to joker per blind scored after the 10th scored blind
SMODS.Atlas({ 
    key = "unik_blindside_effarcire", 
    atlas_table = "ANIMATION_ATLAS", 
    path = "unik_blindside_effarcire.png", 
    px = 34, 
    py = 34, 
frames = 21 })

BLINDSIDE.Joker({
    key = 'unik_blindside_effarcire',
    atlas = 'unik_blindside_effarcire',
    pos = {x=0, y=0},
    boss_colour = HEX("e235a0"),
    mult = 10,
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
        card = 'j_cry_effarcire' and (SMODS.Mods["Cryptid"] or {}).can_load or 'j_unik_blindside_effarcire_cry', 
        mod_card = function(self, card) --used to apply editions and/or stickers
            
        end,
        quotes = {'unik_blindside_effarcire_lose'},
        say_times = 6,
    },
    get_loc_debuff_text = function(self)
        return localize("k_unik_no_bet_pair")
		
	end,
    loc_vars = function(self,blind)
        return { vars = { 3 } }
    end,
    collection_loc_vars = function(self)
        return { vars = { 3 } }
    end,
    debuff_hand = function(self, cards, hand, handname, check)
        print(handname)
        if handname == 'bld_blind_high' or handname == 'bld_blind_2oak' then
            if not check then
                BLINDSIDE.change_fire_amount({amount = 12})
                BLINDSIDE.add_fire()
            end
            return true
        end
        return false
    end,
    joker_set = function ()
        G.GAME.unik_original_hand_size = G.hand.config.card_limit
        G.hand:change_size(-G.hand.config.card_limit + 1)
    end,
    joker_defeat = function()
        G.hand:change_size(-G.hand.config.card_limit + G.GAME.unik_original_hand_size + (G.hand.config.card_limit - 1))
    end,
})