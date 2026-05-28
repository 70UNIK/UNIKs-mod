--copies the effect of the blind to the right 2 times --> 4 times
BLINDSIDE.Blind({
    key = 'unik_blindside_tracer',
    atlas = 'unik_blindside_blinds',
    pos = {x = 1,y=8},
    config = {
        block_recursive_napkin = true,
        extra = {
            value = 18,
            times = 2,
            times_up = 1, --nerf to only upgrade by 1 due to it's already broken ability with recursive copying
        }},
    hues = {"Faded"},
    always_scores = true,
    calculate = function(self, card, context) 
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
            local index = -1
            for i = 1, #areacards do
                if areacards[i] == card then
                    index = i
                end
            end
            if areacards and index > 0 and index < #areacards and areacards[index+1] then
                --print("copying " .. areacards[1].config.center.key)
                if not UNIK.detect_bp_loop(card,areacards,index+1) then
                    areacards[index+1].ability.block_scaling_copied = true
                    for k = 1, card.ability.extra.times do
                        local effect = UNIK.blueprint_enhancement(card, areacards[index+1], context)
                        -- if effect and effect.card and effect.card == card then
                        --     break
                        -- end
                        if effect then
                            effect.colour = G.C.DARK_EDITION
                            effect.card = card
                        end
                        effects_table[#effects_table+1] = effect
                        
                    end
                    areacards[index+1].ability.block_scaling_copied = nil
                else
                   -- print("LOOP DETECTED ABORTING!")
                    effects_table = {}
                end
            end
            
            
        end
        return SMODS.merge_effects(effects_table)
    end,
    rare = true,
    loc_vars = function(self, info_queue, card)
        local cardarea = card.area and card.area.cards or nil
        if G.play and card.area == G.play then
            local text,disp_text,poker_hands,scoring_hand,non_loc_disp_text = G.FUNCS.get_poker_hand_info(G.play.cards)
            cardarea = scoring_hand
        end
        local index = -1
        if card.added_to_deck and  cardarea then
             for i = 1, #cardarea do
                if cardarea[i] == card then
                    index = i
                end
            end
        end
       
        if card.added_to_deck and cardarea and index > 0 and index < #cardarea and cardarea[index+1] then
            card.ability.napkintype = localize({type = 'name_text', key = cardarea[index+1].config.center.key, set = 'Enhanced'})
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