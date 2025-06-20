local function White_lily_copy(card)
    local _card = copy_card(card, nil, nil, nil, nil)
   --print(_card.ability.extra.initial)
    _card.ability.extra.initial = true
    
    _card:add_to_deck()
    _card:start_materialize()
    G.jokers:emplace(_card)
    _card.ability.banana = nil
    _card.ability.perishable = nil -- Done manually to bypass perish compat
    _card.ability.eternal = nil
    _card.ability.cry_rigged = nil
    _card.ability.cry_hooked = nil
    _card.ability.unik_disposable = nil
    _card.ability.unik_depleted = nil
    _card.ability.pinned = nil
    _card.ability.cry_flickering = nil
    _card.ability.cry_possessed = nil
    _card.ability.extra.copying = false
    _card.ability.extra.sold = false
    --TODO: Double Scale and Scalae support for when she self destructs or gets destroyed
    --avoid permanently doubling her values to her copy so the multiply properties must transfer
    if card.config.cry_multiply then
        _card.config.cry_multiply = card.config.cry_multiply
    end

end
SMODS.Atlas {
	key = "unik_white_lily",
	path = "unik_white_lily.png",
	px = 71,
	py = 95
}
--TODO: fix if she self destructs while //MULTIPLY is active on her.
--TODO: also disable her cloning functionality if you use BALATRO's SOUL, to not make her way to op, but more importantly, fix a critical issue (she will get destroyed and clone over and over, crashing the game)
SMODS.Joker {
	key = 'unik_white_lily_cookie',
    atlas = 'unik_white_lily',
    rarity = "cry_exotic",
    dependencies = {
		items = {
			"set_cry_exotic",
		},
    },
	pos = { x = 0, y = 0 },
	-- soul_pos sets the soul sprite, used for legendary jokers and basically all of Jen's Jokers
	soul_pos = { x = 1, y = 0 },
    cost = 50,
	blueprint_compat = true,
    perishable_compat = false,
    demicoloncompat = true,
	eternal_compat = true,
    -- Mainline:
    -- Commit can only be used on her ONCE, if she recieves COMMIT again, she cannot create a copy 
    -- Madness: No COMMIT limit, feel free to go ham on creating free Exotics
    config = { extra = { commits_left = 1, commit_message = "(Not committed)",Emult = 1.0, Emult_mod = 0.1, x_mult = 1.0, x_mult_mod = 1.25, sold = false,copying = false,initial = false,true_Emult_mod = 0.1, true_x_mult_mod = 1.25} },
	loc_vars = function(self, info_queue, center)
		return { 
            key = Cryptid.gameset_loc(self, { modest = "modest"}), 
            vars = {center.ability.extra.Emult,center.ability.extra.Emult_mod,center.ability.extra.x_mult,center.ability.extra.x_mult_mod,center.ability.extra.commit_message} }
	end,
    add_to_deck = function(self, card, from_debuff)
        if card.ability.extra.commits_left > 0 then
            card.ability.extra.commit_message = localize("k_unik_white_lily_not_committed")
        else
            card.ability.extra.commit_message = localize("k_unik_white_lily_committed")
        end
        
        card.ability.perishable = nil
        card.ability.extra.copying = false
        card.ability.extra.sold = false
        --To keep misprint deck consistent, when initializing her in deck, have her true values be set to initial values
        if card.ability.extra.initial == false then
           --print("set initial variables!~")
            card.ability.extra.true_Emult_mod = card.ability.extra.true_Emult_mod
            card.ability.extra.true_x_mult_mod = card.ability.extra.x_mult_mod
            card.ability.extra.initial = true
        end
    end,
    pools = { ["unik_cookie_run"] = true, ["unik_copyrighted"] = true },
    calculate = function(self, card, context)
        if context.forcetrigger then
            if card.ability.extra.copying == false then
                card.ability.extra.copying = true
                card.ability.extra.Emult = card.ability.extra.Emult + card.ability.extra.Emult_mod
                card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
                --do not make multiple clones of her! 
                if Card.get_gameset(card) ~= "modest" then
                    card_eval_status_text(card, "extra", nil, nil, nil, {
                        message = localize({
                            type = "variable",
                            key = "a_powmult",
                            vars = {
                                number_format(to_big(card.ability.extra.Emult)),
                            },
                        }),
                        colour = G.C.DARK_EDITION,
                        card = card,
                    })
                else
                    card_eval_status_text(card, "extra", nil, nil, nil, {
                        message = localize({
                            type = "variable",
                            key = "a_xmult",
                            vars = {
                                number_format(to_big(card.ability.extra.x_mult)),
                            },
                        }),
                        colour = G.C.MULT,
                        card = card,
                    })
                end 
                selfDestruction(card,"k_unik_plant_no_face",HEX("bfb2f6"))
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    func = function()
                        White_lily_copy(card)
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
        if context.joker_main then
            if Card.get_gameset(card) ~= "modest" then
                if (to_big(card.ability.extra.Emult) > to_big(1)) then
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
            else
                if (to_big(card.ability.extra.x_mult) > to_big(1)) then
                    return {
                        message = localize({
                            type = "variable",
                            key = "a_xmult",
                            vars = {
                                number_format(card.ability.extra.x_mult),
                            },
                        }),
                        Xmult_mod = card.ability.extra.x_mult,
                        colour = G.C.MULT,
                    }
                end    
            end

		end
        if (context.ending_shop and not context.blueprint and not context.repetition and not context.retrigger_joker) then
           --print(card.ability.extra.copying)
            if card.ability.extra.copying == false then
                card.ability.extra.copying = true
                card.ability.extra.Emult = card.ability.extra.Emult + card.ability.extra.Emult_mod
                card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
                --do not make multiple clones of her! 
                if Card.get_gameset(card) ~= "modest" then
                    card_eval_status_text(card, "extra", nil, nil, nil, {
                        message = localize({
                            type = "variable",
                            key = "a_powmult",
                            vars = {
                                number_format(to_big(card.ability.extra.Emult)),
                            },
                        }),
                        colour = G.C.DARK_EDITION,
                        card = card,
                    })
                else
                    card_eval_status_text(card, "extra", nil, nil, nil, {
                        message = localize({
                            type = "variable",
                            key = "a_xmult",
                            vars = {
                                number_format(to_big(card.ability.extra.x_mult)),
                            },
                        }),
                        colour = G.C.MULT,
                        card = card,
                    })
                end 
                selfDestruction(card,"k_unik_plant_no_face",HEX("bfb2f6"))
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    func = function()
                        White_lily_copy(card)
                        return true
                    end,
                }))
            end
        end
        --selling her will NOT clone her
        if context.selling_self and not context.repetition and not context.blueprint then
            card.ability.extra.sold = true
        end
    end,
}

local oldfunc = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
    if self.config.center.key == "j_unik_white_lily_cookie" and not self.ability.extra.sold then
        self.ability.extra.copying = true
        self.ability.extra.Emult = self.ability.extra.Emult + self.ability.extra.Emult_mod
        self.ability.extra.x_mult = self.ability.extra.x_mult + self.ability.extra.x_mult_mod
        --do not make multiple clones of her! AND DO NOT COPY IF THE SOUL IS BANNED!
        if self.ability.extra.commits_left < 0 or (G.GAME.banned_keys.c_jen_soul_omega and (not G.GAME.ban_spawn_on_bala_soul)) then
            play_sound('cancel', 1, 0.7)
            card_eval_status_text(self, "extra", nil, nil, nil, {
                message = localize("k_extinct_ex"),
                colour = G.C.BLACK,
                card = self,
            })
            if G.GAME.banned_keys.c_jen_soul_omega then
                G.GAME.ban_spawn_on_bala_soul = true
            end
        elseif Card.get_gameset(self) ~= "modest" then
            card_eval_status_text(self, "extra", nil, nil, nil, {
                message = localize({
                    type = "variable",
                    key = "a_powmult",
                    vars = {
                        number_format(to_big(self.ability.extra.Emult)),
                    },
                }),
                colour = G.C.DARK_EDITION,
                card = self,
            })
        else
            card_eval_status_text(self, "extra", nil, nil, nil, {
                message = localize({
                    type = "variable",
                    key = "a_xmult",
                    vars = {
                        number_format(to_big(self.ability.extra.x_mult)),
                    },
                }),
                colour = G.C.MULT,
                card = self,
            })
        end 
        if (self.ability.extra.commits_left >= 0 and not (G.GAME.banned_keys.c_jen_soul_omega and (not G.GAME.ban_spawn_on_bala_soul))) then
            White_lily_copy(self)
        end
    end
    local vars = oldfunc(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
    return vars 
end

if JokerDisplay then
	JokerDisplay.Definitions["j_unik_white_lily_cookie"] = {
		text = {
			{
				border_nodes = {
					{ ref_table = "card.joker_display_values", ref_value = "Emult", retrigger_type = "exp" },
				},
				border_colour = G.C.DARK_EDITION,
			},
            {
				border_nodes = {
					{ ref_table = "card.joker_display_values", ref_value = "Xmult", retrigger_type = "exp" },
				},
				border_colour = G.C.MULT,
			},
		},
        calc_function = function(card)
            local Emult = ""
            local Xmult = ""
            if Card.get_gameset(card) ~= "modest" then
                Emult = "^" .. card.ability.extra.Emult
            else
                Xmult = "X" .. card.ability.extra.x_mult
            end
            card.joker_display_values.Emult = Emult
            card.joker_display_values.Xmult = Xmult
        end
	}
end
