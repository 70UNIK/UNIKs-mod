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

--Applies perma bonuses
---@param args { base_1: boolean?, type:string,message_key:string?,message_function:function?,no_message:boolean?,cards:table,value:number,from_card:table?,message_colour:any}
function UNIK.add_perma_bonus(args)
    local base = args.base_1 or false
    local type = args.type
    local message_key = args.message_key or nil
    local message_colour = args.message_colour or G.C.MULT
    local message_function = args.message_function or nil --custom message function
    local no_message = args.no_message or nil
    local cards = args.cards
    local value = args.value
    local from_card = args.from_card or nil
    if type == 'perma_h_x_mult' or
    type == 'perma_h_x_chips' or 
    type == 'perma_e_chips' or 
    type == 'perma_e_mult' or 
    type == 'perma_x_chips' or
    type == 'perma_x_mult' then
        base = true
    end
    for i = 1, #cards do
        local highlighted = cards[i]
            highlighted.ability[type] = highlighted.ability[type] or 0
            highlighted.ability[type] = highlighted.ability[type] + value
        if not no_message then
            if (type == 'perma_h_dollars' or type == 'perma_p_dollars') and not message_function then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after', 
                    delay = 0.1, 
                    func = function()
                    card_eval_status_text(highlighted, "extra", nil, nil, nil, {
                        message = '$' .. highlighted.ability[type],
                        colour = G.C.GOLD,
                        card=highlighted,
                    })
                    return true 
                    end 
                }))
            else
                if message_function and type(message_function) == 'func' then
                    message_function()
                else
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after', 
                        delay = 0.1, 
                        func = function()
                        card_eval_status_text(highlighted, "extra", nil, nil, nil, {
                            message = localize({
                                type = "variable",
                                key = message_key,
                                vars = { number_format((base and 1 or 0)+highlighted.ability[type]) },
                            }),
                            colour = message_colour,
                            card=highlighted,
                        })
                        return true 
                        end 
                    }))
                end
            end
        end 
        SMODS.calculate_context({unik_apply_bonus = true, unik_apply_type = type, unik_apply_value = value, unik_from_card = from_card})
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