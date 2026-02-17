--suggested by https://github.com/70UNIK/UNIKs-mod/issues/9
--displays a little indicator of the type of buff provided by summit cards and/or joker such as hiker and maya
UNIK.perma_bonus_coords = {
    perma_e_chips = {x = 0, y = 3},
    perma_e_mult = {x = 0, y = 4},
    perma_x_chips = {x = 1, y = 3},
    perma_x_mult = {x = 5, y = 3},
    perma_bonus = {x = 2, y = 3},
    perma_mult = {x = 4, y = 3},
    perma_p_dollars = {x = 3, y = 3},
    perma_h_x_chips = {x = 1, y = 4},
    perma_h_x_mult = {x = 5, y = 4},
    perma_h_chips = {x = 2, y = 4},
    perma_h_mult = {x = 4, y = 4},
    perma_h_dollars = {x = 3, y = 4},
    perma_repetitions = {x = 1, y = 5},
}

SMODS.DrawStep {
    key = 'bonus_indicator',
    order = 29,
    func = function(self)
        if self.area ~= G.deck then
            for i,v in pairs(UNIK.perma_bonus_coords) do
                if self.ability[i] ~= 0 then
                    if not self.children[i .. "_render"] then
                        self.children[i .. "_render"] = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS['unik_stickers'], v)
                        self.children[i .. "_render"].states.visible = false
                    end
                    self.children[i .. "_render"]:draw_shader('dissolve', nil, nil, nil, self.children.center, 0, 0)
                    self.children[i .. "_render"].role.draw_major = self
                end
            end
        end
        
    end,
    conditions = { vortex = false, facing = 'front' },
}