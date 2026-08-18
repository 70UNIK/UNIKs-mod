--sadistic sword
--Always shuffled to the top of the deck
--When held, If hand contains only 1 blind, retrigger and rescore it 4 times. --> 6 times
--burns when held
BLINDSIDE.Blind({
    key = 'unik_blindside_legendary_silver_sword',
    atlas = 'unik_blindside_legendary_blinds',
    pos = {x = 0, y = 3},
    config = {
        extra = {
            value = 1,
            copies = 0,
            copies_up = 1,
            repetitions = 3,
            retain = true,
        }},
    hues = {"Faded","Blue"},
    always_scores = true,
    calculate = function(self, card, context) 
        local effects_table = {}
        if context.cardarea == G.play and context.after and card.facing ~= 'back' and not context.blueprint then
            card.ability.extra.copies = card.ability.extra.copies + card.ability.extra.copies_up
            return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.DARK_EDITION,
                }
        end
        if context.unik_after_effect and context.scoring_hand and card.ability.extra.upgraded then
            return {
                rescore = card.ability.extra.repetitions
            }
        end
        if card.area and card.added_to_deck then
            local areacards = card.area.cards
            --G.discard, such as the bell
            if card.highlighted and (card.area == G.hand) and G.hand and G.hand.highlighted then
                areacards = G.hand
            end
            if card.area == G.play and context and context.scoring_hand then
                areacards = context.scoring_hand
            end
            if areacards and areacards[1] and areacards[1] ~= card 
            and (areacards[1].config.center.key ~= 'm_unik_blindside_napkin' and areacards[1].config.center.key ~= 'm_unik_blindside_legendary_silver_sword') then
                for i,v in pairs(areacards) do
                    v.bp_iterations = 0
                end
                if card.ability.extra.copies > 0 and not UNIK.detect_bp_loop(card,areacards,1) then
                    --print("copying " .. areacards[1].config.center.key)
                    areacards[1].ability.block_scaling_copied = true
                    for k = 1,  card.ability.extra.copies do
                        local effect = UNIK.blueprint_enhancement(card, areacards[1], context)
                        if effect then
                            effect.colour = G.C.DARK_EDITION
                            effect.card = card
                        end
                        effects_table[#effects_table+1] = effect
                        
                    end
                    areacards[1].ability.block_scaling_copied = nil
                else
                   -- print("LOOP DETECTED ABORTING!")
                    effects_table = {}
                end
                
            end
            
            
        end
        return SMODS.merge_effects(effects_table)
    end,
    unik_exotic = true,
    loc_vars = function(self, info_queue, card)
        if card.ability.extra.upgraded then
            info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
        end
        
        info_queue[#info_queue+1] = {key = 'bld_retain', set = 'Other'}
        

        local cardarea = card.area and card.area.cards or nil
        if G.play and card.area == G.play then
            local text,disp_text,poker_hands,scoring_hand,non_loc_disp_text = G.FUNCS.get_poker_hand_info(G.play.cards)
            cardarea = scoring_hand
        end
        
        
        if card.added_to_deck and cardarea and cardarea[1] and cardarea[1] ~= card 
        and (cardarea[1].config.center.key ~= 'm_unik_blindside_napkin' and cardarea[1].config.center.key ~= 'm_unik_blindside_legendary_silver_sword') then
            if card.ability.extra.copies > 0 then
                card.ability.napkintype = localize({type = 'name_text', key = cardarea[1].config.center.key, set = 'Enhanced'})
                card.ability.colour = G.C.DARK_EDITION
            else
                card.ability.napkintype = "Inactive"
                card.ability.colour = G.C.MULT
            end
            
        else
            card.ability.napkintype = "Incompatible"
            card.ability.colour = G.C.MULT
        end
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_legendary_silver_sword_upgraded' or 'm_unik_blindside_legendary_silver_sword',
            vars = {
                card.ability.extra.repetitions, card.ability.extra.copies, card.ability.extra.copies_up
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
            card.ability.extra.upgraded = true
        end
    end
})