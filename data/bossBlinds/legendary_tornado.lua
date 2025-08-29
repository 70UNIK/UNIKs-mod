SMODS.Atlas({ 
    key = "unik_legendary_tornado", 
    atlas_table = "ANIMATION_ATLAS", 
    path = "unik_legendary_tornado.png", 
    px = 34, 
    py = 34, 
frames = 21 })

SMODS.Blind{
    key = 'unik_legendary_tornado',
    config = {},
    boss = {min = 1,legendary = true,showdown = true,no_orb = true}, 
    atlas = "unik_legendary_tornado",
    pos = {x=0, y=0},
    boss_colour= HEX("3dd9ca"), 
    dollars = 13,
    mult = 0.666,
    glitchy_anim = true,
    gameset_config = {
		modest = { disabled = true},
	},
    debuff = {
        akyrs_blind_difficulty = "legendary",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
    loc_vars = function(self)
        local discards = 1
        if G.GAME.current_round.discards_left then
            discards = G.GAME.current_round.discards_left
        end
		return { vars = { discards .. "" } }
	end,
    collection_loc_vars = function(self)
		return { vars = { localize("k_unik_tornado_placeholder") } }
	end,
    get_loc_debuff_text = function(self)
		return localize("k_unik_leg_tornado_warn_1") .. (G.GAME.current_round.discards_left) .. localize("k_unik_leg_tornado_warn_2")
	end,
    ignore_showdown_check = true,
    set_blind = function(self, reset, silent)
		if not reset then
             G.GAME.unik_dynamic_text_realtime = true
		end
	end,
    in_pool = function()
        return CanSpawnLegendary()
    end,
    stay_flipped = function(self, area, card)
        if not card.ability.unik_tornado_already_drawn then
            card.ability.unik_valid_tornado_card = #G.deck.cards
            card.ability.unik_tornado_already_drawn = true
        end

        return false
	end,
	debuff_hand = function(self, cards, hand, handname, check)
        if next(hand["cry_None"]) then	
            G.GAME.blind.triggered = true
			return true
		end
        for g,w in ipairs(cards) do
            if (not w.ability.unik_valid_tornado_card) or (w.ability.unik_valid_tornado_card >= G.GAME.current_round.discards_left) then
                for i,v in pairs(G.hand.cards) do
                    if v.ability.unik_valid_tornado_card < G.GAME.current_round.discards_left then
                        v:juice_up(0.2,0.5)
                    end
                end
              --  print(w.ability.unik_valid_tornado_card)
                G.GAME.blind.triggered = true
                return true
            else
              --  print(w.ability.unik_valid_tornado_card)
            end
        end
       -- print("UH OH!")
        return false
	end,
    disable = function(self)
        for i,v in pairs(G.playing_cards) do
            if  v.ability.unik_valid_tornado_card then
                 v.ability.unik_valid_tornado_card = nil
            end
            if  v.ability.unik_tornado_already_drawn then
                 v.ability.unik_tornado_already_drawn = nil
            end
        end
         G.GAME.unik_dynamic_text_realtime = nil
    end,
    defeat = function(self)
        for i,v in pairs(G.playing_cards) do
            if  v.ability.unik_valid_tornado_card then
                 v.ability.unik_valid_tornado_card = nil
            end
            if  v.ability.unik_tornado_already_drawn then
                 v.ability.unik_tornado_already_drawn = nil
            end
        end
         G.GAME.unik_dynamic_text_realtime = nil
    end,
}