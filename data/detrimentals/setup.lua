local areas_ref = SMODS.current_mod.custom_card_areas or function(G) end
SMODS.current_mod.custom_card_areas = function(G)
    local ret = areas_ref(G)
    G.unik_detriment_area = CardArea( -- Should be saved in G for it to be preserved between reloads
        14.5, -- x coordinate
        2.7, -- y coordinate
        G.CARD_W * 2.3, -- width (this is the default for G.jokers)
        G.CARD_H * 0.95*(63/95), -- height (this is the default for G.jokers)
        {
            -- optional, but recommended configs:
            card_limit = 999999999999999999999, -- card limit, doesn't actually affect the area unless checked manually
            type = 'joker', -- area type, doesn't affect what type of cards can be in it, only how they're displayed and act
            -- values can be `title`, `title_2`, `joker`, `shop`, `deck`, `hand`, `consumeable`, `voucher`, `play`, `discard`
            highlight_limit = 999999999999999999999,
            -- optional:
            --bg_colour = G.C.TEXT_INACTIVE, -- background color
            no_card_count = true, -- removes the card count ui for the area types that have it by default
            align_buttons = true, -- aligns the buttons for cards like in the Joker/Consumable areas
        }
    )
    return ret
    
end

--partner sized as astro said
local Card_set_sprites_ref = Card.set_sprites
function Card:set_sprites(_center, _front)
    Card_set_sprites_ref(self, _center, _front)
    if _center and _center.set == "Detriment" then
        --  self.children.center = Sprite(self.T.x, self.T.y, G.CARD_W*46/71, G.CARD_H*58/95, G.ASSET_ATLAS["partner_Partner"], {x = 0, y = 4})
        --  self.children.center:set_role({major = self, role_type = "Glued", draw_major = self})
        self.T.h = G.CARD_H*63/95
        self.T.w = G.CARD_W*47/71
    end
end

local highlighter = CardArea.can_highlight
function CardArea:can_highlight(card)
    if  self.config.type == 'Detriment' then
        return true
    end
    local ret = highlighter(self,card)
    return ret
end

UNIK.detriments = {

}

UNIK.detriment_severities = {
    mild = {
        value = 1,
        key = 'k_unik_mild',
        spawn_rate = function(self)
			return 0.7
		end,
        badge_colour = G.C.UNIK_MILD,
        text_colour = G.C.WHITE,
        default_key = 'detr_unik_poop',
    },
    significant = {
        value = 2,
        key = 'k_unik_significant',
        spawn_rate = function(self)
			return 0.3
		end,
        badge_colour = G.C.UNIK_SIGNIFICANT,
        text_colour = G.C.WHITE,
         default_key = 'detr_unik_impound_notice',
    },
    severe = {
        value = 3,
        key = 'k_unik_severe',
        spawn_rate = function(self)
			return 0
		end,
        badge_colour = G.C.UNIK_SEVERE,
        text_colour = G.C.WHITE,
        default_key = 'detr_unik_xchips_hater',
    }
}

---PIXEL SIZE will be 3/4 of a usual card
---@ class UNIK.detriment : SMODS.Center
---@ field severity any Text or number. 1 = Mild, 2 = Significant, 3 = Severe, 4 = a Hypothetical "catastrophic"
---@ field calculate? function Calculate function while held.
---@ field atlas string Must be like a 47 x 63 size
UNIK.detriment = SMODS.Center:extend{
    severity = 1,
    class_prefix = 'detr',
    required_params = {
        'key',
        "atlas", 
        "pos",
        "severity"
    },
    config = {},
    cost = 0,
    unlocked = true,
    discovered = false,
    detriment = true,
    sellable = false,
    set = 'Detriment',
    pre_inject_class = function(self)
		G.P_CENTER_POOLS[self.set] = G.P_CENTER_POOLS[self.set] or {}
	end,
	set_card_type_badge = function(self, card, badges)
		badges[#badges+1] = create_badge(localize('k_unik_detriment'), G.C.UNIK_DETRIMENT,G.C.WHITE , 1 )
	end,
    set_badges = function(self, card, badges)
        for i,v in pairs(UNIK.detriment_severities) do
            if self.severity == v.value then
                badges[#badges+1] = create_badge(localize(v.key), v.badge_colour, v.text_colour, 1 )
            end
        end
    end,
    inject = function(self)
        SMODS.Center.inject(self)
        UNIK.detriments[self.key] = self
        if not G.P_CENTER_POOLS.Detriment then G.P_CENTER_POOLS.Detriment = {} end
        --print("INJECT" .. self.key)
        --SMODS.insert_pool(G.P_CENTER_POOLS[self.set], self)
    end,
    get_obj = function(self, key) return UNIK.detriments[key] end,   
}

--UI:
SMODS.current_mod.custom_collection_tabs = function()
	return {
		UIBox_button({button = 'your_collection_detriments', label = {localize('k_unik_detriments')}, count = G.ACTIVE_MOD_UI and modsCollectionTally(UNIK.detriments) or G.DISCOVER_TALLIES.Detriment, minw = 5, minh = 1, id = 'your_collection_detriments', focus_args = {snap_to = true}})
	}
end

G.FUNCS.your_collection_detriments = function(e)
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu{
		definition = G.UIDEF.create_UIBox_your_collection_detriments(),
	}
end

function G.UIDEF.create_UIBox_your_collection_detriments()
    local pool = {}
	for k, v in pairs(G.P_CENTER_POOLS.Detriment) do
		if not v.no_collection then pool[#pool + 1] = v end
	end
	return SMODS.card_collection_UIBox(pool, { 6, 6 }, {
		h_mod = 0.95*63/95,
        w_mod = 0.71*47*1.35/71,
		back_func = 'your_collection_other_gameobjects',
	})
end

function UNIK.create_detriment(args)
    local seed = args and args.seed or "unik_detriment_default"..G.GAME.round_resets.ante
    local dissolve = args and args.no_dissolve and false or true
    local severity = args and args.severity or nil
    local key = args and args.forced_key or UNIK.poll_detriment_card({seed = seed,severity = severity})
    
    local card = SMODS.create_card { key = key }
    if dissolve == true then
        card:start_materialize()
    end
    
    card:add_to_deck()
    G.unik_detriment_area:emplace(card)
    return card
end

function UNIK.create_detriment_booster(area,args)
    local seed = args and args.seed or "unik_detriment_default"..G.GAME.round_resets.ante
    local severity = args and args.severity or nil
    local key = args and args.forced_key or UNIK.poll_detriment_card({seed = seed,severity = severity})
    
    local front = SMODS.set_create_card_front or ((_type=='Base' or _type == 'Enhanced') and pseudorandom_element(G.P_CARDS, pseudoseed('front'..(key_append or '')..G.GAME.round_resets.ante))) or nil
    local card = Card(area.T.x + area.T.w/2, area.T.y, G.CARD_W, G.CARD_H, front, G.P_CENTERS[key],
    {bypass_discovery_center = SMODS.bypass_create_card_discovery_center or area==G.shop_jokers or area == G.pack_cards or area == G.shop_vouchers or (G.shop_demo and area==G.shop_demo) or area==G.jokers or area==G.consumeables,
     bypass_discovery_ui = SMODS.bypass_create_card_discovery_center or area==G.shop_jokers or area == G.pack_cards or area==G.shop_vouchers or (G.shop_demo and area==G.shop_demo),
     discover = SMODS.bypass_create_card_discover or area==G.jokers or area==G.consumeables, 
     bypass_back = G.GAME.selected_back.pos})

    return card
end

--Returns the detriment severity.
--Returns either a number or a string.
function UNIK.poll_detriment_severity(args)
    local force_severity = args.force_severity or nil
    local seed = args.seed or 'unik_detriment_default'
    local total_weight = 0
    local severity_weights = {}
    if force_severity then
        return force_severity
    end
    local rarity_poll = pseudorandom(pseudoseed(seed or ('unik_detriment_default'..G.GAME.round_resets.ante))) -- Generate the poll value
    for i,v in pairs(UNIK.detriment_severities) do
        local rate = 0
        if v.spawn_rate and type(v.spawn_rate) == 'function' then
            rate = v:spawn_rate()
        end
        total_weight = total_weight + rate
        severity_weights[v.key] = {}
        severity_weights[v.key].rate = rate
        severity_weights[v.key].severity = v.value
    end
    for i,v in pairs(severity_weights) do
        v.rate = v.rate/total_weight
    end
     local weight_i = 0
    for i,v in pairs(severity_weights) do
        weight_i = weight_i + v.rate
        --print(rarity_poll .. " " .. weight_i)
        if rarity_poll < weight_i then
            --print(v.rate .. " " .. v.name)
            return v.severity
        end
    end
end

function UNIK.poll_detriment_card(args)
    local severity = args.severity or nil
    local seed = args.seed or ('unik_detriment_default'.. G.GAME.round_resets.ante)
    local pool = {}
    local final_pool = {}
    if not severity then
        severity = UNIK.poll_detriment_severity(seed)
    end
    for k, v in pairs(G.P_CENTER_POOLS.Detriment) do
		pool[#pool + 1] = v
	end
    for k, v in ipairs(pool) do
        local add = nil
        local in_pool, pool_opts = SMODS.add_to_pool(v, { source = seed })
        pool_opts = pool_opts or {}
    
        if G.GAME.used_jokers[v.key] then
           -- print("ALREDY EXISTS!")
        end
        if in_pool and not (G.GAME.used_jokers[v.key] and not SMODS.showman(v.key)) then 
            add = true 
        end
        if v.severity ~= severity then
            add = nil
        end
        if v.no_pool_flag and G.GAME.pool_flags[v.no_pool_flag] then add = nil end
        if v.yes_pool_flag and not G.GAME.pool_flags[v.yes_pool_flag] then add = nil end
        if G.GAME.cry_banished_keys[v.key] then add = nil end

        if add then
            final_pool[#final_pool+1] = v.key
        end
    end
    --print(final_pool)
    --run through backups!
    if #final_pool == 0 then
        print("EMPTY POOL! backup!")
        for i,v in pairs(UNIK.detriment_severities) do
            if v.value == severity then
                return v.default_key
            end
        end
        warn("INVALID RARITY, DEFAULTING TO detr_unik_poop")
        return 'detr_unik_poop' --hard default when all else fails
    else
        local final_key = pseudorandom_element(final_pool, pseudoseed(seed))
        --print(final_key)
        return final_key
    end
end