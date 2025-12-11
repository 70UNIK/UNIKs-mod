--base chips and mult become 0.01, all additive operations become subtraction
SMODS.Blind	{
    key = 'unik_epic_straightforwardness',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = HEX("21306b"),
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 35},
    vars = {},
    dollars = 13,
    mult = 1,
    unik_exponent = {1,0.9},
    debuff = {
        akyrs_blind_difficulty = "unik_epic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
    set_blind = function(self, reset, silent)
        G.GAME.unik_epic_straightforwardness = true
	end,
    disable = function(self)
		G.GAME.unik_epic_straightforwardness = nil
	end,
	defeat = function(self)
		G.GAME.unik_epic_straightforwardness = nil
	end,
    modify_hand = function (self, cards, poker_hands, text, mult, hand_chips)
        return 0.01, 0.01, true
    end,
    in_pool = function(self)
        return  CanSpawnEpic()
	end,
}

local scie = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
    if G.GAME.unik_epic_straightforwardness then
        local triggered = false
        if (key == "chip" or key == "chips" or key == "h_chips" or key == "chip_mod" or key == "chips_mod") then
            amount = -math.abs(amount)
            triggered = true
        -- elseif (key == "mult" or key == "h_mult" or key == "mult_mod" or key == "multMod") then
        --     amount = -math.abs(amount)
        --     triggered = true
        end
        if triggered then
            G.E_MANAGER:add_event(Event({func = function()
                G.GAME.blind:wiggle()
                G.GAME.blind.triggered = true
            return true end }))
        end
    end
    local ret = scie(effect, scored_card, key, amount, from_edition)
    if ret then
        return ret
    end
end