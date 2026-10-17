local lily_quotes = {
    normal = {
        'k_unik_lily_normal1',
        'k_unik_lily_normal2',
        'k_unik_lily_normal3',
        'k_unik_lily_normal4',
        'k_unik_lily_normal5',
    },
    bloated = {
        'k_unik_lily_normal_bloat',
        'k_unik_lily_normal_bloat1',
    },
    activate = {
        'k_unik_lily_trigger1',
        'k_unik_lily_trigger2',
        'k_unik_lily_trigger3'
    },
    beast = {
        'k_unik_lily_beast1',
        'k_unik_lily_beast2',
        'k_unik_lily_beast3',
        'k_unik_lily_beast4',
    },
    after = {
        'k_unik_lily_after1',
        'k_unik_lily_after2',
        'k_unik_lily_after3',
    },
    exhaust = {
        'k_unik_lily_exhaust1',
        'k_unik_lily_exhaust2',
        'k_unik_lily_exhaust3',
        'k_unik_lily_exhaust4',
    }
}

SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_lily_sprunki',
    atlas = 'unik_character_jokers',
    rarity = 3,
	pos = { x = 3, y = 2 },
	soul_pos = { x = 4, y = 2 },
    cost = 8,
    attributes = {'activated','destroy_card','character'},
    config = {extra = {active = true,quoteset = 'normal',limit = 5}},
    pronouns = "she_her",
    bypass_group_selection = true, --for polyminos stuff
    loc_vars = function(self, info_queue, center)
        local quote = "k_active_ex"
        if center.ability.extra.active then
            quote = "k_active_ex"
        else
            quote = "k_inactive_ex"
        end
        local quoteset = center.ability.extra.quoteset
        if G.playing_cards and G.GAME.starting_deck_size and center.ability.extra.quoteset == 'normal' and #G.playing_cards > G.GAME.starting_deck_size*1.3 then
            quoteset = 'bloated'
        end
        return { 
            key = quoteset == 'beast' and 'j_unik_lily_sprunki2' or 'j_unik_lily_sprunki',
            vars = {localize(quote) ,
            localize(lily_quotes[quoteset][math.random(#lily_quotes[quoteset])] .. "")
            ,center.ability.extra.limit,
            colours = { 
                G.C.SECONDARY_SET.Enhanced
            }
        } }
    end,
    blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
    triggering_blacklist = true,
    pools = {["character"] = true },
    add_to_deck = function(self, card, context)
        --return to normal sprite
        card.children.center:set_sprite_pos({x = 3, y = 2})
        card.children.floating_sprite:set_sprite_pos({x = 4, y = 2})
    end,
    calculate = function(self, card, context)

        --Allows you to flip if doublesided
        if context.after_cashout and context.cardarea == G.jokers then
            card.ability.extra.active = true
            card.ability.extra.quoteset = 'normal'
            card_eval_status_text(card, "extra", nil, nil, nil, {
                message = localize('k_reset'),
                colour = HEX("d377dc"),
                card=card,
            })

        end
	end,
    all_in_jest = {
        ability_cost = function(self, card)
             return 0
        end,
        can_use_ability = function(self, card, context)
            if not card.ability.extra.active then return false end
            local cards = 0
            for i,v in pairs(G.hand.highlighted) do
                if not SMODS.is_eternal(v,card) then
                    cards = cards + 1
                end
            end
            return cards > 0 and cards <= card.ability.extra.limit
        end,

        use_ability = function(self, card, args)
            args = args or {}
            SMODS.calculate_context({all_in_jest = {joker_ability_used = true, card = card, retriggered = args.retriggered, args = args}})
            local eternals = 0
            if G.hand and G.hand.highlighted and #G.hand.highlighted > 0 then
                for i, v in pairs(G.hand.highlighted) do
                    if  SMODS.is_eternal(v, card) then
                        eternals = eternals + 1
                    end
                end
            end
            if G.hand and G.hand.highlighted and #G.hand.highlighted - eternals > 0 then 
                G.CONTROLLER.locks.unik_destroy_selected = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up(0.5, 0.5)
                        card.children.center:set_sprite_pos({x = 3, y = 3})
                        card.children.floating_sprite:set_sprite_pos({x = 4, y = 3})
                        card.ability.extra.quoteset = 'beast'
                        return true
                    end
                }))
                card_eval_status_text( card, "extra", nil, nil, nil, {
                    message = localize(lily_quotes['activate'][math.random(#lily_quotes['activate'])] .. ""),
                    colour = HEX("744880"),
                    card= card,
                })
                delay(0.5)
                local destroyed_cards = {}
                for i, v in pairs(G.hand.highlighted) do
                    if not SMODS.is_eternal(v, card) and not v.shattered then
                        destroyed_cards[#destroyed_cards+1] = v
                    end
                end
                print(#destroyed_cards)
                if #destroyed_cards == 0 then
                    for i, v in pairs(G.hand.cards) do
                        if not SMODS.is_eternal(v, card) and not v.shattered and #destroyed_cards < #G.hand.highlighted then
                            destroyed_cards[#destroyed_cards+1] = v
                        end
                    end
                end
                local glass_shattered = {}
                for k, v in ipairs(destroyed_cards) do
                    if SMODS.has_enhancement(v, 'm_glass') then glass_shattered[#glass_shattered+1] = v end
                end

                check_for_unlock{type = 'shatter', shattered = glass_shattered}
                G.E_MANAGER:add_event(Event({
                    trigger='immediate',
                    func = function()
                        card:juice_up(0.5, 0.5)
                        card.children.center:set_sprite_pos({x = 3, y = 3})
                        card.children.floating_sprite:set_sprite_pos({x = 5, y = 3})
                        G.ROOM.jiggle = G.ROOM.jiggle + 5
                        --play_sound("unik_gore6") --thats funny
                        return true
                    end
                }))
                for i=1, #destroyed_cards do
                    destroyed_cards[i].shattered = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            if SMODS.shatters(destroyed_cards[i]) then
                                destroyed_cards[i]:shatter()
                            else
                                destroyed_cards[i]:start_dissolve()
                            end
                        return true
                        end
                    }))
                end
                
                delay(0.8)
                SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards })
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up(0.5, 0.5)
                        card.children.center:set_sprite_pos({x = 3, y = 2})
                        card.children.floating_sprite:set_sprite_pos({x = 4, y = 2})
                        card.ability.extra.quoteset = 'exhaust'
                        card.ability.extra.triggered = false
                        card.ability.extra.feral = false
                        return true
                    end
                }))
                card_eval_status_text( card, "extra", nil, nil, nil, {
                    message = localize(lily_quotes['after'][math.random(#lily_quotes['after'])] .. ""),
                    colour = HEX("d377dc"),
                    card= card,
                })
                delay(0.3)
                G.E_MANAGER:add_event(Event({
                    delay=0.2,
                    func = function()
                        G.CONTROLLER.locks.unik_destroy_selected = nil
                        card.ability.extra.active = false
                        return true
                    end
                }))
            else
                error("UH OH!")
            end
        end,
    },
    check_for_unlock = function(self, args)
        if args.type == 'unik_redeeming_voucher' and args.card.config.center.key == 'v_magic_trick' then
            return true
        end
    end,
    locked_loc_vars = function(self, info_queue, card)
        local other_name = localize('k_unknown')
        if G.P_CENTERS['v_magic_trick'].unlocked then
            info_queue[#info_queue + 1] = G.P_CENTERS.v_magic_trick
            
            other_name = localize { type = 'name_text', set = 'Voucher', key = 'v_magic_trick' }
        end
        return {
        vars = {
            other_name
        }
        }
    end,
    unlocked = false,
  	discovered = false,
}

local redemption = Card.redeem
function Card:redeem()
    local ret = redemption(self)
    check_for_unlock({ type = 'unik_redeeming_voucher',card = self })
    return ret
end



-- if JokerDisplay then
-- 	JokerDisplay.Definitions["j_unik_lily_sprunki"] = {
--     }
-- end

--cashout context
local cashoutcontext = G.FUNCS.cash_out
G.FUNCS.cash_out = function(e)
    SMODS.calculate_context({after_cashout = true})
    for i, card in pairs(G.playing_cards) do
        if card.ability and card.ability.extra and type(card.ability.extra) == 'table' then
             card.ability.extra.created_tag = nil
        end
        
    end
    cashoutcontext(e)
    -- G.GAME.unik_fiendish_cap = nil
end

--Gore6 (custom card destruction animation)
function Card:gore6_break()
    local enhancements = SMODS.get_enhancements(self)
    for key, _ in pairs(enhancements) do
        if G.P_CENTERS[key].woodbreak then 
            self:woodBreak()
            return nil
        elseif G.P_CENTERS[key].metalbreak then 
            self:metalBreak(G.P_CENTERS[key].metalbreak.colour or nil)
            return nil
        elseif G.P_CENTERS[key].rockbreak then 
            self:rockBreak(type(G.P_CENTERS[key].rockbreak) == "table" and G.P_CENTERS[key].rockbreak.colour or nil)
            return nil
        end
    end
     if not SMODS.is_playing_card(self) then
        local flags = SMODS.calculate_context({joker_type_destroyed = true, card = self})
        if flags.no_destroy then self.getting_sliced = nil; return false end
    end
    local dissolve_time = 0.7
    self.shattered = true
    self.dissolve = 0
    self.dissolve_colours = {{0.5,0,0,0.8}}
    self:juice_up()
    local childParts = Particles(0, 0, 0,0, {
        timer_type = 'TOTAL',
        timer = 0.007*dissolve_time,
        scale = 0.3,
        speed = 4,
        lifespan = 0.5*dissolve_time,
        attach = self,
        colours = self.dissolve_colours,
        fill = true
    })
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.5*dissolve_time,
        func = (function() childParts:fade(0.15*dissolve_time) return true end)
    }))
    G.E_MANAGER:add_event(Event({
        blockable = false,
        func = (function()
                play_sound("unik_gore6", math.random()*0.2 + 0.9,0.5)
                play_sound('generic1', math.random()*0.2 + 0.9,0.5)
            return true end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'ease',
        blockable = false,
        ref_table = self,
        ref_value = 'dissolve',
        ease_to = 1,
        delay =  0.5*dissolve_time,
        func = (function(t) return t end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.55*dissolve_time,
        func = (function() self:remove() return true end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.51*dissolve_time,
    }))
end