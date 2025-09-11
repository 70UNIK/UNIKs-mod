function Card:get_chip_e_bonus()
    if self.debuff then return 0 end
    local ret = SMODS.multiplicative_stacking(self.ability.e_chips or 1, (not self.ability.extra_enhancement and self.ability.perma_e_chips) or 0)
    -- TARGET: get_chip_x_bonus
    return ret
end

function Card:get_mult_e_bonus()
    if self.debuff then return 0 end
    local ret = SMODS.multiplicative_stacking(self.ability.e_mult or 1, (not self.ability.extra_enhancement and self.ability.perma_e_mult) or 0)
    -- TARGET: get_chip_x_bonus
    return ret
end

local localBonusHook = SMODS.localize_perma_bonuses
function SMODS.localize_perma_bonuses(specific_vars, desc_nodes)
    localBonusHook(specific_vars, desc_nodes)
    if specific_vars and specific_vars.bonus_e_chips then
        localize{type = 'other', key = 'card_extra_e_chips', nodes = desc_nodes, vars = {specific_vars.bonus_e_chips}}
    end
    if specific_vars and specific_vars.bonus_e_mult then
        localize{type = 'other', key = 'card_extra_e_mult', nodes = desc_nodes, vars = {specific_vars.bonus_e_mult}}
    end
end