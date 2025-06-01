--+5 Hand Size, Add polychrome steel kings equal to 3x the cards in deck. If a steel card is held or a polychrome card is played, die.
--Basically Magnet + EpicFish = horrible.
--Cannot be skipped or disabled by any means.
SMODS.Atlas({ 
    key = "unik_legendary_magnet", 
    atlas_table = "ANIMATION_ATLAS", 
    path = "unik_legendary_magnet.png", 
    px = 34, 
    py = 34, 
frames = 21 })
SMODS.Blind{
    key = 'unik_legendary_magnet',
    config = {},
    boss = {min = 1,legendary = true, showdown = true,no_orb = true}, 
    atlas = "unik_legendary_magnet",
    pos = {x=0, y=0},
    boss_colour= HEX("5c0007"), --all legendary blinds will be blood red and black.
    dollars = 13,
    mult = 0.666,
    glitchy_anim = true,
    gameset_config = {
		modest = { disabled = true},
	},
    jen_blind_resize = 1e16,
    ignore_showdown_check = true,
	set_blind = function(self)
        G.GAME.unik_pentagram_manager_fix = true
		G.GAME.unik_killed_by_magnet_legendary = true
        --G.GAME.unik_deathly_debuff_text = true --instead of "Hand will not score", it will say, YOU WILL DIE. And if blind is triggered, you will die.

        --Get all unenhanced cards
		if not reset then
            local text = localize('k_unik_magnet_legendary_start')
            attention_text({
                scale = 0.75, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = G.C.UNIK_EYE_SEARING_RED
            })
			for i = 1, #G.playing_cards * 3 do
				G.E_MANAGER:add_event(Event({
					delay = 0.1,
					func = function()
                        local _suit, _rank = nil, nil
                        _rank = 'K'
                        _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('grim_create'))
						G.playing_card = (G.playing_card and G.playing_card + 1) or 1
						local card = Card(G.play.T.x + G.play.T.w/2, G.play.T.y, G.CARD_W, G.CARD_H, 
                        G.P_CARDS[_suit..'_'.._rank], 
                        G.P_CENTERS.m_steel, 
                        {playing_card = G.playing_card})
                        card:set_seal('Red',nil, true)
                        --only niko if not jens mod (for balance),
                        if not (SMODS.Mods["jen"] or {}).can_load then
                            card.ability.unik_niko = true
                        end
                         --Avoid permanent damage and lag
                         G.GAME.force_bypass_edition_delay = true
                        card:set_edition({ unik_steel = true }, nil, nil, true) --too long
                        G.GAME.force_bypass_edition_delay = nil
						if math.floor(i/2) ~= i then play_sound('card1') end
						table.insert(G.playing_cards, card)
						G.deck:emplace(card)
                        playing_card_joker_effects({true})
                        G.GAME.blind.triggered = true
                        G.GAME.blind:wiggle()
						return true
					end
				}))
			end

        end
            
        G.hand:change_size(6)
	end,
    --Only appear if over round 120 or "legendary_hell_blinds" are enabled (they can spawn ANY TIME)
    in_pool = function()
        return CanSpawnLegendary()
    end,
    get_loc_debuff_text = function(self)
		return localize("k_unik_magnet_legendary_warning")
	end,
    --debuff hand if a steel card is held in hand and unselected
    debuff_hand = function(self, cards, hand, handname, check)
        --during initial selection
        if check then
            local goldenAlloy = false
            local steels = 0
            local steelsPlayed = 0
            -- local polychromes = 0
            --If alloy (extra credit) is present, treat GOLD cards as steel cards as well!
            for _, v in pairs(G.jokers.cards) do
                if v.config.center.key == "j_ExtraCredit_alloy" then
                    goldenAlloy =true
                end
            end
            for k, v in pairs(G.hand.cards) do
                if v.config.center == G.P_CENTERS.m_steel or (goldenAlloy == true and v.config.center == G.P_CENTERS.m_gold) then
                    steels = steels + 1
                end
            end
            for k, v in ipairs(cards) do
                if v.config.center == G.P_CENTERS.m_steel or (goldenAlloy == true and v.config.center == G.P_CENTERS.m_gold) then
                    steelsPlayed = steelsPlayed + 1
                end
            end
            -- for k, v in ipairs(cards) do
            --     if v.edition then
            --         if v.edition.key == "e_polychrome" then
            --             polychromes = polychromes + 1
            --         end
            --     end
            -- end
            if steels > 0 or steelsPlayed > 0 then
                G.GAME.blind.triggered = true
                return true
            else
                return false
            end
        else
            local goldenAlloy = false
            local steels = 0
            -- local polychromes = 0
            --If alloy (extra credit) is present, treat GOLD cards as steel cards as well!
            for _, v in pairs(G.jokers.cards) do
                if v.config.center.key == "j_ExtraCredit_alloy" then
                    goldenAlloy =true
                end
            end
            for k, v in pairs(G.hand.cards) do
                if v.config.center == G.P_CENTERS.m_steel or (goldenAlloy == true and v.config.center == G.P_CENTERS.m_gold) then
                    steels = steels + 1
                end
            end
            for k, v in ipairs(cards) do
                if v.config.center == G.P_CENTERS.m_steel or (goldenAlloy == true and v.config.center == G.P_CENTERS.m_gold) then
                    steels = steels + 1
                end
            end

            
            if steels > 0 then
                G.GAME.blind.triggered = true
                return true
            else
                return false
            end
        end
	end,
	disable = function(self)
        --avoid chicot permanently depleting hand size to 0 by only triggering if the killed by magnet flag is true
        if not G.GAME.blind.disabled then
            if G.GAME.unik_killed_by_magnet_legendary then
                G.hand:change_size(-6)
            end
            G.GAME.unik_killed_by_magnet_legendary = nil
           -- G.GAME.unik_deathly_debuff_text = nil
            G.GAME.unik_pentagram_manager_fix = nil
        end
	end,
	defeat = function(self)
        if not G.GAME.blind.disabled then
            if G.GAME.unik_killed_by_magnet_legendary then
                G.hand:change_size(-6)
            end
            G.GAME.unik_killed_by_magnet_legendary = nil
       --     G.GAME.unik_deathly_debuff_text = nil
            G.GAME.unik_pentagram_manager_fix = nil
        end
	end,
}



--Hooks taken from Jen's for Epic Blinds
local disblref2 = Blind.disable

function Blind:disable()
	local obj = self.config.blind
	if obj then
		if obj.boss.legendary then
			play_sound('cancel', 0.7 + 0.05, 0.7)
            local text = localize('k_unik_boss_immune')
            attention_text({
                scale = 1.0, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = G.C.UNIK_EYE_SEARING_RED
            })
            G.ROOM.jiggle = G.ROOM.jiggle + 7
			G.GAME.blind:wiggle()
			return true
        elseif obj.boss.epic then
            play_sound('cancel', 0.8, 1)
            local text = 'Blind is immune!'
            attention_text({
                scale = 0.9, text = text, hold = 0.75, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = obj.boss_colour or G.C.RED
            })
			G.GAME.blind:wiggle()
			return true
		end
	end
	return disblref2(self)
end

local gfrb2 = G.FUNCS.reroll_boss
G.FUNCS.reroll_boss = function(e)
	local obj = G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss]
	if obj.boss.legendary then
		play_sound('cancel', 0.7 + 0.05, 0.7)
        local text = localize('k_unik_boss_reroll_nope')
        attention_text({
            scale = 0.9, text = text, hold = 0.75, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = G.C.UNIK_EYE_SEARING_RED
        })
        G.ROOM.jiggle = G.ROOM.jiggle + 1.5
		--jl.a(localize('k_nope_ex'), G.SETTINGS.GAMESPEED * 2, 0.8, G.C.RED)
    elseif obj.boss.epic and not (SMODS.Mods["jen"] or {}).can_load then
        play_sound('cancel', 0.8, 1)
        local text = localize('k_nope_ex')
        attention_text({
            scale = 0.9, text = text, hold = 0.75, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = obj.boss_colour or G.C.RED
        })
	else
		return gfrb2(e)
	end
end
