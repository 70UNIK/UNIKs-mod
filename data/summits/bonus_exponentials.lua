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
    -- if specific_vars and specific_vars.suit_x_chips then
    --     localize{type = 'other', key = 'card_suit_x_chips', nodes = desc_nodes, vars = {specific_vars.suit_x_chips}}
    -- end
    -- if specific_vars and specific_vars.suit_x_mult then
    --     localize{type = 'other', key = 'card_suit_x_mult', nodes = desc_nodes, vars = {specific_vars.suit_x_mult}}
    -- end
    localBonusHook(specific_vars, desc_nodes)
    if specific_vars and specific_vars.bonus_e_chips then
        localize{type = 'other', key = 'card_extra_e_chips', nodes = desc_nodes, vars = {specific_vars.bonus_e_chips}}
    end
    if specific_vars and specific_vars.bonus_e_mult then
        localize{type = 'other', key = 'card_extra_e_mult', nodes = desc_nodes, vars = {specific_vars.bonus_e_mult}}
    end
end

function UNIK.add_bonus(type,value)
    if not G.GAME.unik_base_camp_bonus then
        G.GAME.unik_base_camp_bonus = {
            e_mult = 0,
            e_chips = 0,
            chips = 0,
            mult = 0,
            dollars = 0,
            x_mult = 0,
            x_chips = 0,
        }
    end
    if G.GAME.unik_base_camp_bonus[type] then
        if type == 'e_mult' or type == 'e_chips' or type == 'dollars' then
            G.GAME.unik_base_camp_bonus[type] = G.GAME.unik_base_camp_bonus[type] + value
        else
            G.GAME.unik_base_camp_bonus[type] = G.GAME.unik_base_camp_bonus[type] + value * 2
        end
        
        return true
    end
    print("ADDING BONUS GLOBALLY FAILED!")
    return false
end