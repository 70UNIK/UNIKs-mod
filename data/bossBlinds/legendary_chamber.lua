--Score capped at 1/(joker rarities owned) blind size.
--Scoring ranks must be a multiple of (joker rarities owned).
--Multiply ante by (joker rarities owned) and rescale blind size per hand.
--(Currently #1#)

SMODS.Atlas({ 
    key = "unik_legendary_chamber", 
    atlas_table = "ANIMATION_ATLAS", 
    path = "unik_legendary_chamber.png", 
    px = 34, 
    py = 34, 
frames = 21 })
SMODS.Blind{
    key = 'unik_legendary_chamber',
    config = {},
    boss = {min = 1,legendary = true,showdown = true,no_orb = true}, 
    atlas = "unik_legendary_chamber",
    pos = {x=0, y=0},
    boss_colour= HEX("9bc117"),
    dollars = 13,
    mult = 0.1,
    glitchy_anim = true,
    debuff = {
        akyrs_blind_difficulty = "legendary",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
    death_message = "special_lose_torture_chamber",
    ignore_showdown_check = true,
    loc_vars = function(self, info_queue, card)
        local count = jokerRaritiesCount()
        if not G.GAME.unik_blind_hands then
            return { vars = { count,count } } -- no bignum?
        end
		return { vars = { count,G.GAME.unik_blind_hands } } -- no bignum?
	end,
	collection_loc_vars = function(self)
		return { vars = { localize("k_unik_chamber_placeholder"),localize("k_unik_chamber_placeholder2") } }
	end,
    get_loc_debuff_text = function(self)
		return localize("k_unik_chamber_warning1") .. G.GAME.unik_blind_hands .. localize("k_unik_chamber_warning2")
	end,
    in_pool = function()
        return CanSpawnLegendary()
    end,
    set_blind = function(self, reset, silent)
        G.GAME.unik_blind_hands = jokerRaritiesCount()
        G.GAME.unik_dynamic_text_realtime = true
        
	end,
    cry_before_play = function (self)
        G.GAME.unik_blind_extra_excess = G.GAME.unik_blind_extra_excess or 0
        local count = jokerRaritiesCount()
        if count > 1 then
            G.GAME.blind:wiggle()
            ease_ante(math.ceil(G.GAME.round_resets.ante*count^0.5) - G.GAME.round_resets.ante)
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.blind.chips = G.GAME.unik_blind_extra_excess + ((get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling)*0.1)
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    G.HUD_blind:recalculate(true)
                    G.GAME.blind:set_text()
                    G.hand_text_area.blind_chips:juice_up()
                    play_sound('chips2')
                    return true
                end
            }))
        end
    end,
    unik_debuff_after_hand = function(self,poker_hands, scoring_hand,cards, check,sum)
        if G.GAME.unik_blind_hands > 0 then
            G.GAME.unik_blind_hands = G.GAME.unik_blind_hands - 1
            G.GAME.unik_blind_extra_excess = sum
            return {
                debuff = true,
                add_to_blind = sum,
            }
        end
        
        return {
            debuff = false,
        }
    end,
    debuff_hand = function(self, cards, hand, handname, check)
        if check and G.GAME.unik_blind_hands > 0 then
            G.GAME.blind.triggered = true
            return true
        end
    end,
    disable = function(self)
		G.GAME.unik_dynamic_text_realtime = nil
        G.GAME.unik_blind_hands = nil
	end,
	defeat = function(self)
		G.GAME.unik_dynamic_text_realtime = nil
        G.GAME.unik_blind_hands = nil
	end,
}


function jokerRaritiesCount()
    if G.jokers and G.jokers.cards then
        local rarities = {}
        for i,v in pairs(G.jokers.cards) do
            if v.config.center.rarity then
                local alreadyExists = false
                for j = 1, #rarities do
                    if rarities[j] == v.config.center.rarity then
                        alreadyExists = true
                    end
                end
                if not alreadyExists then
                    rarities[#rarities+1] = v.config.center.rarity
                end
            end
        end
        return #rarities
    end
end