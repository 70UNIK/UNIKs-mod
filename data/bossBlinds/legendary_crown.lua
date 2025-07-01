--LEGENDARY CROWN
--Blind size = Highest score
--Defeat this blind, [Number of hands] times
--Set hands to 1, only replenish if defeated blind (otherwise set to -6666, to counter hunter)
--As for if deck is replenished, it WILL NOT be replenished, it just immediately sets score to 0 then displays disabled text
--After each defeat, rescale to highest score x 1.25 (^1.01 in almanac)
--If hands = 1, blind size is increased by ^6.666 (^^6.666 in almanac)
--To survive, joker rearrangement, scaling jokers or in almanac, amalgamate or hydrea is the way to survive (as well as high consistent scoring and keeping an eye on the highest score)
SMODS.Atlas({ 
    key = "unik_legendary_crown", 
    atlas_table = "ANIMATION_ATLAS", 
    path = "unik_legendary_crown.png", 
    px = 34, 
    py = 34, 
frames = 21 })
SMODS.Blind{
    key = 'unik_legendary_crown',
    config = {},
    boss = {min = 1,legendary = true,showdown = true, no_orb = true, hardcore = true}, 
    atlas = "unik_legendary_crown",
    pos = {x=0, y=0}, --This could shift with glitch FX (may use dandy code for this)
    boss_colour= HEX("e0bc42"),
    dollars = 13,
    gameset_config = {
		modest = { disabled = true},
	},
    debuff = {
        akyrs_blind_difficulty = "legendary",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_unskippable_blind = true,
    },
    mult = 1,
    glitchy_anim = true,
    death_message = "special_lose_unik_legendary_crown",
    get_loc_debuff_text = function(self)
		return localize("k_unik_legendary_crown_defeat_x_times1") .. (G.GAME.unik_crown_progress or G.GAME.round_resets.hands) .. localize("k_unik_legendary_crown_defeat_x_times2")
	end,
    high_score_size = true, --force high score
    ignore_showdown_check = true,
    loc_vars = function(self)
        local exponent1 = "x1.5"
        local exponent2 = "^6.666"
		return { vars = { (G.GAME.unik_crown_progress or G.GAME.round_resets.hands), (G.GAME.unik_crown_progress or G.GAME.round_resets.hands) == 1 and '' or 's', exponent1,exponent2 } } -- no bignum?
	end,
	collection_loc_vars = function(self)
        local exponent1 = "x1.5"
        local exponent2 = "^6.666"
		return { vars = { localize('k_unik_legendary_crown_placeholder'), 's', exponent1,exponent2} } -- no bignum?
	end,
    set_blind = function(self, reset, silent)
        if not reset then
            local text = localize('k_unik_legendary_crown_start')
            attention_text({
                scale = 1, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = G.C.UNIK_EYE_SEARING_RED
            })
            G.GAME.unik_crown_progress = G.GAME.round_resets.hands
            if G.GAME.round_resets.hands == 1 then
                G.GAME.blind.chips = G.GAME.round_scores['hand'].amt^6.666
            end
            G.GAME.blind.hands_sub = G.GAME.round_resets.hands - 1
            ease_hands_played(-G.GAME.blind.hands_sub)
            
        end

	end,
    in_pool = function()
        return CanSpawnLegendary()
    end,
    --no fucking around this time
    cry_after_play = function(self)
        ease_hands_played(-G.GAME.current_round.hands_left)
        ease_hands_played(-666)
	end,
    --i wont bother programming in a disable function since its not menant to be dsiabled
    disable = function(self)

	end,
	defeat = function(self)
        G.GAME.unik_crown_progress = nil

	end,
}