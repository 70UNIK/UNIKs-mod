--copies the effect of the leftmost blind in the area 3 times, always scores
local scaler = SMODS.scale_card
function SMODS.scale_card(card, args)
    if card.ability.block_recursive_napkin or card.ability.block_scaling_copied then return end
    local ret = scaler(card, args)
    return ret
end
BLINDSIDE.Blind({
    key = 'unik_blindside_napkin',
    atlas = 'unik_blindside_blinds',
    pos = {x = 5,y=7},
    config = {
        block_recursive_napkin = true,
        extra = {
            value = 18,
            times = 3,
            times_up = 2,
        }},
    hues = {"Faded"},
    always_scores = true,
    calculate = function(self, card, context) 
        -- finity inspired code, see if it works... OR NOT
        if context.blueprint_card then
            return
        end
        local effects_table = {}
        if card.area and card.added_to_deck then
            local areacards = card.area.cards
            --G.discard, such as the bell
            if card.highlighted and (card.area == G.hand or card.area == G.discard) and G.hand and G.hand.highlighted then
                areacards = G.hand
            end
            if card.area == G.play and context and context.scoring_hand then
                areacards = context.scoring_hand
            end
            if areacards and areacards[1] and areacards[1] ~= card and areacards[1].config.center.key ~= 'm_unik_blindside_napkin' then
                --print("copying " .. areacards[1].config.center.key)
                areacards[1].ability.block_scaling_copied = true
                for k = 1, card.ability.extra.times do
                    local effect = UNIK.blueprint_enhancement(card, areacards[1], context)
                    if effect then
                        effect.colour = G.C.DARK_EDITION
                        effect.card = card
                    end
                    effects_table[#effects_table+1] = effect
                    
                end
                areacards[1].ability.block_scaling_copied = nil
            end
            
            
        end
        return UNIK.blueprint_multiple_times(effects_table,1)
    end,
    rare = true,
    loc_vars = function(self, info_queue, card)
        local cardarea = card.area and card.area.cards or nil
        if G.play and card.area == G.play then
            local text,disp_text,poker_hands,scoring_hand,non_loc_disp_text = G.FUNCS.get_poker_hand_info(G.play.cards)
            cardarea = scoring_hand
        end
        
        if card.added_to_deck and cardarea and cardarea[1] and cardarea[1] ~= card and cardarea[1].config.center.key ~= 'm_unik_blindside_napkin' then
            card.ability.napkintype = localize({type = 'name_text', key = cardarea[1].config.center.key, set = 'Enhanced'})
            card.ability.colour = G.C.DARK_EDITION
        else
            card.ability.napkintype = "Incompatible"
            card.ability.colour = G.C.MULT
        end
        return {
            vars = {
                card.ability.extra.times, 
            },
            main_end = (card.area and card.added_to_deck) and {
				{
					n = G.UIT.C,
					config = { align = "bm", minh = 0.4 },
					nodes = {
						{
							n = G.UIT.C,
							config = {
								ref_table = card,
								align = "m",
								-- colour = (check and G.C.cry_epic or G.C.JOKER_GREY),
								colour = card.ability.colour,
								r = 0.05,
								padding = 0.08,
								func = "blueprint_compat",
							},
							nodes = {
								{
									n = G.UIT.T,
									config = {
										ref_table = card.ability,
										ref_value = "napkintype",
										colour = G.C.UI.TEXT_LIGHT,
										scale = 0.32 * 0.8,
									},
								},
							},
						},
					},
				},
			} or nil,
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.times = card.ability.extra.times + card.ability.extra.times_up
            card.ability.extra.upgraded = true
        end
    end
})

function UNIK.blueprint_multiple_times(table_return_table, index)
    local ret = table_return_table[index]
    if index <= #table_return_table then
        local function getDeepest(tbl)
            tbl = tbl or {}
            while tbl.extra do
                tbl = tbl.extra
            end
            return tbl
        end
        local prev = getDeepest(ret)
        prev.extra = UNIK.blueprint_multiple_times(table_return_table, index + 1)
    end
    return ret
end

function UNIK.blueprint_enhancement(copier, copied_card, context)
    if not copied_card or copied_card == copier or copied_card.debuff or context.no_blueprint then return end
    if (context.blueprint or 0) > #copier.area.cards then return end
        --copied_card.ability.block_scaling_copied = true
        local old_context_blueprint = context.blueprint
        context.blueprint = (context.blueprint or 0) + 1
        local old_context_blueprint_card = context.blueprint_card
        context.blueprint_card = context.blueprint_card or copier
        context.blueprint_copiers_stack = context.blueprint_copiers_stack or {}
        context.blueprint_copiers_stack[#context.blueprint_copiers_stack+1] = copier
        context.blueprint_copier = context.blueprint_copiers_stack[#context.blueprint_copiers_stack]
        local eff_card = context.blueprint_card
        
        local eval = eval_card(copied_card, context)
        context.blueprint = old_context_blueprint
        context.blueprint_card = old_context_blueprint_card
        table.remove(context.blueprint_copiers_stack, #context.blueprint_copiers_stack)
        context.blueprint_copier = context.blueprint_copiers_stack[#context.blueprint_copiers_stack]
        local ret = {}
        for k, v in pairs(eval) do
            if type(v) == 'table' and (k == 'playing_card' or k == 'enhancement' or k == 'end_of_round') then
                if not v.card then v.card = eff_card end
                v.card = eff_card
                ret[#ret+1] = v
               -- print(v)
            end
        end
        --copied_card.ability.block_scaling_copied = nil
        return SMODS.merge_effects(ret)
end
--eval G.hand.cards[1]:set_ability('m_unik_blindside_napkin')