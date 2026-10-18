SMODS.current_mod.custom_card_areas = function(G) -- g is the same as G
    G.unik_detriment_area = CardArea( -- Should be saved in G for it to be preserved between reloads
        15, -- x coordinate
        2.5, -- y coordinate
        G.CARD_W * 2, -- width (this is the default for G.jokers)
        G.CARD_H * 0.95, -- height (this is the default for G.jokers)
        {
            -- optional, but recommended configs:
            card_limit = 0, -- card limit, doesn't actually affect the area unless checked manually
            type = 'joker', -- area type, doesn't affect what type of cards can be in it, only how they're displayed and act
            -- values can be `title`, `title_2`, `joker`, `shop`, `deck`, `hand`, `consumeable`, `voucher`, `play`, `discard`
            highlight_limit = 0,
            -- optional:
            --bg_colour = G.C.TEXT_INACTIVE, -- background color
            no_card_count = true, -- removes the card count ui for the area types that have it by default
            align_buttons = true, -- aligns the buttons for cards like in the Joker/Consumable areas
        }
    )
    --G.unik_detriment_area.states.visible = false
end

--partner sized as astro said
local Card_set_sprites_ref = Card.set_sprites
function Card:set_sprites(_center, _front)
    Card_set_sprites_ref(self, _center, _front)
    if _center and _center.set == "Detriment" and not _center:is_unlocked() then
        -- self.children.center = Sprite(self.T.x, self.T.y, G.CARD_W*46/71, G.CARD_H*58/95, G.ASSET_ATLAS["partner_Partner"], {x = 0, y = 4})
        -- self.children.center:set_role({major = self, role_type = "Glued", draw_major = self})
        self.T.h = G.CARD_H*63/95
        self.T.w = G.CARD_W*47/71
    end
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
        badge_colour = HEX("f6b600"),
        text_colour = HEX("FFFFFF"),
        default_key = 'detr_unik_poop',
    },
    significant = {
        value = 2,
        key = 'k_unik_significant',
        spawn_rate = function(self)
			return 0.3
		end,
        badge_colour = HEX("ff7400"),
        text_colour = HEX("FFFFFF"),
         default_key = 'detr_unik_impounded',
    },
    severe = {
        value = 3,
        key = 'k_unik_severe',
        spawn_rate = function(self)
			return 0
		end,
        badge_colour = HEX("FF0000"),
        text_colour = HEX("FFFFFF"),
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
    set = 'Detriment',
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_unik_detriment'), HEX("474931"),HEX("FFFFFF") , 1 )
        for i,v in pairs(UNIK.detriment_severities) do
            if self.severity == v.value then
                badges[#badges+1] = create_badge(localize(v.key), v.badge_colour, v.text_colour, 1 )
            end
        end
    end,
    inject = function(self)
        UNIK.detriments[self.key] = self
        if not G.P_CENTER_POOLS.Detriment then G.P_CENTER_POOLS.Detriment = {} end
        SMODS.insert_pool(G.P_CENTER_POOLS[self.set], self)
    end,
    get_obj = function(self, key) return UNIK.detriments[key] end,   
}

function UNIK.create_detriment(args)
    local seed = args and args.seed or "unik_detriment_default"

    local card2 = create_card("Detriment", G.unik_detriment_area, nil, 'unik_detrimental', nil, nil, nil, seed)
    print(card2.config.center.key)
    card2:start_materialize()
    card2:add_to_deck()
    G.unik_detriment_area:emplace(card2)
end

--UI:
SMODS.current_mod.custom_collection_tabs = function()
	return {
		UIBox_button({button = 'your_collection_detriments', label = {localize('k_unik_detriments')}, count = G.ACTIVE_MOD_UI and modsCollectionTally(UNIK.detriments) or G.DISCOVER_TALLIES.Detriment, minw = 5, minh = 1, id = 'your_collection_detriments', focus_args = {snap_to = true}})
	}
end

G.FUNCS.your_collection_detriments = function(e)
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu{
		definition = create_UIBox_your_collection_detriments(),
	}
end

function create_UIBox_your_collection_detriments()
    local deck_tables = {}

    G.your_collection = {}
    for j = 1, 2 do
        G.your_collection[j] = CardArea(
        G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
        (4.25+j)*G.CARD_W,
        1*G.CARD_H, 
        {card_limit = 4 + j, type = 'title', highlight_limit = 0, collection = true})
        table.insert(deck_tables, 
        {n=G.UIT.R, config={align = "cm", padding = 0, no_fill = true}, nodes={
        {n=G.UIT.O, config={object = G.your_collection[j]}}
        }}
        )
    end

    local tarot_options = {}
    for i = 1, math.floor(#G.P_CENTER_POOLS.Detriment/11) do
        table.insert(tarot_options, localize('k_page')..' '..tostring(i)..'/'..tostring(math.floor(#G.P_CENTER_POOLS.Detriment/11)))
    end

        for j = 1, #G.your_collection do
        for i = 1, 4+j do
        local center = G.P_CENTER_POOLS["Detriment"][i+(j-1)*(5)]
        local card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w/2, G.your_collection[j].T.y, G.CARD_W, G.CARD_H, nil, center)
        card:start_materialize(nil, i>1 or j>1)
        G.your_collection[j]:emplace(card)
        end
    end

    INIT_COLLECTION_CARD_ALERTS()
    
    local t = create_UIBox_generic_options({ 
    colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_colour or
        (G.ACTIVE_MOD_UI.ui_config or {}).colour),
    bg_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_bg_colour or
        (G.ACTIVE_MOD_UI.ui_config or {}).bg_colour),
    back_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_back_colour or
        (G.ACTIVE_MOD_UI.ui_config or {}).back_colour),
    outline_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_outline_colour or
        (G.ACTIVE_MOD_UI.ui_config or {}).outline_colour),
    back_func = G.ACTIVE_MOD_UI and "openModUI_"..G.ACTIVE_MOD_UI.id or 'your_collection', contents = {
                {n=G.UIT.R, config={align = "cm", minw = 2.5, padding = 0.1, r = 0.1, colour = G.C.BLACK, emboss = 0.05}, nodes=deck_tables},
                    {n=G.UIT.R, config={align = "cm"}, nodes={
                        create_option_cycle({options = tarot_options, w = 4.5, cycle_shoulders = true, opt_callback = 'your_collection_detriments', focus_args = {snap_to = true, nav = 'wide'},current_option = 1, colour = G.C.RED, no_pips = true})
                    }}
            }})
    return t
end