--locked trim:
--X1.25 Mult, cannot be rerolled or destroyed
SMODS.Seal {
    key = "unik_blindside_locked",
    atlas = 'unik_legendary_blind_enhancements', 
    pos = { x = 1, y = 3 },
    legendary_atlas = 'unik_legendary_blind_enhancements',
    legendary_atlas_coords = {x = 3, y = 2},
    config = { 
        extra = { 
            x_mult = 1.2,
            locked_destroy_limit = 2,
            locked_burn_limit = 5,
        } 
    },
    badge_colour = HEX('7B5877'),
    in_pool = function(self, args)
        return UNIK.hasBlindside()
    end,
    blindside_trim = true,
    pools = {
        ["bld_obj_enhancements"] = true,
    },
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play and card.facing ~= 'back' then
            return {
                x_mult = card.ability.seal.extra.x_mult
            }
        end
    end,
    weight = function(self, info_queue, card) 
        return 1 --a bit lower than usual
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.seal.extra.x_mult,card.ability.seal.extra.locked_burn_limit,card.ability.seal.extra.locked_destroy_limit
            }
        }
    end
}

--reset counters if reapplied
local sealant = Card.set_seal
function Card:set_seal(_seal, silent, immediate)
    local ret = sealant(self,_seal, silent, immediate)
    if _seal == 'unik_blindside_locked' and self.ability and self.ability.seal and self.ability.seal.extra then
        self.ability.seal.extra.locked_burn_limit = 5
        self.ability.seal.extra.locked_destroy_limit = 2
    end
    return ret
end