--completely indestructible.
--completely unremovable.

local zetaSeed = math.random(1,100)..math.random(1,100)..math.random(1,100)..math.random(1,100)..math.random(1,100)..math.random(1,100)..math.random(1,100)..'_zeta'

local updateStickerHook = Card.update
function Card:update(dt)
    if self.ability.unik_zeta then
        self.ability[zetaSeed] = true
    end
    if self.ability[zetaSeed] then
        self.ability.unik_zeta = true
    end
    local ret = updateStickerHook(self,dt)
    return ret
end