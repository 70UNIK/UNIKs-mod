SMODS.Atlas {
	key = "unik_moonlight",
	path = "unik_moonlight_cookie.png",
	px = 71,
	py = 95
}
SMODS.Joker {
	key = 'unik_moonlight_cookie',
    atlas = 'unik_moonlight',
    rarity = "cry_exotic",
	pos = { x = 0, y = 0 },
	-- soul_pos sets the soul sprite, used for legendary jokers and basically all of Jen's Jokers
	soul_pos = { x = 1, y = 0 },
    cost = 50,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    --Emult is 1.4 instead of 1.25 because of the limited consumable slots and the limited opportunities (azure seal, perkeo, digital hallucinations) for expanding them. Also 1.25 does not work well with multiply.
	-- I can imagine this will become souped up in almanac with it's 10 slots.
    config = { extra = { Emult = 1.3} },
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.Emult , center.ability.extra.consumeSlot} }
	end,
    pools = { ["unik_cookie_run"] = true, ["unik_copyrighted"] = true },
    -- add_to_deck = function(self, card, from_debuff)
	-- 	-- Changes a G.GAME variable, which is usually a global value that's specific to the current run.
	-- 	-- These are initialized in game.lua under the Game:init_game_object() function, and you can look through them to get an idea of the things you can change.
	-- 	G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.consumeSlot
	-- end,
	-- -- Inverse of above function.
	-- remove_from_deck = function(self, card, from_debuff)
	-- 	-- Adds - instead of +, so they get subtracted when this card is removed.
	-- 	G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.consumeSlot
	-- end,
    calculate = function(self, card, context)
		--Known issue: does not work with retriggers.
        if context.other_consumeable and context.other_consumeable.ability.set == 'Planet' then
			if not Talisman.config_file.disable_anims then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.other_consumeable:juice_up(0.5, 0.5)
						return true
					end,
				}))
			end
            return {
                message = localize({
                    type = "variable",
                    key = "a_powmult",
                    vars = {
                        number_format(card.ability.extra.Emult),
                    },
                }),
                Emult_mod = card.ability.extra.Emult,
				colour = G.C.DARK_EDITION,
            }
            
        end
    end,
    -- cry_credits = {
	-- 	idea = { "70UNIK" },
	-- 	art = { "70UNIK (originally from Devsisters)" },
	-- 	code = { "70UNIK (partially from Cryptid)" },
	-- },
}