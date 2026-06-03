BLINDSIDE.Joker({
    blindside_joker = true,
    key = 'unik_blindside_energy_compressor',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=16},
    boss_colour = HEX("A1AFB9"),
    mult = 16,
    base_dollars = 8,
    order = 1,
    boss = {min = 3},
    active = true,
    calculate = function(self, blind, context)
        if context.before and not G.GAME.blind.disabled then
			 G.GAME.energy_compressor_blind_effect = true
		end
        if not G.GAME.blind.disabled and context.unik_energy_compressor and context.energy_compressor_effect ~= nil and context.energy_compressor_value ~= nil and not context.blueprint and not context.retrigger_joker and context.energy_compressor_ref then
           -- print(context.energy_compressor_effect)
            --print(context.energy_compressor_value)
            local value = G.GAME.unik_stored_scoring[context.energy_compressor_ref[1]].instances[context.energy_compressor_ref[2]]
            G.GAME.unik_stored_scoring[context.energy_compressor_ref[1]].instances[context.energy_compressor_ref[2]] = nil
            if value then
                
                return {
                [context.energy_compressor_effect] = context.energy_compressor_value*0.9
            }
            end
            
        end
        if context.after then
             G.GAME.energy_compressor_blind_effect = nil
        end
    end,
})