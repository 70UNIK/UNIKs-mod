--Turns out lily feels more like a blind than a benefit given how you have little control of card destruction.
--Rework: Grants the option to destroy all selected cards, once per round (Active!/Inactive)
--Has a dedicated button to do so


local lily_quotes = {
    normal = {
        'k_unik_lily_sprunki_normal',
    },
    feral = {
        'k_unik_lily_sprunki_monster',
    },
    tired = {
        'k_unik_lily_sprunki_tired',
    },
}

SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_lily_sprunki',
    atlas = 'unik_character_jokers',
    rarity = 3,
	pos = { x = 3, y = 2 },
	soul_pos = { x = 4, y = 2 },
    cost = 8,
    config = {extra = {active = true,quoteset = 'normal',limit = 2}},
    pronouns = "she_her",
    bypass_group_selection = true, --for polyminos stuff
    loc_vars = function(self, info_queue, center)
        local quote = "k_active_ex"
        if center.ability.extra.active then
            quote = "k_active_ex"
        else
            quote = "k_inactive_ex"
        end
        return { 
            vars = {localize(quote) ,
            localize(lily_quotes[center.ability.extra.quoteset][math.random(#lily_quotes[center.ability.extra.quoteset])] .. "")
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
    unik_can_activate_ability = function(self,card)
        if not card.ability.extra.active then return false end
        local cards = 0
        for i,v in pairs(G.hand.highlighted) do
            if not SMODS.is_eternal(v,card) then
                cards = cards + 1
            end
        end
        return cards > 0
    end,
    unik_activated_ability = function(self,card) 
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
                 card.ability.extra.quoteset = 'feral'
                return true
            end
        }))
        card_eval_status_text( card, "extra", nil, nil, nil, {
            message = localize('k_unik_lily_sprunki_monster'),
            colour = HEX("d377dc"),
            card= card,
        })
        delay(0.5)
        local destroyed_cards = {}
        for i, v in pairs(G.hand.highlighted) do
            if not SMODS.is_eternal(v, card) then
                destroyed_cards[#destroyed_cards+1] = v
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
            G.E_MANAGER:add_event(Event({
                func = function()
                    if SMODS.shatters(destroyed_cards[i]) then
                        destroyed_cards[i]:shatter()
                    else
                        destroyed_cards[i]:gore6_break()
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
                 card.ability.extra.quoteset = 'tired'
                  card.ability.extra.triggered = false
                  card.ability.extra.feral = false
                return true
            end
        }))
        card_eval_status_text( card, "extra", nil, nil, nil, {
            message = localize("k_unik_lily_sprunki_after"),
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

}

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
    if self.getting_sliced and not (self.ability.set == 'Default' or self.ability.set == 'Enhanced') then
        local flags = SMODS.calculate_context({joker_type_destroyed = true, card = self, shatters = true})
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