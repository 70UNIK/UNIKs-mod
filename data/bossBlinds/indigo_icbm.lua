--It used to instakill the player if score is 3x requirements
--Now it has the old poppy functionality: If hand exceeds 3x requrements, hand will not score. It should only appear if you score above ^1.5 requirements 3 times in a run, so it's like a warning for high scorers
SMODS.Blind{
    key = 'unik_indigo_icbm',
    config = {},
    boss = {min = 1, showdown = true}, 
    atlas = "unik_showdown_blinds",
    pos = { x = 0, y = 1},
    boss_colour= HEX("250088"),
    dollars = 8,
    mult = 1,
    loc_vars = function(self, info_queue, card)
		return { vars = { 3 * get_blind_amount(G.GAME.round_resets.ante) * 1 * G.GAME.starting_params.ante_scaling } } -- no bignum?
	end,
	collection_loc_vars = function(self)
		return { vars = { localize("k_unik_nuke_placeholder") } }
	end,
    death_message = 'special_lose_unik_get_nuked',
    in_pool = function()
        -- only appear if player scores above ^1.5 reqs 6 times consecutively
        G.GAME.unik_overshoot = G.GAME.unik_overshoot or 0
        if G.GAME.unik_overshoot then
            --print(G.GAME.unik_scores_really_big)
            if G.GAME.unik_overshoot >= 3 then
                return true
            end
        end
        --when overshoot is disabled, this should still appear
        if unik_config.unik_overshoot_level < 2 then
            G.GAME.indigo_icbm_backup = G.GAME.indigo_icbm_backup or 0
            if G.GAME.indigo_icbm_backup > 3 then
                return true
            end
        end

        return false
    end,
    set_blind = function(self, reset, silent)
        local text = localize('k_unik_nuke_start')
        attention_text({
            scale = 1, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
        })
        G.GAME.unik_nuke_ceil = true
	end,
    disable = function(self)
		G.GAME.unik_nuke_ceil = nil
	end,
	defeat = function(self)
		G.GAME.unik_nuke_ceil = nil
	end,
    --Debuff_after_hand:
    --Return statement:
    -- {debuff = true [true = hand will not score], add_to_blind = floatX will be added to blind size}
    
    unik_debuff_after_hand = function(self,poker_hands, scoring_hand,cards, check,sum)
        if to_big(sum) > to_big(G.GAME.blind.chips * 3) then
            return {
                debuff = true,
            }
        end
        return {
            debuff = false,
        }
    end,
}

