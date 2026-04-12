--suggested by https://github.com/70UNIK/UNIKs-mod/issues/9
--displays a little indicator of the type of buff provided by summit cards and/or joker such as hiker and maya
UNIK.perma_bonus_coords = {
    on_score = {
        {key = "perma_e_chips", pos = {x = 0, y = 0}},
        {key = "perma_x_chips", pos = {x = 1, y = 0}},
        {key = "perma_bonus", pos = {x = 2, y = 0}},
        {key = "perma_e_mult", pos = {x = 0, y = 1}},
        {key = "perma_x_mult", pos = {x = 5, y = 0}},
        {key = "perma_mult", pos = {x = 4, y = 0}},
        {key = "perma_p_dollars", pos = {x = 3, y = 0}},
        {key = "perma_repetitions", pos = {x = 1, y = 2}},
        {key = "perma_rescores", pos = {x = 3,y = 2}},
    },
    on_held = {
        {key = "perma_h_x_chips", pos = {x = 1, y = 1}},
        {key = "perma_h_chips", pos = {x = 2, y = 1}},
        {key = "perma_h_x_mult", pos = {x = 5, y = 1}},
        {key = "perma_h_mult", pos = {x = 4, y = 1}},
        {key = "perma_h_dollars", pos = {x = 3, y = 1}},
    },
}

--Full credit to Paperback and Meta for the paperback implementation;

local SCORE_OFFSET_X = -6
local HELD_OFFSET_X = -1
local HEIGHT = (SMODS.Mods["paperback"] or {}).can_load and 7 or 5 
local GAP = 1

SMODS.Atlas {
  key = "unik_indicators",
  px = 71,
  py = 95,
  path = "unik_indicators.png",

  inject = function(self)
    SMODS.Atlas.inject(self)

    for _, side in pairs(UNIK.perma_bonus_coords) do
      for _, v in ipairs(side) do
        v.sprite = Sprite(0, 0, G.CARD_W, G.CARD_H, self, v.pos)
      end
    end
  end
}

local function should_draw_indicator(card, key)
  return card and card.ability
      and type(card.ability[key]) == "number"
      and card.ability[key] > 0
      and card.area and card.area.config.type ~= 'deck'
end

local function draw_single_indicator(card, sprite, x_offset, y_offset)
  x_offset = (card.T.w / 71) * (x_offset or 0) * card.T.scale
  y_offset = (card.T.h / 95) * (y_offset or 0) * card.T.scale

  sprite.role.draw_major = card
  sprite:draw_shader(
    (card.greyed and 'played') or 'dissolve',
    nil, nil, nil,
    card.children.center,
    nil, nil,
    x_offset, y_offset
  )
end

local function draw_indicators(indicators, card, x_offset, y_offset)
  local y = GAP

  for _, v in ipairs(indicators) do
    if should_draw_indicator(card, v.key) then
      draw_single_indicator(
        card,
        v.sprite,
        x_offset,
        y + (y_offset or 0)
      )

      y = y + HEIGHT + GAP
    end
  end
end

SMODS.DrawStep {
  key = "bonus_indicators_front",
  order = 41,
  func = function(card)
    if card and card.ability then
        draw_indicators(UNIK.perma_bonus_coords.on_held, card, HELD_OFFSET_X)
    end
  end
}

SMODS.DrawStep {
  key = "bonus_indicators_back",
  order = -29,
  func = function(card)
    if card and card.ability then
        draw_indicators(UNIK.perma_bonus_coords.on_score, card, SCORE_OFFSET_X)
    end
  end
}

--old ye ye ass code

-- SMODS.DrawStep {
--     key = 'bonus_indicator',
--     order = 29,
--     func = function(self)
--         if self.area ~= G.deck then
--             for i,v in pairs(UNIK.perma_bonus_coords) do
--                 if self.ability and self.ability[i] and self.ability[i] ~= 0 then
--                     if not self.children[i .. "_render"] then
--                         self.children[i .. "_render"] = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS['unik_stickers'], v)
--                         self.children[i .. "_render"].states.visible = false
--                     end
--                     self.children[i .. "_render"]:draw_shader('dissolve', nil, nil, nil, self.children.center, 0, 0)
--                     self.children[i .. "_render"].role.draw_major = self
--                 end
--             end
--         end
        
--     end,
--     conditions = { vortex = false, facing = 'front' },
-- }



