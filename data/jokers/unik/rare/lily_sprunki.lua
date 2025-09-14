--Turns out lily feels more like a blind than a benefit given how you have little control of card destruction.
--Rework: Grants the option to destroy all selected cards, once per round (Active!/Inactive)
--Has a dedicated button to do so
SMODS.Atlas {
	key = "unik_lily_sprunki",
	path = "unik_lily_sprunki.png",
	px = 71,
	py = 95
}

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
    atlas = 'unik_lily_sprunki',
    rarity = 3,
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
    cost = 8,
    config = {extra = {active = true,quoteset = 'normal',limit = 2}},
    pronouns = "she_her",
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
            ,center.ability.extra.limit
        } }
    end,
    blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
    triggering_blacklist = true,
    pools = {["unik_copyrighted"] = true },
    add_to_deck = function(self, card, context)
        --return to normal sprite
        card.children.center:set_sprite_pos({x = 0, y = 0})
        card.children.floating_sprite:set_sprite_pos({x = 1, y = 0})
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
}

if JokerDisplay then
	JokerDisplay.Definitions["j_unik_lily_sprunki"] = {
    }
end

--cashout context
local cashoutcontext = G.FUNCS.cash_out
G.FUNCS.cash_out = function(e)
    SMODS.calculate_context({after_cashout = true})
    cashoutcontext(e)
end

--Add "devour" button on highlight
  local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
  function G.UIDEF.use_and_sell_buttons(card)
    local tdc =  G_UIDEF_use_and_sell_buttons_ref(card)
    if (card.area == G.jokers) and card.config.center.key == "j_unik_lily_sprunki" then --Add a devour button
        local sell = nil
        local use = nil
        local devour = nil

        sell = {n=G.UIT.C, config={align = "cr"}, nodes={
        {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card'}, nodes={
            {n=G.UIT.B, config = {w=0.1,h=0.6}},
            {n=G.UIT.C, config={align = "tm"}, nodes={
            {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                {n=G.UIT.T, config={text = localize('b_sell'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
            }},
            {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
                {n=G.UIT.T, config={ref_table = card, ref_value = 'sell_cost_label',colour = G.C.WHITE, scale = 0.55, shadow = true}}
            }}
            }}
        }},
        }}
         devour = 
            {n=G.UIT.C, config={align = "cr"}, nodes={
            
            {n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'unik_devour_fs', func = 'unik_can_devour_fs'}, nodes={
                {n=G.UIT.B, config = {w=0.1,h=0.6}},
                {n=G.UIT.T, config={text = localize('b_unik_devour'),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
            }}
        }}
        --overwriting usual buttons
        tdc = {
      n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
        {n=G.UIT.C, config={padding = 0.15, align = 'cl'}, nodes={
          {n=G.UIT.R, config={align = 'cl'}, nodes={
            sell
          }},
          {n=G.UIT.R, config={align = 'cl'}, nodes={
            use
          }},
          {n=G.UIT.R, config={align = 'cl'}, nodes={
            devour
          }},
        }},
    }}
    end
    return tdc
end

--Gore6 (custom card destruction animation)
function Card:gore6_break()
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

G.FUNCS.unik_devour_fs = function(e)
    local card = e.config.ref_table
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
                 card.children.center:set_sprite_pos({x = 0, y = 1})
                 card.children.floating_sprite:set_sprite_pos({x = 1, y = 1})
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
                 card.children.center:set_sprite_pos({x = 0, y = 1})
                 card.children.floating_sprite:set_sprite_pos({x = 2, y = 1})
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
                 card.children.center:set_sprite_pos({x = 0, y = 0})
                 card.children.floating_sprite:set_sprite_pos({x = 1, y = 0})
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
                
                G.E_MANAGER:add_event(Event({
                    trigger='after',
                        func = function()
                            e.disable_button = nil
                        return true
                    end
                }))
                return true
            end
        }))
    else
        print("OOps error!")
        e.disable_button = nil
        
    end
end

G.FUNCS.unik_can_devour_fs = function(e)
    local card = e.config.ref_table
    if G.hand and G.hand.highlighted and not card.debuff then
        if
            not (G.CONTROLLER.locked or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0))
            and not G.SETTINGS.paused
            and card.area.config.type ~= "shop" then
            local eternals = 0
            for i, v in pairs(G.hand.highlighted) do
                if SMODS.is_eternal(v, card) then
                    eternals = eternals + 1
                end
            end
            if #G.hand.highlighted - eternals > 0 and (card.ability and card.ability.extra and (card.ability.extra.active)) then
                e.config.colour = G.C.UNIK_EYE_SEARING_RED
                e.config.button = "unik_devour_fs"
            else
                e.config.colour = G.C.UI.BACKGROUND_INACTIVE
                e.config.button = nil
            end
        else
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
        end
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
        
end
