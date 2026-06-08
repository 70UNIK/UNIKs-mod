--Square trim code
SMODS.Shader({
    key = "blindside_square",
    path = "blindside_square.fs",
})
-- SMODS.DrawStep {
--     key = 'seal',
--     order = 31,
--     func = function(self, layer)
--         local seal = G.P_SEALS[self.seal] or {}
--         if self.ability.delay_seal then return end
--         if type(seal.draw) == 'function' then
--             seal:draw(self, layer)
--         elseif self.seal then
--             if G.P_SEALS[self.seal] and  G.P_SEALS[self.seal].pools and G.P_SEALS[self.seal].pools["bld_obj_enhancements"] then
--                 --print("BLINDSIDETRIM")
--                 if self.config.center.exotic or true then
--                     --print("attenmrt")
--                     G.shared_seals[self.seal].role.draw_major = self
--                     G.shared_seals[self.seal]:draw_shader('unik_blindside_square', nil, nil, nil, self.children.center)
--                     if self.seal == 'Gold' then G.shared_seals[self.seal]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center) end
--                 else
--                     G.shared_seals[self.seal].role.draw_major = self
--                     G.shared_seals[self.seal]:draw_shader('dissolve', nil, nil, nil, self.children.center)
--                     if self.seal == 'Gold' then G.shared_seals[self.seal]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center) end
--                 end
--             else
--                 G.shared_seals[self.seal].role.draw_major = self
--                 G.shared_seals[self.seal]:draw_shader('dissolve', nil, nil, nil, self.children.center)
--                 if self.seal == 'Gold' then G.shared_seals[self.seal]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center) end
--             end
--         end
--     end,
--     conditions = { vortex = false, facing = 'front' },
-- }