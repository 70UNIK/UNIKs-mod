--I don't like the cube being worse than lemon trophy
--So ill nerf it.
SMODS.Blind:take_ownership('blind', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
        key = "cry_cube",
        atlas = "blinds",
        order = 23,
        boss_colour = G.C.CHIPS,
        mult = 0.1,
        unik_exponent = {1,0.33},
        pos = { x = 0, y = 21 },
        dollars = 5,
        boss = {
            min = 1,
        },
        calculate = function(self, blind, context)
            local cube_mod_mult = mod_mult
            mod_mult = function(mult)
                if context.setting_blind and G.GAME.blind.config.blind.key == "bl_cry_cube" then
                    return mult^0.5
                end
                return cube_mod_mult(mult)
            end
        end
    },
    true -- silent | suppresses mod badge
)