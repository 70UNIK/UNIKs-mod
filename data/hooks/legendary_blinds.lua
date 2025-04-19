--Legendary blind animation handlers. Should change the atlas be mainly y = 0, randomly setting to 1-5.
-- function Blind:glitchy_glitchy_boo_boo()
--     if self.glitchy_anim then
        -- self.legendary_glitch = math.random(1, 50)
        -- if math.random(200) == 1 then
        --         self.children.animatedSprite:shift_atlas({x = 0, y = math.random(1, 5)})
        --         print("GLITCH")
        -- elseif self.legendary_glitch then
        --     if self.legendary_glitch <= 1 then
        --         self.children.animatedSprite:shift_atlas({x = 0, y = 0})
        --         self.legendary_glitch = nil
        --     else
        --         self.legendary_glitch = self.legendary_glitch - 1
        --     end
        -- end
        
--     end
-- end
--Hook for animated sprite
local animatedSpriteInitLegend = AnimatedSprite.init
function AnimatedSprite:init(X, Y, W, H, new_sprite_atlas, sprite_pos,unik_legendary)
    --print("GGG")
    local vars = animatedSpriteInitLegend(self,X, Y, W, H, new_sprite_atlas, sprite_pos)
        if unik_legendary then
            print("LEGENDARY FOUND")
            self.unik_enable_legendary_glitch = true
            table.insert(G.UNIK_LEGENDARY_GLITCH, self)
        end
    return vars
end
--For legendary blinds,etc... It changes the atlas, without changing the base atlas
function AnimatedSprite:shift_atlas(sprite_pos)
    self.animation = {
        x= sprite_pos and sprite_pos.x or 0,
        y=sprite_pos and sprite_pos.y or 0,
        frames=self.atlas.frames,current=0,
        w=self.scale.x, h=self.scale.y}
end