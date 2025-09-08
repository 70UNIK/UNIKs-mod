--Megatron:
--X2 Mult when a probability fails. Destroy a random Joker whenever a probability succeeds, otherwise ^1.05 Blind Size if it cannot destroy a joker.
SMODS.Atlas {
	key = "unik_megatron",
	path = "unik_megatron.png",
	px = 71,
	py = 95
}
local megatron_quotes = {
	normal = {
		'k_unik_megatron1',
		'k_unik_megatron2',
        'k_unik_megatron3',
        'k_unik_megatron4',
	},
	-- drama = {
	-- 	'k_unik_pibby_scared1',
	-- 	'k_unik_pibby_scared2',
	-- },
	-- darkness = {
	-- 	'k_unik_pibby_darkness1',
	-- 	'k_unik_pibby_darkness2',
	-- }
}
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_megatron',
	rarity = 4,
	atlas = 'unik_megatron',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	cost = 20,
	blueprint_compat = true,
	perishable_compat = false,
	demicoloncompat = true,
	eternal_compat = true,
	config = {extra = {x_mult = 2, scoring = false},immutable = {blind_size = 1.15}},
	loc_vars = function(self, info_queue, center)
        local quoteset = 'normal'
		return {
			vars = {center.ability.extra.x_mult,center.ability.immutable.blind_size,localize(megatron_quotes[quoteset][math.random(#megatron_quotes[quoteset])] .. "")}
		}
	end,
    add_to_deck = function(self,card,from_debuff)
        card.ability.eternal = true
        card.ability.absolute = true
    end,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
    calculate = function(self, card, context)
        if context.pseudorandom_result and context.result and not context.blueprint and not context.retrigger_joker and not card.ability.immutable.destroyed then
            --destroy a joker in rage
            local validJokers = {}
            for i,v in pairs(G.jokers.cards) do
                if not SMODS.is_eternal(v,self) and not v.ability.destroyed_by_megatron then
                    validJokers[#validJokers+1] = v
                end
            end
            if #validJokers >= 1 then
                local select = pseudorandom_element(validJokers, pseudoseed("unik_megatron_rage"))
                    G.E_MANAGER:add_event(Event({
                        trigger="immediate",
                        func = function()
                        select.ability.destroyed_by_megatron = true
                        select:gore6_break()
                    return true end }))
                return {
                        message = localize("k_unik_megatron_rage" .. math.random(1,4)),
                        colour = G.C.UNIK_VOID_COLOR,
                        card = card
                    }
            else
                if G.GAME.blind then
                    G.E_MANAGER:add_event(Event({func = function()
                        G.GAME.blind.chips = G.GAME.blind.chips^card.ability.immutable.blind_size
                        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                        G.HUD_blind:recalculate(true)
                        G.hand_text_area.blind_chips:juice_up()
                        play_sound('chips2')
                    return true end }))
                    return {
                        message = localize({
                            type = "variable",
                            key = "a_eblindsize",
                            vars = {
                                number_format(to_big(card.ability.immutable.blind_size)),
                            },
                        }),
                        colour = G.C.UNIK_VOID_COLOR,
                        card = card
                    }
                end
            end
            
        end
        if context.pseudorandom_result and not context.result and card.ability.extra.scoring then
            return {
                x_mult = card.ability.extra.x_mult,
                card = card,
            }
        end
        if context.before and not context.blueprint_card and not context.retrigger_joker  then
			card.ability.extra.scoring = true
		end
        if context.after and not context.blueprint_card and not context.retrigger_joker then
			card.ability.extra.scoring = false
		end

	end,
    in_pool = function()
		return false
	end,
}