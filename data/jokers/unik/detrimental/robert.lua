--Robert/The Wheel: 1 in 7 chance card is drawn face down. Self destructs after playing at least 5 scoring face down cards
SMODS.Atlas {
	key = "unik_robert",
	path = "unik_robert.png",
	px = 71,
	py = 95
}
SMODS.Joker{
	dependencies = {
		items = {
			"set_cry_cursed",
		},
	},
	-- How the code refers to the joker.
	key = 'unik_robert',
    atlas = 'unik_robert',
    rarity = 'unik_detrimental',
	no_dbl = true,
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
    cost = 0,
	blueprint_compat = false,
    perishable_compat = false,
	eternal_compat = false,
    immutable = true,
    config = { extra = { odds = 7, flipped_cards = false , min_facedowns = 5} },
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return { vars = { 
            new_numerator,
            new_denominator,
            card.ability.extra.min_facedowns,
        } }
    end,
    pools = { ["unik_boss_blind_joker"] = true},
    remove_from_deck = function(self, card, from_debuff)
        for i,v in pairs(G.playing_cards) do
            v.ability.unik_flipped_by_wheel = nil
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_unik_blind_start_wheel'), G.C.UNIK_THE_WHEEL, G.C.WHITE, 1.0 )
    end,
    calculate = function(self, card, context)
        if context.stay_flipped 
        and context.to_area == G.hand 
        and context.other_card 
        and not context.blueprint
        and not context.retrigger_joker
        and SMODS.pseudorandom_probability(card, 'unik_wheel', 1, card.ability.extra.odds) then
            card.ability.extra.flipped_cards = true
            context.other_card.ability.unik_flipped_by_wheel = true
            return {
                stay_flipped = true
            }
        end
        if context.before and context.scoring_hand 
        and not context.blueprint
        and not context.retrigger_joker
        then
            local facedowns = 0
            for i,v in pairs(context.scoring_hand) do
                if v.ability.unik_flipped_by_wheel then
                    facedowns = facedowns + 1
                    v.ability.unik_flipped_by_wheel = nil
                end
            end
            --print(facedowns)
            if facedowns >= card.ability.extra.min_facedowns then
                selfDestruction(card,"k_unik_wheel_burst",G.C.UNIK_THE_WHEEL)

            end
        end
        if context.setting_blind then
            for i,v in pairs(G.playing_cards) do
                v.ability.unik_flipped_by_wheel = nil
            end
        end
        if context.setting_blind and (G.GAME.blind and (G.GAME.blind.config.blind.name == "The Wheel")) and not (G.GAME.blind.disabled) and not context.blueprint
        and not context.retrigger_joker then
            selfDestruction(card,"k_unik_blind_start_wheel",G.C.UNIK_THE_WHEEL)
        end
    end,
}