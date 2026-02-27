SMODS.Blind{
    key = 'unik_epic_cookie',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true,unskippable_ante = true},
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 9},
    boss_colour= HEX("633b11"), 
    dollars = 13,
    mult = 1,
    unik_exponent = {1,1},
    pronouns = "he_him",
    loc_vars = function(self, info_queue, card)
        local string = ""
        string = "" .. 1.005
		return { vars = { string } }
	end,
	collection_loc_vars = function(self)
        local string = ""
        string = "" .. 1.005
		return { vars = { string } }
	end,
    debuff = {
        akyrs_blind_difficulty = "unik_epic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
        unik_all_unskippable_blinds = true,
    },
    death_message = "special_lose_unik_epic_cookie",
    set_blind = function(self, reset, silent)
        if not reset then
            local text = localize('k_unik_epic_cookie_start')
            attention_text({
                scale = 0.9, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = HEX("633b11")
            })
            G.GAME.decrementer_hand = 0
            G.GAME.epic_cookie_click_interval = 0
        end
    end,
	in_pool = function(self)
        return  CanSpawnEpic()
	end,
    disable = function(self)
        G.GAME.epic_cookie_click_interval = -1
        G.hand:change_size(G.GAME.decrementer_hand)
        G.GAME.decrementer_hand = 0
    end,
    defeat = function(self)
        G.GAME.epic_cookie_click_interval = -1
        G.hand:change_size(G.GAME.decrementer_hand)
        G.GAME.decrementer_hand = 0
    end,
    increment_in_ante = {1,1.005},
    increment_by_click = true,
    unik_clicky_click_mod = function(self,prevent_rep)

        G.GAME.blind.chips = G.GAME.blind.chips^1.005
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        G.HUD_blind:recalculate(true)
        G.hand_text_area.blind_chips:juice_up()
        G.GAME.blind.triggered = true
        G.GAME.blind:wiggle()
        play_sound('chips2')
        G.ROOM.jiggle = G.ROOM.jiggle + 0.5


        if G.GAME.epic_cookie_click_interval >= 0 then
            G.GAME.epic_cookie_click_interval = G.GAME.epic_cookie_click_interval + 1
        end
        G.GAME.blind.triggered = true
        G.GAME.blind:wiggle()
        G.hand_text_area.blind_chips:juice_up()
        play_sound('chips2')
        G.ROOM.jiggle = G.ROOM.jiggle + 0.5
        --destroy a random card in hand. Make sure it's not eternal
        local validCards = {}
        local selectedDest1 = nil
        if G.hand then
            for i,v in pairs(G.hand.cards) do
                if (not SMODS.is_eternal(v, self)) and (not v.ability.set_for_destruction) then
                    validCards[#validCards + 1] = v
                end
            end
        end
        if G.hand and #validCards > 0 then 
            selectedDest1 = pseudorandom_element(validCards, pseudoseed("unik_epic_cookie_destroy1"))
            selectedDest1.ability.set_for_destruction = true
        end

        --destroy listed cards
        if selectedDest1 ~= nil then
            --this repeats for some reason...
            selfDestruction_noMessage(selectedDest1,true)
            --print("boom")
        end


        --decrease hand size by 1 
        if G.GAME.epic_cookie_click_interval % 8 == 0 and G.hand.config.card_limit > 0 then
            G.GAME.decrementer_hand = G.GAME.decrementer_hand + 1
            G.hand:change_size(-1)
        end
    end,
}

--Add context for Just before cards are played


--As playing a hand is one_click, it means if lets say a card being played just happened to be disabled, then

